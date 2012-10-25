require 'test/unit'
require_relative '../compiler.rb'
require_relative '../function_eval.rb'
require_relative '../variable_eval.rb'

class FunctionTests < Test::Unit::TestCase
  def test_eval_output
    FunctionEval.new("test", Evaluator.new).eval
    assert_equal MPPCompiler.last, <<EOS
:test
SET X, SP
ADD SP, 0
SET A, 0
SET SP, X
SET PC, POP
EOS
  end

  def test_with_memory
    var = DefineVariableEval.new("int", "test")
    FunctionEval.new("testFunc", var).eval
    assert_equal MPPCompiler.last, <<EOS
:testFunc
SET X, SP
ADD SP, 1
SET A, 0
SET SP, X
SET PC, POP
EOS
  end
end
