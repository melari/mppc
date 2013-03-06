class Evaluator
    def eval
        nil
    end

    def memory #required amount of stack memory (in words).
        0
    end
end

class EvalList < Evaluator
  def initialize(first)
    @evals = [first]
  end

  def add_member(evaluator)
    @evals << evaluator
    self
  end

  def eval
    @evals.each do |evaluator|
      evaluator.eval
    end
  end
end
