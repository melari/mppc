require_relative 'evaluator.rb'
require_relative 'term.rb'

class StringGenEval < Evaluator
  def initialize(name, string)
    @name = name
    @string = string + 0.chr
  end

  def eval
    variable = DefineArrayEval.new("int", @name, @string.length).eval
    offset = variable.mem_location
    @string.each_byte do |char|
      offset += 1
      MPPCompiler.out "SET [Y+#{offset}], #{char+0xF000}"
    end
  end

  def memory
    @string.length + 1
  end
end

class IntGenEval < Evaluator
  def initialize(name, values)
    @name = name
    @values = values
  end

  def eval
    variable = DefineArrayEval.new("int", @name, @values.length).eval
    offset = variable.mem_location
    @values.each do |val|
      offset += 1
      MPPCompiler.out "SET [Y+#{offset}], #{val}"
    end
  end

  def memory
    @values.length + 1
  end
end
