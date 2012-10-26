require_relative 'evaluator.rb'
require_relative 'term_eval.rb'

class IfStatementEval < Evaluator
  @@token = 0
  def self.next_token
    @@token += 1
    "if#{@@token}"
  end

  def self.reset #resets to original state (used for unit tests).
    @@token = 0
  end

  def initialize(expression, statement)
    @expression = expression
    @statement = statement
  end

  def eval
    token = IfStatementEval.next_token
    term = @expression.eval
    MPPCompiler.out "IFE #{term.value}, 0"
    MPPCompiler.out "SET PC, #{token}"
    @statement.eval
    MPPCompiler.out ":#{token}"
  end

  def memory
    @statement.memory
  end
end
