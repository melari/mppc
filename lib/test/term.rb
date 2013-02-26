require 'test/unit'
require_relative '../compiler.rb'
require_relative '../term.rb'

class TermTests < Test::Unit::TestCase
#Ensure that we get back the correct value, when creating a literal with the default value for a given type.
  def test_default_types
    lit = Literal.new(:int, Type.get_default(:int))
    assert_equal(0, lit.value)
    lit2 = Literal.new(:bool, Type.get_default(:bool))
    assert_equal(0, lit.value)
  end

#Ensure that literals cannot be created with non-existing types.
  def test_non_real_type_literal
    assert_raise ArgumentError do
      Literal.new(:fake, 0)
    end
  end

#Ensure that registers cannot be specified to contain non-existing types.
  def test_non_real_type_register
    assert_raise ArgumentError do
      Literal.new(:fake, 0)
    end
  end

  def test_register_use_empty
    assert_equal 'A', Register.use_get(:int).value
  end

#Ensure that the register_use specification stack works as expected.
  def test_register_use
    Register.use 'B'
    assert_equal 'B', Register.use_get(:int).value
    Register.use 'C'
    assert_equal 'C', Register.use_get(:int).value
    Register.end_use
    assert_equal 'B', Register.use_get(:int).value
    Register.end_use
    assert_equal 'A', Register.use_get(:int).value
  end

#Ensure that register getters/setters work.
  def test_register_get_set
    reg = Register.new(:int, 'A')
    assert_equal 'A', reg.value
    reg.value = 'B'
    assert_equal 'B', reg.value
  end
end
