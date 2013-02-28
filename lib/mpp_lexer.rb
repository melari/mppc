#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.2
# from lexical definition file "lib/mpp_lexer.rex".
#++

require 'racc/parser'
# MP+ Lexer
# Compile Instructions:
#   rex mpp_lexer.rex --stub
# Testing:
#   ruby mpp_lexer.rex.rb mpp_sample.mpp

class MPP < Racc::Parser
  require 'strscan'

  class ScanError < StandardError ; end

  attr_reader :lineno
  attr_reader :filename

  def scan_setup ; end

  def action &block
    yield
  end

  def scan_str( str )
    scan_evaluate  str
    do_parse
  end

  def load_file( filename )
    @filename = filename
    open(filename, "r") do |f|
      scan_evaluate  f.read
    end
  end

  def scan_file( filename )
    load_file  filename
    do_parse
  end

  def next_token
    @rex_tokens.shift
  end

  def scan_evaluate( str )
    scan_setup
    @rex_tokens = []
    @lineno  =  1
    ss = StringScanner.new(str)
    state = nil
    until ss.eos?
      text = ss.peek(1)
      @lineno  +=  1  if text == "\n"
      case state
      when nil
        case
        when (text = ss.scan(/\/\*(.|\n)*(?=\*\/)\*\//))
          ;

        when (text = ss.scan(/\#.*(?=\n)/))
          ;

        when (text = ss.scan(/\"[^"]*\"/))
           @rex_tokens.push action { [:STRING, text[1..-2]] }

        when (text = ss.scan(/\'[^']*\'/))
           @rex_tokens.push action { [:STRING, text[1..-2]] }

        when (text = ss.scan(/0x(\d|A|B|C|D|E|F|a|b|c|d|e|f)+/))
           @rex_tokens.push action { [:HEX, text] }

        when (text = ss.scan(/\d+/))
           @rex_tokens.push action { [:DECIMAL, text] }

        when (text = ss.scan(/require/))
           @rex_tokens.push action { [:REQUIRE, text] }

        when (text = ss.scan(/if/))
           @rex_tokens.push action { [:IF, text] }

        when (text = ss.scan(/def/))
           @rex_tokens.push action { [:DEF, text] }

        when (text = ss.scan(/do/))
           @rex_tokens.push action { [:DO, text] }

        when (text = ss.scan(/end/))
           @rex_tokens.push action { [:END, text] }

        when (text = ss.scan(/true/))
           @rex_tokens.push action { [:TRUE, text] }

        when (text = ss.scan(/false/))
           @rex_tokens.push action { [:FALSE, text] }

        when (text = ss.scan(/return/))
           @rex_tokens.push action { [:RETURN, text] }

        when (text = ss.scan(/while/))
           @rex_tokens.push action { [:WHILE, text] }

        when (text = ss.scan(/for/))
           @rex_tokens.push action { [:FOR, text] }

        when (text = ss.scan(/int/))
           @rex_tokens.push action { [:INT, text] }

        when (text = ss.scan(/uint/))
           @rex_tokens.push action { [:UINT, text] }

        when (text = ss.scan(/bool/))
           @rex_tokens.push action { [:BOOL, text] }

        when (text = ss.scan(/\+\=/))
           @rex_tokens.push action { [:PLUS_EQUAL, text] }

        when (text = ss.scan(/\-\=/))
           @rex_tokens.push action { [:MINUS_EQUAL, text] }

        when (text = ss.scan(/\=\=/))
           @rex_tokens.push action { [:EQUAL, text] }

        when (text = ss.scan(/\!\=/))
           @rex_tokens.push action { [:NOT_EQUAL, text] }

        when (text = ss.scan(/\</))
           @rex_tokens.push action { [:LT, text] }

        when (text = ss.scan(/\>/))
           @rex_tokens.push action { [:GT, text] }

        when (text = ss.scan(/\<\=/))
           @rex_tokens.push action { [:LTE, text] }

        when (text = ss.scan(/\>\=/))
           @rex_tokens.push action { [:GTE, text] }

        when (text = ss.scan(/\&\&/))
           @rex_tokens.push action { [:AND, text] }

        when (text = ss.scan(/\|\|/))
           @rex_tokens.push action { [:OR, text] }

        when (text = ss.scan(/\s+/))
          ;

        when (text = ss.scan(/\w+/))
           @rex_tokens.push action { [:IDENT, text] }

        when (text = ss.scan(/./))
           @rex_tokens.push action { [text, text] }

        else
          text = ss.string[ss.pos .. -1]
          raise  ScanError, "can not match: '" + text + "'"
        end  # if

      else
        raise  ScanError, "undefined state: '" + state.to_s + "'"
      end  # case state
    end  # until ss
  end  # def scan_evaluate

    def tokenize(code)
        scan_evaluate code
        tokens = []
        while (token = next_token)
            tokens << token
        end
        tokens
    end
end # class
