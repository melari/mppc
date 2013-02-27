require 'test/unit'
require_relative '../compiler.rb'
require_relative '../simple_operation.rb'

class SimpleOperationTests < Test::Unit::TestCase
  def setup
    @lit_10 = LiteralEval.new(:int, 10)
    @lit_20 = LiteralEval.new(:int, 20)
    @lit_30 = LiteralEval.new(:int, 30)
    @lit_true = LiteralEval.new(:bool, true)
    @lit_false = LiteralEval.new(:bool, false)
    @lit_u10 = LiteralEval.new(:uint, 10)
    @lit_u20 = LiteralEval.new(:uint, 20)
  end

  def test_non_existing_operation
    assert_raise TypeError do
      SimpleOperationEval.new(@lit_10, @lit_20, :fake)
    end
  end

  def test_mismatched_types
    assert_raise TypeError do
      SimpleOperationEval.new(@lit_10, @lit_true, :add).eval
    end
  end

  def test_add_eval
    reg = SimpleOperationEval.new(@lit_10, @lit_20, :add).eval
    assert_equal 'A', reg.value
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
ADD A, 20
EOS
  end

  def test_sub_eval
    SimpleOperationEval.new(@lit_10, @lit_20, :sub).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
SUB A, 20
EOS
  end

  def test_signed_mul_eval
    SimpleOperationEval.new(@lit_10, @lit_20, :mul).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
MLI A, 20
EOS
  end

  def test_unsigned_mul_eval
    SimpleOperationEval.new(@lit_u10, @lit_u20, :mul).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
MUL A, 20
EOS
  end

  def test_signed_div_eval
    SimpleOperationEval.new(@lit_10, @lit_20, :div).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
DVI A, 20
EOS
  end

  def test_unsigned_div_equal
    SimpleOperationEval.new(@lit_u10, @lit_u20, :div).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
DIV A, 20
EOS
  end

  def test_signed_mod_eval
    SimpleOperationEval.new(@lit_10, @lit_20, :mod).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
MDI A, 20
EOS
  end

  def test_unsigned_mod_eval
    SimpleOperationEval.new(@lit_u10, @lit_u20, :mod).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 10
MOD A, 20
EOS
  end

  def test_and_eval
    SimpleOperationEval.new(@lit_true, @lit_false, :and).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 1
AND A, 0
EOS
  end

  def test_bor_eval
    SimpleOperationEval.new(@lit_true, @lit_false, :bor).eval
    assert_equal MPPCompiler.last, <<EOS
SET A, 1
BOR A, 0
EOS
  end

#Ensure that something like 3*(5+10) parses correctly. Inspired by issue 4.
  def test_partial_results
    exp1 = SimpleOperationEval.new(@lit_10, @lit_20, :add)
    SimpleOperationEval.new(@lit_30, exp1, :mul).eval
    assert_equal MPPCompiler.last, <<EOS
SET B, 10
ADD B, 20
SET A, 30
MLI A, B
EOS
  end
end
