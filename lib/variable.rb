require_relative 'evaluator.rb'
require_relative 'term.rb'
require_relative 'simple_operation.rb'

class SetVariableEval < Evaluator
  def initialize(variable, value, modifier = :set)
    @variable = variable
    @value = value
    @modifier = modifier
  end

  def eval
    val = @value.eval
    ArrayVariable.lock if val.is_a? IndirectRegister
    var = @variable.eval
    ArrayVariable.free

    unless var.same_type? val
      raise TypeError, "Expecting #{var.type} but found #{val.type}"
    end
    MPPCompiler.out "#{SimpleOperationEval.command_map[@modifier][Type.is_signed? var.type]} #{var.value}, #{val.value}"
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
    var = Variable.get @name
    var
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
