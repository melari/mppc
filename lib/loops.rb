require_relative 'evaluator.rb'
require_relative 'term.rb'

class WhileLoopEval < Evaluator
  @@token = 0
  def self.next_token
    @@token += 1
    "while#{@@token}"
  end

  def initialize(expression, statement)
    @expression = expression
    @statement = statement
  end

  def eval
    start_token = WhileLoopEval.next_token
    end_token = WhileLoopEval.next_token

    MPPCompiler.out ":#{start_token}"
    term = @expression.eval
    MPPCompiler.out "IFE #{term.value}, 0"
    MPPCompiler.out "SET PC, #{end_token}"
    @statement.eval
    MPPCompiler.out "SET PC, #{start_token}"
    MPPCompiler.out ":#{end_token}"
  end

  def memory
    @statement.memory
  end
end

class ForLoopEval < Evaluator
  @@token = 0
  def self.next_token
    @@token += 1
    "while#{@@token}"
  end

  def initialize(initial_statement, conditional_expression, end_statement, body_statement)
    @initial_statement = initial_statement
    @conditional_expression = conditional_expression
    @end_statement = end_statement
    @body_statement = body_statement
  end

  def eval
    start_token = ForLoopEval.next_token
    end_token = ForLoopEval.next_token

    @initial_statement.eval
    MPPCompiler.out ":#{start_token}"
    reg = @conditional_expression.eval
    MPPCompiler.out "IFE #{reg.value}, 0"
    MPPCompiler.out "SET PC, #{end_token}"
    @body_statement.eval
    @end_statement.eval
    MPPCompiler.out "SET PC, #{start_token}"
    MPPCompiler.out ":#{end_token}"
  end

  def memory
    @initial_statement.memory + @end_statement.memory + @body_statement.memory
  end
end
