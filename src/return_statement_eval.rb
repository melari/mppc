require_relative 'return_statement_eval.rb'

class ReturnStatementEval < Evaluator
  def initialize(expression)
    @expression = expression
  end

  def eval
    MPPCompiler.out "SET A, #{@expression.eval.value}"
    MPPCompiler.out "SET SP, X"
    MPPCompiler.out "SET X, POP"
    MPPCompiler.out "SET PC, POP"
  end
end
