require_relative 'evaluator.rb'

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
    MPPCompiler.out ":#{@name}"
    @statement.eval
    MPPCompiler.out "SET A, 0"
    MPPCompiler.out "SET PC, POP"
  end
end
