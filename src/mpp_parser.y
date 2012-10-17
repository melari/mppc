class MPP
rule
    
    target
        : require_list
        | function_list
        | require_list function_list
        | /* nothing */
        ;
        
    require_list
        : REQUIRE STRING { puts "ERROR: requires not yet supported."; exit }
        | require_list REQUIRE STRING
        ;
        
    function_list
        : function { result = FunctionListEval.new(val[0]) }
        | function_list function
          {
            val[0].add_member val[1]
            result = val[0]
          }
        ;
        
    function
        : DEF ident statement { result = FunctionEval.new(val[1], val[2]) }
        ;
        
    code_block
        : DO statement_list END { result = val[1] }
        | '{' statement_list '}' { result = val[1] }
        ;
    
    statement_list
        : statement { result = FunctionListEval.new(val[0]) }
        | statement_list statement
          {
            val[0].add_member val[1]
            result = val[0]
          }
        ;
        
    statement
        : code_block
        | variable_declare
        | variable_set
        | if_statement
        | return_statement
        ;
        
    variable_declare
        : type ident { result = DefineVariableEval.new(val[0], val[1]) }
        | type ident '=' expression 
          { 
            var = DefineVariableEval.new(val[0], val[1])
            result = SetVariableEval.new(var, val[3])
          }
        ;

    variable_set
        : ident '=' expression
          {
            var = GetVariableEval.new(val[0])
            result = SetVariableEval.new(var, val[2])
          }
        ;
        
    if_statement
        : IF '(' expression ')' statement
        ;

    return_statement
        : RETURN expression { result = ReturnStatementEval.new(val[1]) }
        ;
        
    term
        : ident { result = GetVariableEval.new(val[0]) }
        | '(' expression ')' { result = val[1] }
        | function_call
        | constant
        ;
        
    negation
        : '!' negation { result = SingleOperationEval.new(val[1], :negation) }
        | term
        ;
        
    unary
        : '+' unary { result = val[1] }
        | '-' unary { result = SingleOperationEval.new(val[1], :unary) }
        | negation
        ;
        
    mult
        : mult '*' unary { result = SimpleOperationEval.new(val[0], val[2], :mul) }
        | mult '/' unary { result = SimpleOperationEval.new(val[0], val[2], :div) }
        | mult '%' unary { result = SimpleOperationEval.new(val[0], val[2], :mod) }
        | unary
        ;
        
    add
        : add '+' mult { result = SimpleOperationEval.new(val[0], val[2], :add) }
        | add '-' mult { result = SimpleOperationEval.new(val[0], val[2], :sub) }
        | mult
        ;
        
    relation
        : add EQUAL add { result = SimpleOperationEval.new(val[0], val[2], :equals) }
        | add NOT_EQUAL add
        | add LT add
        | add GT add
        | add LTE add
        | add GTE add
        | add
        ;
        
    expression
        : expression AND relation
        | expression OR relation
        | relation
        ;
        
    function_call
        : ident '(' params ')'
        ;
        
    params
        : params ',' expression
        | expression
        | /* none */
        ;
    
    constant
        : DECIMAL { result = LiteralEval.new(:int, val[0].to_i) }
        | HEX     { result = LiteralEval.new(:int, val[0].hex) }
        | TRUE    { result = LiteralEval.new(:bool, true) }
        | FALSE   { result = LiteralEval.new(:bool, false) }
        ;
    
    ident
        : IDENT
        ;
        
    type
        : INT
        | BOOL
        ;
    
end

---- header
    require 'mpp_lexer.rb'
    require 'term_eval.rb'
    require 'single_operation_eval.rb'
    require 'simple_operation_eval.rb'
    require 'variable_eval.rb'
    require 'function_eval.rb'
    require 'return_statement_eval.rb'

---- inner
  #methods can be defined here...