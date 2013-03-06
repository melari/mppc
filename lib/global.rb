require_relative 'evaluator.rb'
require_relative 'term.rb'

class GlobalDefineEval < Evaluator
  def initialize(type, name, value)
    @type = type
    @name = name
    @value = value
  end

  def eval
    global = Global.new(Type.parse(@type), @name)
    MPPCompiler.out "DAT #{@value.eval.value}", @name
  end
end

class Global < Term
  @@globals = {}
  @@mem_location = nil

  def initialize(type, name)
    super(type)
    @name = name
    if @@globals.include? name
      throw "Global #{name} is previously declared."
    end
    @@globals[name] = self
    @@mem_location = MPPCompiler.boot_size if @@mem_location.nil?
    reserve_memory
  end

  def location
    :memory
  end

  def value
    "[#{@mem_location}]" 
  end

  def reference_value
    @mem_location
  end

  def dereference_value
    reg = Variable.get_indirect_reg
    MPPCompiler.out "SET #{reg}, #{value}"
    IndirectRegister.new(@type, @name, reg)
  end

  def self.get(name)
    @@globals[name]
  end

  private 

  def reserve_memory
    @mem_location = @@mem_location
    @@mem_location += 1
  end
end
