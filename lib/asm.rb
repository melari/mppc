class ASMEval < Evaluator
  def initialize(asm)
    @asm = asm
  end

  def eval
    MPPCompiler.out @asm.strip.gsub(/\n\s+/, "\n")
  end
end
