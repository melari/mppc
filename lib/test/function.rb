require 'test/unit'
require_relative '../compiler.rb'
require_relative '../function_eval.rb'
require_relative '../variable_eval.rb'

class FunctionTests < Test::Unit::TestCase
  def teardown
    Function.reset
  end

  def test_eval_output
    FunctionEval.new("def", "test", Evaluator.new, Evaluator.new).eval
    assert_equal MPPCompiler.last, <<EOS
:f1
SET PUSH, X
SET PUSH, Y
SET X, SP
SUB SP, 0
SET Y, SP
SET A, 0
SET SP, X
SET Y, POP
SET X, POP
SET PC, POP
EOS
  end

  def test_with_memory
    var = DefineVariableEval.new("int", "test")
    FunctionEval.new("def", "testFunc", Evaluator.new, var).eval
    assert_equal MPPCompiler.last, <<EOS
:f1
SET PUSH, X
SET PUSH, Y
SET X, SP
SUB SP, 1
SET Y, SP
SET A, 0
SET SP, X
SET Y, POP
SET X, POP
SET PC, POP
EOS
  end

  def test_with_arguments
    var = DefineVariableEval.new("int", "test")
    FunctionEval.new("def", "testFunc", var, Evaluator.new).eval
    assert_equal MPPCompiler.last, <<EOS
:f1
SET PUSH, X
SET PUSH, Y
SET X, SP
SUB SP, 1
SET Y, SP
SET A, 0
SET SP, X
SET Y, POP
SET X, POP
SET PC, POP
EOS
  end

  def test_function_call
    FunctionEval.new("def", "testFunc", Evaluator.new, Evaluator.new)
    FunctionCallEval.new("testFunc", []).eval
    assert_equal MPPCompiler.last, <<EOS
JSR f1
EOS
  end

  def test_function_call_with_arguments
    var = DefineVariableEval.new("int", "test")
    FunctionEval.new("def", "testFunc", var, Evaluator.new)
    FunctionCallEval.new("testFunc", [LiteralEval.new(:int, 5)]).eval
    assert_equal MPPCompiler.last, <<EOS
SUB SP, 5
SET [SP+1], 5
ADD SP, 5
JSR f1
EOS
  end
end
