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

class FunctionEval < Evaluator
  def initialize(name, statement)
    @name = name
    @statement = statement
  end

  def eval
    Variable.new_scope
    MPPCompiler.out ":#{@name}"
    MPPCompiler.out "SET X, SP"
    MPPCompiler.out "SUB SP, #{@statement.memory}"
    @statement.eval
    MPPCompiler.out "SET A, 0"
    MPPCompiler.out "SET SP, X"
    MPPCompiler.out "SET PC, POP"
    Variable.end_scope
  end
end
