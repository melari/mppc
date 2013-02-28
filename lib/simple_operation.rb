require_relative 'evaluator.rb'
require_relative 'term.rb'

class SimpleOperationEval < Evaluator
  @@command_map = { :set => { true => "SET", false => "SET" },
                    :add => { true => "ADD", false => "ADD" },
                    :sub => { true => "SUB", false => "SUB" },
                    :mul => { true => "MLI", false => "MUL" },
                    :div => { true => "DVI", false => "DIV" },
                    :mod => { true => "MDI", false => "MOD" },
                    :and => { true => "AND", false => "AND" },
                    :bor => { true => "BOR", false => "BOR" }
                  }
  def self.command_map
    @@command_map
  end


  def initialize(exp1, exp2, operation)
    @exp1 = exp1
    @exp2 = exp2
    unless @@command_map.has_key? operation
      raise TypeError, "Unknown operation #{operation}"
    end
    @operation = operation
  end

  def eval
    term1 = @exp1.eval

    if term1.location == :register
      MPPCompiler.out "SET PUSH, #{term1.value}"
      term1.value = "POP"
    end

    Register.use 'B'
    term2 = @exp2.eval
    Register.end_use

    unless term1.same_type? term2
      raise TypeError, "Expecting #{term1.type} but found #{term2.type}**"
    end
    op = @@command_map[@operation][Type.is_signed? term1.type]


    reg = Register.use_get(term1.type)
    MPPCompiler.out "SET #{reg.value}, #{term1.value}"
    MPPCompiler.out "#{op} #{reg.value}, #{term2.value}"
    reg
  end
end
