require 'mpp_lexer.rb'
require 'mpp_parser.rb'
require 'variable_eval.rb'

class MPPCompiler
    def self.run(input, output)
        @parser = MPP.new
        @@out = File.open(output, "w")

        self.out "JSR main"
	self.out ":crash SET PC, crash"
        eval_tree = @parser.scan_file(input)
        eval_tree.eval
        Variable.generate_region
        @@out.close
    end

    def self.tokenize(input)
      @parser = MPP.new
      puts @parser.tokenize(input).inspect
    end

    def self.out(val)
      @@out.puts val
    end
end
