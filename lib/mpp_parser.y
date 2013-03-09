class MPP
rule

    target
        : require_list
        | function_list
        | global_list
        | require_list global_list
        | require_list function_list
        | global_list function_list
          {
            result = EvalList.new(val[0])
            result.add_member(val[1])
          }
        | require_list global_list function_list
        | /* nothing */
        ;

    require_list
        : REQUIRE STRING
           {
             puts "ERROR: requires not yet supported."
             exit
           }
        | require_list REQUIRE STRING
        ;

    global_list
        : global_define { result = EvalList.new(val[0]) }
        | global_list global_define { result = val[0].add_member val[1] }
        | /* none */
        ;

   global_define
        : GLOBAL type ident '=' constant { result = GlobalDefineEval.new(val[1], val[2], val[4]) }
        ;

    function_list
        : function { result = FunctionListEval.new(val[0]) }
        | function_list function { result = val[0].add_member val[1] }
        ;

    function
        : type ident statement { result = FunctionEval.new(val[0], val[1], Evaluator.new, val[2]) }
        | type ident '(' arguments ')' statement { result = FunctionEval.new(val[0], val[1], val[3], val[5]) }
        ;

    arguments
        : variable_declare { result = ArgumentListEval.new(val[0]) }
        | arguments ',' variable_declare
          {
            val[0].add_member val[2]
            result = val[0]
          }
        ;

    code_block
        : DO statement_list END { result = val[1] }
        | '{' statement_list '}' { result = val[1] }
        | DO END { result = Evaluator.new }
        | '{' '}' { result = Evaluator.new }
        ;

    statement_list
        : statement { result = StatementListEval.new(val[0]) }
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
        | function_call
        | while_statement
        | for_statement
        | ASM { result = ASMEval.new(val[0]) }
        ;

    variable_declare
        : type ident { result = DefineVariableEval.new(val[0], val[1]) }
        | type ident '=' expression
          {
            var = DefineVariableEval.new(val[0], val[1])
            result = SetVariableEval.new(var, val[3])
          }
        | type '[' ']' ident { result = DefineArrayEval.new(val[0], val[3], 0) }
        | type '[' DECIMAL ']' ident { result = DefineArrayEval.new(val[0], val[4], val[2]) }
        | GEN_STRING ident '=' STRING { result = StringGenEval.new(val[1], val[3]) }
        | GEN_INT ident '=' '[' int_list ']' { result = IntGenEval.new(val[1], val[4]) }
        ;

    int_list
        : constant { result = [val[0].eval.value] }
        | constant int_list { result = val[1].unshift(val[0].eval.value) }
        | /* none */ { result = [] }
        ;

    variable_set
        : variable_reference '=' expression
          {
            result = SetVariableEval.new(val[0], val[2])
          }
        | variable_reference PLUS_EQUAL expression
          {
            result = SetVariableEval.new(val[0], val[2], :add)
          }
        | variable_reference MINUS_EQUAL expression
          {
            result = SetVariableEval.new(val[0], val[2], :sub)
          }
        | variable_reference '+' '+'
          {
            result = SetVariableEval.new(val[0], LiteralEval.new(:int, 1), :add)
          }
        | variable_reference '-' '-'
          {
            result = SetVariableEval.new(val[0], LiteralEval.new(:int, 1), :sub)
          }
        ;

    variable_reference
        : ident { result = GetVariableEval.new(val[0]) }
        | ident '[' expression ']' { result = GetArrayEval.new(val[0], val[2]) }
        | '@' ident { result = GetPointerEval.new(val[1]) }
        | '~' ident { result = GetReferenceEval.new(val[1]) }
        ;

    if_statement
        : IF  expression  statement { result = IfStatementEval.new(val[1], val[2]) }
        ;

    return_statement
        : RETURN expression { result = ReturnStatementEval.new(val[1]) }
        ;

    while_statement
        : WHILE expression statement { result = WhileLoopEval.new(val[1], val[2]) }
        ;

    for_statement
        : FOR '(' statement ';' expression ';' statement ')'  statement { result = ForLoopEval.new(val[2], val[4], val[6], val[8]) }
        ;

    term
        : variable_reference
        | '(' expression ')' { result = val[1] }
        | function_call
        | constant
        | conditional_expression
        ;

    negation
        : '!' negation { result = BinaryNegationEval.new(val[1]) }
        | term
        ;

    unary
        : '+' unary { result = val[1] }
        | '-' unary { result = UnaryNegationEval.new(val[1]) }
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
        : relation AND add { result = SimpleOperationEval.new(val[0], val[2], :and) }
        | relation OR add { result = SimpleOperationEval.new(val[0], val[2], :bor) }
        | add
        ;

    expression
        : relation EQUAL relation { result = ComparisonOperationEval.new(val[0], val[2], :equal) }
        | relation NOT_EQUAL relation { result = ComparisonOperationEval.new(val[0], val[2], :not_equal) }
        | relation LT relation { result = ComparisonOperationEval.new(val[0], val[2], :lt) }
        | relation GT relation { result = ComparisonOperationEval.new(val[0], val[2], :gt) }
        | relation LTE relation
        | relation GTE relation
        | relation
        ;

    conditional_expression
        : expression '?' expression ':' expression { result = ConditionalExpressionEval.new(val[0], val[2], val[4]) }
        ;

    function_call
        : ident '(' params ')' { result = FunctionCallEval.new(val[0], val[2]) }
        ;

    params
        : params ',' expression { result = val[0] << val[2] }
        | expression { result = [val[0]] }
        | /* none */
        ;

    constant
        : DECIMAL { result = LiteralEval.new(:int, val[0].to_i) }
        | HEX     { result = LiteralEval.new(:int, val[0].hex) }
        | TRUE    { result = LiteralEval.new(:bool, true) }
        | FALSE   { result = LiteralEval.new(:bool, false) }
        | CHAR_LIT{ result = LiteralEval.new(:char, val[0][0].ord) }
        ;

    ident
        : IDENT
        ;

    type
        : INT
        | UINT
        | BOOL
        | DEF
        | CHAR
        ;

end

---- header
    require_relative 'mpp_lexer.rb'
    require_relative 'term.rb'
    require_relative 'simple_operation.rb'
    require_relative 'single_operation.rb'
    require_relative 'variable.rb'
    require_relative 'function.rb'
    require_relative 'return_statement.rb'
    require_relative 'statement_list.rb'
    require_relative 'comparison_operation.rb'
    require_relative 'if_statement.rb'
    require_relative 'arguments.rb'
    require_relative 'loops.rb'
    require_relative 'array.rb'
    require_relative 'asm.rb'
    require_relative 'pointer.rb'
    require_relative 'generators.rb'
    require_relative 'conditional_expression.rb'
    require_relative 'global.rb'

---- inner
  #methods can be defined here...
