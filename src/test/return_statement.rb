require 'test/unit'
require_relative '../compiler.rb'
require_relative '../return_statement_eval.rb'

class ReturnStatementTests < Test::Unit::TestCase
  def test_eval_output
    exp = LiteralEval.new(:int, 10)
    ReturnStatementEval.new(exp).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
SET SP, X
SET Y, POP
SET X, POP
SET PC, POP
EOS
  end
end
