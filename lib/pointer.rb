require_relative 'evaluator.rb'
require_relative 'term.rb'
require_relative 'variable.rb'

class GetPointerEval < GetVariableEval
  def eval
    var = Variable.get @name
    var.dereference_value
  end
end

class GetReferenceEval < GetVariableEval
  def eval
    var = Variable.get @name
    var.reference_value
  end
end
