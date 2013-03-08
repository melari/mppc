#!/usr/bin/env ruby
require 'terrun'
require_relative 'compiler.rb'

class MPPC < TerminalRunner

  name "MPPC"

  param "input", "The MP+ file to compile"

  option "--help", 0, "", "Shows this help file."
  option "--output", 1, "<file>", "Sets the output file."
  option "--verbose", 0, "", "Show inline comments in the generated assembly."
  option "--binary", 0, "", "Run the compiled file through the assembler once finished."

  option_alias "--output", "-o"
  option_alias "--verbose", "-v"
  option_alias "--binary", "-b"

  help <<EOS
    Please make sure to read the README for information about this compiler.
    Read MPP_DOCS for information about MP+ in general.
EOS

  def self.run
    if @@options.include? "--help"
      show_usage
      exit
    end
    if @@options["--output"].nil?
      output = "a.out"
    else
      output = @@options["--output"][0]
    end

    unless File.exists? @@params["input"]
      puts "Cannot find input file '#{@@params["input"]}'"
      exit
    end

    MPPCompiler.run(@@params["input"], output, !@@options["--verbose"].nil?)

    if @@options.include? "--binary"
      `cp #{output} #{output}.tmp`
      system("ruby", "mppc-assembler/mppasm", "#{output}.tmp", output)
    end
  end
end

if __FILE__ == $0
  x = MPPC.start(ARGV)
end
