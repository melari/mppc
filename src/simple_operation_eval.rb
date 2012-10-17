require 'evaluator.rb'
require 'term_eval.rb'

class SimpleOperationEval < Evaluator
  def initialize(exp1, exp2, operation)
    @exp1 = exp1
    @exp2 = exp2
    @operation = operation
  end
    
  def eval
    case @operation
    when :add
      term1 = @exp1.eval
      term2 = @exp2.eval
      MPPCompiler.out "SET A, #{term1.value}"
      MPPCompiler.out "ADD A, #{term2.value}"
      return Register.new(term1.type, 'A')
    when :sub
      @op1.eval - @op2.eval
    when :mul
      @op1.eval * @op2.eval
    when :div
      @op1.eval / @op2.eval
    when :mod
      @op1.eval % @op2.eval
    when :equals
      @op1.eval == @op2.eval
    end
  end
end
