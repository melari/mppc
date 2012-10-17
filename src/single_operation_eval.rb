require 'evaluator.rb'

class SingleOperationEval < Evaluator
    def initialize(op, operation)
        @op = op
        @operation = operation
    end
    
    def eval
        case @operation
        when :unary
            -@op.eval
        when :negation
            !@op.eval
        end
    end

end