require_relative 'evaluator.rb'
require_relative 'term_eval.rb'

class ComparisonOperationEval < Evaluator
  @@token = 0
  def self.next_token
    @@token += 1
    "coe#{@@token}"
  end

  @@command_map = { :equal => { true => "IFE", false => "IFE" },
                    :not_equal => { true => "IFN", false => "IFN" },
                    :lt => { true => "IFU", false => "IFL" },
                    :gt => { true => "IFA", false => "IFG" }
                  }

  def initialize(exp1, exp2, operation)
    @exp1 = exp1
    @exp2 = exp2
    @operation = operation
  end

  def eval
    term1 = @exp1.eval

    if term1.location == :register
      MPPCompiler.out "SET PUSH, #{term1.value}"
      term1.value = "POP"
    end

    Register.use 'B'
    term2 = @exp2.eval
    Register.end_use

    reg = Register.use_get(:bool)
    command = @@command_map[@operation][term1.signed?]
    true_token = ComparisonOperationEval.next_token
    end_token = ComparisonOperationEval.next_token
    MPPCompiler.out "#{command} #{term1.value}, #{term2.value}"
    MPPCompiler.out "SET PC, #{true_token}"
    MPPCompiler.out "SET #{reg.value}, 0"
    MPPCompiler.out "SET PC, #{end_token}"
    MPPCompiler.out ":#{true_token}"
    MPPCompiler.out "SET #{reg.value}, 1"
    MPPCompiler.out ":#{end_token}"
    return reg
  end
end
