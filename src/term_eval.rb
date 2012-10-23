require_relative 'evaluator.rb'

class Type
  @@types = { :int =>  { :signed => true,
                         :default => 0 },
              :uint => { :signed => false,
                         :default => 0 },
              :bool => { :signed => false,
                         :default => 0 }
            }


  def self.is_signed?(type)
    @@types[type][:signed]
  end

  def self.get_default(type)
    @@types[type][:default]
  end
end

class Term
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def location
    :none
  end

  def value
  end

  def same_type?(term)
    term.type == type
  end

  def signed?
    Type.is_signed? @type
  end
end

class Literal < Term
  def initialize(type, value)
    super(type)
    @value = value
  end

  def location
    :literal
  end

  def value
    case @type
    when :int
      return @value
    when :bool
      return @value ? 1 : 0
    end
  end
end

class Variable < Term
  @@variables = {}

  @@scope=[]

  def initialize(type, name)
    super(type)
    @name = name
    @@variables[name] = self
  end

  def location
    :memory
  end
  
  def reserve_memory
    @mem_location = @@scope.pop
    @@scope.push @mem_location+1
  end

  def value
    if @mem_location.nil?
      puts "ERROR: Variable.value referenced before reserving memory."
      exit
    end
    "[SP+#{@mem_location}]"
  end

  def self.new_scope
    @@scope.push 1
  end

  def self.end_scope
    @@scope.pop
  end

  def self.get(name)
    @@variables[name]
  end
end

class Register < Term
  def initialize(type, name)
    super(type)
    @name = name
  end

  def location
    :register
  end
  
  def value
    @name
  end

  def value=(x)
    @name = x
  end

  @@use_stack = []

  def self.use(name)
    @@use_stack.push name
  end

  def self.use_get(type)
    return Register.new(type, 'A') if @@use_stack.empty?
    Register.new(type, @@use_stack[-1])
  end

  def self.end_use
    @@use_stack.pop
  end
end

class LiteralEval < Evaluator

  def initialize(type, value)
    @literal = Literal.new(type, value)
  end

  def eval
    return @literal
  end
end
