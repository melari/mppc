require 'evaluator.rb'

class Value 
  attr_accessor :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end
end

class TermEval < Evaluator

  def initialize(type, value)
    @value = Value.new(type, value)
  end

  def eval
    return @value
  end
end
