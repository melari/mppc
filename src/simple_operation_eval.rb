require_relative 'evaluator.rb'
require_relative 'term_eval.rb'

class SimpleOperationEval < Evaluator
  def initialize(exp1, exp2, operation)
    @exp1 = exp1
    @exp2 = exp2
    @operation = operation
  end

  def eval
    term1 = @exp1.eval
    term2 = @exp2.eval

    unless [:int, :uint].include? term1.type
      puts "Cannot apply #{@operation} operation to type #{term1.type}"
      exit
    end

    unless term1.same_type? term2
      puts "**ERROR: Expecting #{term1.type} but found #{term2.type}**"
      exit
    end

    case @operation
    when :add
      op = "ADD"
    when :sub
      op = "SUB"
    when :mul
      op = "MLI"
    when :div
      op = "DVI"
    when :mod
      op = "MDI"
    end

    MPPCompiler.out "SET A, #{term1.value}"
    MPPCompiler.out "#{op} A, #{term2.value}"
    return Register.new(term1.type, 'A')
  end
end
