require 'test/unit'
require_relative '../compiler.rb'
require_relative '../variable_eval.rb'

class VariableTests < Test::Unit::TestCase
  @bool_var
  @int_var
  @int_lit
  @bool_lit

  def setup
    Variable.new_scope
    @bool_var = DefineVariableEval.new("bool", "test")
    @int_var = DefineVariableEval.new("int", "test2")
    @bool_lit = LiteralEval.new(:bool, true)
    @int_lit = LiteralEval.new(:int, 10)
  end

  def teardown
    Variable.end_scope
  end

  def test_set_unmatched_type
    set = SetVariableEval.new(@bool_var, @int_lit)
    assert_raise RuntimeError do
      set.eval
    end
  end

  def test_set_eval
    set = SetVariableEval.new(@int_var, @int_lit)
    set.eval
    assert_equal "SET [SP], 10\n", MPPCompiler.last
  end
end
