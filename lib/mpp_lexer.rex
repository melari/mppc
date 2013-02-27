# MP+ Lexer
# Compile Instructions:
#   rex mpp_lexer.rex --stub
# Testing:
#   ruby mpp_lexer.rex.rb mpp_sample.mpp

class MPP
macro
    WHITESPACE  \s+
    ML_COM_IN   \/\*
    ML_COM_OUT  \*\/
    SL_COM      \#

rule


# Comments
                {ML_COM_IN}(.|\n)*(?={ML_COM_OUT}){ML_COM_OUT} // Multiline comments
                {SL_COM}.*(?=\n)                               // Singleline comments

# String Literals
                \"[^"]*\"                   { [:STRING, text[1..-2]] }
                \'[^']*\'                   { [:STRING, text[1..-2]] }

# Numerical Literals
                0x(\d|A|B|C|D|E|F|a|b|c|d|e|f)+   { [:HEX, text] }
                \d+                         { [:DECIMAL, text] }

# Keywords
                require                     { [:REQUIRE, text] }
                if                          { [:IF, text] }
                def                         { [:DEF, text] }
                do                          { [:DO, text] }
                end                         { [:END, text] }
                true                        { [:TRUE, text] }
                false                       { [:FALSE, text] }
                return                      { [:RETURN, text] }

# Types
                int                         { [:INT, text] }
                uint                        { [:UINT, text] }
                bool                        { [:BOOL, text] }

# Operators
                \=\=                        { [:EQUAL, text] }
                \!\=                        { [:NOT_EQUAL, text] }
                \<                          { [:LT, text] }
                \>                          { [:GT, text] }
                \<\=                        { [:LTE, text] }
                \>\=                        { [:GTE, text] }
                \&\&                        { [:AND, text] }
                \|\|                        { [:OR, text] }

# Whitespace
                {WHITESPACE}

# Identifiers
                \w+                         { [:IDENT, text] }
                .                           { [text, text] }

inner
    def tokenize(code)
        scan_evaluate code
        tokens = []
        while (token = next_token)
            tokens << token
        end
        tokens
    end

end
