require 'test/unit'
require_relative '../compiler.rb'
require_relative '../single_operation.rb'

class SingleOperationTest < Test::Unit::TestCase
  def setup
    @unary = LiteralEval.new(:int, 10)
    @binary = LiteralEval.new(:bool, true)
  end

  def test_unary_negation
    reg = UnaryNegationEval.new(@unary).eval
    assert_equal 'A', reg.value
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
MLI A, -1
EOS
  end

  def test_binary_negation
    reg = BinaryNegationEval.new(@binary).eval
    assert_equal 'A', reg.value
    assert_equal MPPCompiler.last, <<EOS
IFE 1, 0
SET PC, bn1
SET A, 0
SET PC, bn2
:bn1
SET A, 1
:bn2
EOS
  end
end
