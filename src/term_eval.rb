require 'evaluator.rb'

class Term
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def value
  end

  def same_type?(term)
    term.type == type
  end
end

class Literal < Term
  def initialize(type, value)
    super(type)
    @value = value
  end

  def value
    case @type
    when :int
      return @value
    when :bool
      return @value ? 1 : 0
    end
  end
end

class Variable < Term
  @@def_values = { :int => 0, :bool => false }
  @@variables = {}

  def initialize(type, name)
    super(type)
    @name = name
    @@variables[name] = self
  end

  def value
    @name
  end

  def self.get(name)
    @@variables[name]
  end

  def self.generate_region
    @@variables.each do |name, variable|
      MPPCompiler.out ":#{variable.value} DAT 0"
    end
  end
end

class LiteralEval < Evaluator

  def initialize(type, value)
    @literal = Literal.new(type, value)
  end

  def eval
    return @literal
  end
end
