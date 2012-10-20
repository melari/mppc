require 'evaluator.rb'

class Type
  @@types = { :int =>  { :signed => true,
                         :default => 0 },
              :uint => { :signed => false,
                         :default => 0 },
              :bool => { :signed => false,
                         :default => 0 }
            }


  def self.is_signed?(type)
    @@types[type][:signed]
  end

  def self.get_default(type)
    @@types[type][:default]
  end
end

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
  @@variables = {}

  def initialize(type, name)
    super(type)
    @name = name
    @@variables[name] = self
  end

  def value
    "[#{@name}]"
  end

  def self.get(name)
    @@variables[name]
  end

  def self.generate_region
    @@variables.each do |name, variable|
      MPPCompiler.out ":#{name} DAT #{Type.get_default(variable.type)}"
    end
  end
end

class Register < Term
  def initialize(type, name)
    super(type)
    @name = name
  end

  def value
    @name
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
