require_relative 'evaluator.rb'

class ArgumentListEval < Evaluator
  def initialize(statement)
    @statements = [statement]
  end

  def add_member(statement)
    @statements << statement
  end

  def eval
    @statements.each do |statement|
      statement.eval
    end
  end

  def memory
    result = 0
    @statements.each do |statement|
      result += statement.memory
    end
    result
  end

end
