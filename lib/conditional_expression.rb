require_relative 'evaluator.rb'
require_relative 'term.rb'

class ConditionalExpressionEval < Evaluator
  @@token = 0
  def self.next_token
    @@token += 1
    "cex#{@@token}"
  end

  def initialize(condition, true_exp, false_exp)
    @condition = condition
    @true_exp = true_exp
    @false_exp = false_exp
  end

  def eval
    true_token = ConditionalExpressionEval.next_token
    end_token = ConditionalExpressionEval.next_token

    condition_term = @condition.eval
    MPPCompiler.out "IFE #{condition_term.value}, 1"
    MPPCompiler.out "SET PC, #{true_token}"
    false_term = @false_exp.eval
    reg = Register.use_get(false_term.type)
    MPPCompiler.out "SET #{reg.value}, #{false_term.value}"
    MPPCompiler.out "SET PC, #{end_token}"
    MPPCompiler.out ":#{true_token}"
    true_term = @true_exp.eval
    MPPCompiler.out "SET #{reg.value}, #{true_term.value}"
    MPPCompiler.out ":#{end_token}:"
    reg
  end
end
