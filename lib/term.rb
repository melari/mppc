require_relative 'evaluator.rb'

class Type
  @@types = { :int =>  { :signed => true,
                         :default => 0 },
              :uint => { :signed => false,
                         :default => 0 },
              :bool => { :signed => false,
                         :default => 0 },
              :none => { :signed => false,
                         :default => 0 }
            }


  def self.is_signed?(type)
    @@types[type][:signed]
  end

  def self.get_default(type)
    @@types[type][:default]
  end

  def self.exists?(type)
    @@types.has_key? type
  end

  def self.parse(type)
  case type
    when "int"
      return :int
    when "uint"
      return :uint
    when "bool"
      return :bool
    when "def"
      return :none
    else
      raise TypeError, "Unknown type #{type}"
    end
  end
end

class Term
  attr_accessor :type

  def initialize(type)
    throw TypeError, "Unknown type #{type}" unless Type.exists? type
    @type = type
  end

  def location
    :none
  end

  def value
  end

  def same_type?(term)
    term.type == type
  end

  def signed?
    Type.is_signed? @type
  end
end

class Literal < Term
  def initialize(type, value)
    super(type)
    @value = value
  end

  def location
    :literal
  end

  def value
    case @type
    when :int
      return @value
    when :uint
      return @value
    when :bool
      return @value ? 1 : 0
    end
  end
end

class Variable < Term
  @@variables = {}

  @@scope=[]

  def initialize(type, name, size = 1)
    super(type)
    @name = name
    @size = size
    @index = nil
    if @@variables.include? name
      throw "Variable #{name} is previously declared."
    end
    @@variables[name] = self
  end

  def location
    :memory
  end

  def reserve_memory
    @mem_location = @@scope.pop - @size + 1
    @@scope.push @mem_location-1
  end

  def value
    if @mem_location.nil?
      throw "Variable.value referenced before reserving memory."
    end
    if @index.nil?
      return "[Y]" if @mem_location == 0
      return "[Y+#{@mem_location}]"
    else
      if @index.location == :literal
        offset = @mem_location + @index.value.to_i
        return "[Y]" if @mem_location == 0
        return "[Y+#{offset}]"
      else
        MPPCompiler.out "SET I, Y"
        MPPCompiler.out "ADD I, #{@index.value}"
        return "[I]" if @mem_location == 0
        return "[I+#{@mem_location}]"
      end
    end
  end

  def index=(index)
    @index = index
  end

  def self.new_scope(scope_size)
    @@scope.push scope_size-1
  end

  def self.end_scope
    @@scope.pop
    @@variables = {}
  end

  def self.get(name)
    throw "Unknown variable #{name}." if @@variables[name].nil?
    @@variables[name]
  end
end

class Register < Term
  def initialize(type, name)
    super(type)
    @name = name
  end

  def location
    :register
  end

  def value
    @name
  end

  def value=(x)
    @name = x
  end

  @@use_stack = []

  def self.use(name)
    @@use_stack.push name
  end

  def self.use_get(type)
    return Register.new(type, 'A') if @@use_stack.empty?
    Register.new(type, @@use_stack[-1])
  end

  def self.end_use
    @@use_stack.pop
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
