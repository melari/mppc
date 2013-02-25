require_relative 'evaluator.rb'
require_relative 'term.rb'

class SetVariableEval < Evaluator
  def initialize(variable, value)
    @variable = variable
    @value = value
  end

  def eval
    var = @variable.eval # gives Variable < Term
    val = @value.eval    # gives Term
    unless var.same_type? val
      raise TypeError, "Expecting #{var.type} but found #{val.type}"
    end
    MPPCompiler.out "SET #{var.value}, #{val.value}"
  end

  def memory
    @variable.memory
  end
end

class GetVariableEval < Evaluator
  def initialize(name)
    @name = name
  end

  def eval
    Variable.get @name
  end
end

class DefineVariableEval < Evaluator
  def initialize(type, name)
    @type = type
    @name = name
  end

  def eval
    variable = Variable.new(Type.parse(@type), @name)
    variable.reserve_memory
    variable
  end

  def memory
    1
  end
end
