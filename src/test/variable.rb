require 'test/unit'
require_relative '../compiler.rb'
require_relative '../variable_eval.rb'

class VariableTests < Test::Unit::TestCase
  @bool_var
  @int_var
  @uint_var
  @int_lit
  @bool_lit

  def setup
    Variable.new_scope 10 #Size of scope does not really matter for tests.
    @bool_var = DefineVariableEval.new("bool", "test")
    @int_var = DefineVariableEval.new("int", "test2")
    @uint_var = DefineVariableEval.new("uint", "test3")
    @bool_lit = LiteralEval.new(:bool, true)
    @int_lit = LiteralEval.new(:int, 10)
  end

  def teardown
    Variable.end_scope
  end

#Ensure that mismatched types throw an exception
  def test_set_unmatched_type
    set = SetVariableEval.new(@bool_var, @int_lit)
    assert_raise TypeError do
      set.eval
    end
  end

#Ensure that variable setter generates correctly.
  def test_set_eval
    set = SetVariableEval.new(@int_var, @int_lit)
    set.eval
    assert_equal "SET [SP+9], 10\n", MPPCompiler.last
  end

#Ensure memory address locations are assigned correctly.
  def test_get_mem_locations
    @bool_var.eval
    @int_var.eval
    var1 = GetVariableEval.new("test").eval
    var2 = GetVariableEval.new("test2").eval
    assert_equal "[SP+9]", var1.value
    assert_equal "[SP+8]", var2.value
  end

#Ensure that variable memory locations reset after creating a new scope.
  def test_variable_scope
    @bool_var.eval
    Variable.new_scope 5
    @int_var.eval
    var1 = GetVariableEval.new("test").eval
    var2 = GetVariableEval.new("test2").eval
    assert_equal "[SP+9]", var1.value
    assert_equal "[SP+4]", var2.value
  end

#Ensure that an exception is thrown when defining a variable with a unacceptable type.
  def test_unknown_type
    assert_raise TypeError do
      DefineVariableEval.new("FAKE", "name").eval
    end
  end

#Ensure that SetVariableEval correctly determines the amount of required stack memory.
  def test_memory_size
    assert_equal 1, SetVariableEval.new(@int_var, @int_lit).memory
    get = GetVariableEval.new("test2")
    assert_equal 0, SetVariableEval.new(get, @int_lit).memory
  end

#Should not be able to get a Variable's value before its memory has been reserved.
  def test_reference_before_reserve
    var = Variable.new(:bool, "test")
    assert_raise ArgumentError do
      var.value
    end
    var.reserve_memory
    assert_nothing_raised ArgumentError do
      var.value
    end
  end
  
  def test_variable_not_defined
    get = GetVariableEval.new("fake")
    assert_raise ArgumentError do
      get.eval
    end
  end
end
