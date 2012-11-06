require 'test/unit'
require_relative '../compiler.rb'
require_relative '../variable_eval.rb'
require_relative '../term_eval.rb'

class IfStatementTests < Test::Unit::TestCase
  def setup
    @lit_10 = LiteralEval.new(:int, 10)
    @lit_20 = LiteralEval.new(:int, 20)
    @define_var_state = DefineVariableEval.new("int", "test")
    @set_var_state = SetVariableEval.new(@define_var_state, @lit_20)
    Variable.new_scope 10 #size of scope does not matter for tests.
  end

  def teardown
    Variable.end_scope
    IfStatementEval.reset
  end

  def test_tokens
    t1 = IfStatementEval.next_token
    t2 = IfStatementEval.next_token
    assert_not_equal t1, t2
  end

  def test_memory
    assert_equal 1, IfStatementEval.new(@lit_10, @define_var_state).memory
  end

  def test_eval
    IfStatementEval.new(@lit_10, @set_var_state).eval
    assert_equal MPPCompiler.last, <<EOS
IFE 10, 0
SET PC, if1
SET [SP+9], 20
:if1
EOS
  end
end
