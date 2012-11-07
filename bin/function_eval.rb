require_relative 'evaluator.rb'
require_relative 'term_eval.rb'

class FunctionListEval < Evaluator
  def initialize(function)
    @functions = [function]
  end

  def add_member(function)
    @functions << function
  end

  def eval
    @functions.each do |function|
      function.eval
    end
  end
end

class Function
  @@functions = {}

  @@token = 0
  def self.next_token
    @@token += 1
    "f#{@@token}"
  end
  
  def self.reset
    @@token = 0
  end
  
  def self.get(name)
    @@functions[name]
  end
  
  attr_accessor :type
  
  def initialize(type, name)
    @type = type
    @name = name
    @label = name == "main" ? "main" : Function.next_token
    @@functions[name] = self
  end
  
  def label
    @label
  end
end

class FunctionEval < Evaluator
  def initialize(type, name, arguments, statement)
    @function = Function.new(Type.parse(type), name)
    @arguments = arguments
    @statement = statement
  end

  def eval
    memory_req = @statement.memory + @arguments.memory
  
    Variable.new_scope memory_req
    MPPCompiler.out ":#{@function.label}"
    MPPCompiler.out "SET PUSH, X"
    MPPCompiler.out "SET PUSH, Y"
    MPPCompiler.out "SET X, SP"
    MPPCompiler.out "SUB SP, #{memory_req}"
    MPPCompiler.out "SET Y, SP"
    @arguments.eval
    @statement.eval
    MPPCompiler.out "SET A, 0"
    MPPCompiler.out "SET SP, X"
    MPPCompiler.out "SET Y, POP"
    MPPCompiler.out "SET X, POP"
    MPPCompiler.out "SET PC, POP"
    Variable.end_scope
  end
end

class FunctionCallEval < Evaluator
  def initialize(name, arguments)
    @name = name
    @arguments = arguments
  end
  
  def eval
    function = Function.get(@name)
    result_register = Register.use_get(function.type)
  
    unless result_register.value == 'A'
      MPPCompiler.out "SET PUSH, A"
    end
  
    unless @arguments.empty?
      mem_location = 1
      @arguments.each do |expression|
        term = expression.eval
        if term.location == :memory
          result_register.value = term.value
          term = result_register
        end
        MPPCompiler.out "SUB SP, #{@arguments.count+4}"
        MPPCompiler.out "SET [SP+#{mem_location}], #{term.value}"
        MPPCompiler.out "ADD SP, #{@arguments.count+4}"
        mem_location += 1
      end
    end
  
    MPPCompiler.out "JSR #{function.label}"
    
    unless result_register.value == 'A'
      MPPCompiler.out "SET #{result_register.value}, A"
      MPPCompiler.out "SET A, POP"
    end
    
    result_register
  end
end
