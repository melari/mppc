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
    var = @variable.eval # gives Variable < Term
    val = @value.eval    # gives Term
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
  def initialize(name, index_expression = nil)
    @name = name
    @index_expression = index_expression
  end

  def eval
    index = nil
    if @index_expression
      term = @index_expression.eval
      unless term.type == :int 
        raise TypeError, "Expecting int but found #{term.type}"
      end
      index = term
    end
    var = Variable.get @name
    var.index = index
    var
  end
end

class DefineVariableEval < Evaluator
  def initialize(type, name, size = 1)
    @type = type
    @name = name
    @size = size.to_i
  end

  def eval
    variable = Variable.new(Type.parse(@type), @name, @size)
    variable.reserve_memory
    variable
  end

  def memory
    @size
  end
end
