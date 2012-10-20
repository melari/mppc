require_relative 'evaluator.rb'
require_relative 'term_eval.rb'

class SetVariableEval < Evaluator
  def initialize(variable, value)
    @variable = variable
    @value = value
  end

  def eval
    var = @variable.eval # gives Variable < Term
    val = @value.eval    # gives Term
    unless var.same_type? val
      puts "ERROR: Expecting #{var.type} but found #{val.type}"
      exit
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
  def initialize(t, name)
    case t
    when "int"
      type = :int
    when "bool"
      type = :bool
    end
    @variable = Variable.new(type, name)
  end

  def eval
    @variable.reserve_memory
    @variable
  end

  def memory
    1
  end
end
