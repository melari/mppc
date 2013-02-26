require 'test/unit'
require_relative '../compiler.rb'
require_relative '../comparison_operation.rb'
require_relative '../simple_operation.rb'
require_relative '../term.rb'

class ComparisonOperationTests < Test::Unit::TestCase
  def setup
    @lit_10 = LiteralEval.new(:int, 10)
    @lit_20 = LiteralEval.new(:int, 20)
    ComparisonOperationEval.reset
  end

  def test_tokens
    t1 = ComparisonOperationEval.next_token
    t2 = ComparisonOperationEval.next_token
    assert_not_equal t1, t2
  end

  def test_eval_output
    ComparisonOperationEval.new(@lit_10, @lit_20, :equal).eval
    assert_equal MPPCompiler.last, <<EOS
IFE 10, 20
SET PC, coe1
SET A, 0
SET PC, coe2
:coe1
SET A, 1
:coe2
EOS
  end

  def test_eval_registers
    add = SimpleOperationEval.new(@lit_10, @lit_20, :add)
    Register.use 'B'
    ComparisonOperationEval.new(@lit_10, add, :not_equal).eval
    Register.end_use
    assert_equal MPPCompiler.last, <<EOS
SET B, 10
ADD B, 20
IFN 10, B
SET PC, coe1
SET B, 0
SET PC, coe2
:coe1
SET B, 1
:coe2
EOS
  end
end
