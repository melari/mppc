require_relative 'evaluator.rb'
require_relative 'term.rb'
require_relative 'variable.rb'

class GetArrayEval < GetVariableEval
  def initialize(name, index_expression)
    super(name)
    @index_expression = index_expression
  end

  def eval
    term = @index_expression.eval
    unless term.type == :int
      raise TypeError, "Expecting int but found #{term.type}."
    end
    var = Variable.get @name
    unless var.is_a? ArrayVariable
      raise TypeError, "Cannot index into a non-array type."
    end
    var.indexed_value(term)
  end
end

class DefineArrayEval < DefineVariableEval
  def initialize(type, name, size)
    super(type, name)
    @size = size.to_i
  end

  def eval
    variable = ArrayVariable.new(Type.parse(@type), @name, @size)
    variable.reserve_memory
    if @size > 0
      MPPCompiler.out "SET #{variable.value}, Y"
      MPPCompiler.out "ADD #{variable.value}, #{variable.mem_location}"
    end
    variable
  end

  def memory
    @size + 1
  end
end
