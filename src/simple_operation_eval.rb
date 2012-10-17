require 'evaluator.rb'

class SimpleOperationEval < Evaluator
    def initialize(op1, op2, operation)
        @op1 = op1
        @op2 = op2
        @operation = operation
    end
    
    def eval(result_register)
        case @operation
        when :add
            <<-EOS
            
            EOS
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
