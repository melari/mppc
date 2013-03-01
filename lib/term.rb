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

  def initialize(type, name, mem_location = nil)
    super(type)
    @name = name
    @size = 0
    @mem_location = mem_location
    if @@variables.include? name
      throw "Variable #{name} is previously declared."
    end
    @@variables[name] = self
  end

  def location
    :memory
  end

  def reserve_memory
    @mem_location = @@scope.pop - @size
    @@scope.push @mem_location-1
  end

  def mem_location
    @mem_location
  end

  def name
    @name
  end

  def value
    if @mem_location.nil?
      throw "Variable.value referenced before reserving memory."
    end
    return "[Y]" if @mem_location == 0
    return "[Y+#{@mem_location}]"
  end

  def reference_value
    reg = Variable.get_indirect_reg
    MPPCompiler.out "SET #{reg}, Y"
    MPPCompiler.out "ADD #{reg}, #{@mem_location}" unless @mem_location == 0
    Register.new(@type, reg)
  end

  def dereference_value
    reg = Variable.get_indirect_reg
    MPPCompiler.out "SET #{reg}, #{value}"
    IndirectRegister.new(@type, @name, reg)
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

  @@indirect_locked = false
  def self.lock_indirect
    @@indirect_locked = true
  end

  def self.free_indirect
    @@indirect_locked = false
  end

  def self.get_indirect_reg
    @@indirect_locked ? 'J' : 'I'
  end
end

class ArrayVariable < Variable
  def initialize(type, name, size)
    super(type, name)
    @size = size
  end

  def indexed_value(index)
    if @mem_location.nil?
      throw "Variable.value referenced before reserving memory."
    end
    reg = Variable.get_indirect_reg
    MPPCompiler.out "SET #{reg}, #{value}"
    MPPCompiler.out "ADD #{reg}, #{index.value}"
    MPPCompiler.out "ADD #{reg}, 1"
    IndirectRegister.new(@type, @name, reg)
  end

  @@locked = false
end

# Created by array.rb::GetArrayEval.eval
class IndirectRegister < Term
  def initialize(type, name, register)
    super(type)
    @name = name
    @register = register
  end

  def location
    :memory
  end

  def value
    "[#{@register}]"
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
