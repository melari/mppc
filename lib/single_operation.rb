require_relative 'evaluator.rb'
require_relative 'term.rb'

class UnaryNegationEval < Evaluator
  def initialize(exp)
    @exp = exp
  end

  def eval
    term = @exp.eval
    reg = Register.use_get(term.type)
    MPPCompiler.out "SET #{reg.value}, #{term1.value}"
    MPPCompiler.out "MLI #{reg.value}, -1"
    reg
  end
end


class BinaryNegationEval < Evaluator
  @@token = 0
  def self.next_token
    @@token += 1
    "bn#{@@token}"
  end

  def initialize(exp)
    @exp = exp
  end

  def eval
    term = @exp.eval
    false_token = BinaryNegationEval.next_token
    end_token = BinaryNegationEval.next_token
    reg = Register.use_get(term.type)
    MPPCompiler.out "IFE #{term.value}, 0"
    MPPCompiler.out "SET PC, #{false_token}"
    MPPCompiler.out "SET #{reg.value}, 0"
    MPPCompiler.out "SET PC, #{end_token}"
    MPPCompiler.out ":#{false_token}"
    MPPCompiler.out "SET #{reg.value}, 1"
    MPPCompiler.out ":#{end_token}"
    reg
  end
end
