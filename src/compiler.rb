require 'mpp_lexer.rb'
require 'mpp_parser.rb'
require 'variable_eval.rb'

class MPPCompiler
    def self.run(input, output)
        @variables = {}
   
        input = <<EOS
        require "lemio.mpp"
        def main do
            int myVar
            bool anotherVariable
            bool how_about_this_one_too
        end
        
        def test {
            int foo
            bool bar
        }
        
        def single line() //another useless function
        
        def line int faz //useless function
EOS

        input = <<EOS
        def main
        {
            int myVar = 1
            int mySecondVar = 5
            bool testBool = true
            myVar = mySecondVar
            return myVar
        }

        def single int faz = 10
EOS

        @parser = MPP.new
        puts @parser.tokenize(input).inspect
        puts "-----------------------------"

        
        @@out = File.open(output, "w")
        self.out "SET PC, main"
        eval_tree = @parser.scan_str(input)
        eval_tree.eval
        Variable.generate_region
        
        
        @@out.close
        puts "----------------------------"
    end

    def self.out(val)
      @@out.puts val
    end
end
