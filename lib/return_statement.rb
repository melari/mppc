class ReturnStatementEval < Evaluator
  def initialize(expression)
    @expression = expression
  end

  def eval
    ReturnStatementEval.render(@expression.eval.value)
  end

  def self.render(return_value)
    MPPCompiler.out "SET A, #{return_value}"
    MPPCompiler.out "SET SP, X"
    MPPCompiler.out "SET Y, POP"
    MPPCompiler.out "SET X, POP"
    MPPCompiler.out "SET PC, POP"
  end
end
