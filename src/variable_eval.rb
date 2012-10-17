require 'evaluator.rb'

class Variable
  @@def_values = { :int => 0, :bool => false }
  @@variables = {}

  attr_accessor :type, :name

  def initialize(type, name)
    @type = type
    @name = name
    @@variables[name] = self
  end

  def self.get(name)
    @@variables[name]
  end

  def self.generate_region
    @@variables.each do |name, variable|
      MPPCompiler.out ":#{variable.name} DAT 0"
    end
  end
end

class SetVariableEval < Evaluator
  def initialize(variable, value)
    @variable = variable
    @value = value
  end

  def eval
    var = @variable.eval # gives Variable
    val = @value.eval    # gives Value
    unless var.type == val.type
      puts "ERROR: Expecting #{var.type} but found #{val.type}"
      exit
    end
    MPPCompiler.out "SET #{var.name}, #{val.value}"
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
    @variable
  end
end
