#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'

    require_relative 'mpp_lexer.rb'
    require_relative 'term_eval.rb'
    require_relative 'simple_operation_eval.rb'
    require_relative 'variable_eval.rb'
    require_relative 'function_eval.rb'
    require_relative 'return_statement_eval.rb'
    require_relative 'statement_list_eval.rb'
    require_relative 'comparison_operation_eval.rb'
    require_relative 'if_statement_eval.rb'
    require_relative 'arguments_eval.rb'

class MPP < Racc::Parser

module_eval(<<'...end mpp_parser.y/module_eval...', 'mpp_parser.y', 180)
  #methods can be defined here...
...end mpp_parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    17,    29,    30,    18,    92,    19,    11,    42,    27,    28,
    13,     4,    42,     6,    74,    75,    76,    45,    47,    48,
    59,    60,    45,    47,    48,    67,    68,    14,    13,    29,
    30,    54,    55,    56,    57,    13,    54,    55,    56,    57,
    13,    42,     9,     6,     6,    15,    42,    74,    75,    76,
    13,    45,    47,    48,    77,    78,    45,    47,    48,    79,
    80,    81,    82,    83,    84,    54,    55,    56,    57,    13,
    54,    55,    56,    57,    13,    42,    74,    75,    76,    39,
    42,    29,    30,    77,    78,    45,    47,    48,    77,    78,
    45,    47,    48,    77,    78,    77,    78,    77,    78,    54,
    55,    56,    57,    13,    54,    55,    56,    57,    13,    42,
    77,    78,    67,    68,    42,   104,   105,    67,    68,    45,
    47,    48,    67,    68,    45,    47,    48,    67,    68,    67,
    68,    64,    69,    54,    55,    56,    57,    13,    54,    55,
    56,    57,    13,    42,     7,     6,   nil,   nil,    42,   nil,
   nil,   nil,   nil,    45,    47,    48,   nil,   nil,    45,    47,
    48,   nil,   nil,   nil,   nil,   nil,   nil,    54,    55,    56,
    57,    13,    54,    55,    56,    57,    13,    42,   nil,   nil,
   nil,   nil,    42,   nil,   nil,   nil,   nil,    45,    47,    48,
   nil,   nil,    45,    47,    48,   nil,   nil,   nil,   nil,   nil,
   nil,    54,    55,    56,    57,    13,    54,    55,    56,    57,
    13,    42,   nil,   nil,   nil,   nil,    42,   nil,   nil,   nil,
   nil,    45,    47,    48,   nil,   nil,    45,    47,    48,   nil,
   nil,   nil,   nil,   nil,   nil,    54,    55,    56,    57,    13,
    54,    55,    56,    57,    13,    42,   nil,   nil,   nil,   nil,
    42,   nil,   nil,   nil,   nil,    45,    47,    48,   nil,   nil,
    45,    47,    48,   nil,   nil,   nil,   nil,   nil,   nil,    54,
    55,    56,    57,    13,    54,    55,    56,    57,    13,    42,
   nil,   nil,   nil,   nil,    42,   nil,   nil,   nil,   nil,    45,
    47,    48,    42,   nil,    45,    47,    48,   nil,   nil,   nil,
   nil,   nil,    45,    54,    55,    56,    57,    13,    54,    55,
    56,    57,    13,    42,   nil,   nil,    54,    55,    56,    57,
    13,    42,   nil,    45,    47,    48,   nil,   nil,   nil,   nil,
   nil,    45,    47,    48,   nil,   nil,   nil,    54,    55,    56,
    57,    13,    42,   nil,   nil,    54,    55,    56,    57,    13,
    42,   nil,    45,    47,    48,   nil,   nil,   nil,   nil,   nil,
    45,    47,    48,   nil,   nil,   nil,    54,    55,    56,    57,
    13,   nil,   nil,   nil,    54,    55,    56,    57,    13,    18,
   nil,    19,   nil,   nil,    27,    28,    18,   nil,    19,    63,
   nil,    27,    28,   nil,   nil,    18,    61,    19,    67,    68,
    27,    28,   nil,   nil,    13,    29,    30,   nil,   nil,   nil,
   nil,    13,    29,    30,   nil,   nil,   nil,   nil,   nil,   nil,
    13,    29,    30,    18,   nil,    19,   nil,   nil,    27,    28,
    18,    34,    19,   nil,   nil,    27,    28,    18,   nil,    19,
    37,   nil,    27,    28,   nil,   nil,   nil,   nil,    13,    29,
    30,   nil,   nil,   nil,   nil,    13,    29,    30,   nil,   nil,
   nil,   nil,    13,    29,    30 ]

racc_action_check = [
    12,    17,    17,    12,    70,    12,     4,    64,    12,    12,
     6,     0,    84,     0,    50,    50,    50,    64,    64,    64,
    31,    31,    84,    84,    84,    70,    70,     7,    12,    12,
    12,    64,    64,    64,    64,    64,    84,    84,    84,    84,
    84,    83,     2,     8,     2,     9,    82,    96,    96,    96,
    25,    83,    83,    83,    52,    52,    82,    82,    82,    52,
    52,    52,    52,    52,    52,    83,    83,    83,    83,    83,
    82,    82,    82,    82,    82,    81,    97,    97,    97,    26,
    80,    60,    60,   101,   101,    81,    81,    81,   100,   100,
    80,    80,    80,   102,   102,    99,    99,    98,    98,    81,
    81,    81,    81,    81,    80,    80,    80,    80,    80,    79,
   103,   103,    58,    58,    78,    91,    91,    90,    90,    79,
    79,    79,    65,    65,    78,    78,    78,    87,    87,   106,
   106,    38,    41,    79,    79,    79,    79,    79,    78,    78,
    78,    78,    78,    27,     1,     3,   nil,   nil,    77,   nil,
   nil,   nil,   nil,    27,    27,    27,   nil,   nil,    77,    77,
    77,   nil,   nil,   nil,   nil,   nil,   nil,    27,    27,    27,
    27,    27,    77,    77,    77,    77,    77,   105,   nil,   nil,
   nil,   nil,    67,   nil,   nil,   nil,   nil,   105,   105,   105,
   nil,   nil,    67,    67,    67,   nil,   nil,   nil,   nil,   nil,
   nil,   105,   105,   105,   105,   105,    67,    67,    67,    67,
    67,    76,   nil,   nil,   nil,   nil,    75,   nil,   nil,   nil,
   nil,    76,    76,    76,   nil,   nil,    75,    75,    75,   nil,
   nil,   nil,   nil,   nil,   nil,    76,    76,    76,    76,    76,
    75,    75,    75,    75,    75,    74,   nil,   nil,   nil,   nil,
    68,   nil,   nil,   nil,   nil,    74,    74,    74,   nil,   nil,
    68,    68,    68,   nil,   nil,   nil,   nil,   nil,   nil,    74,
    74,    74,    74,    74,    68,    68,    68,    68,    68,    48,
   nil,   nil,   nil,   nil,    47,   nil,   nil,   nil,   nil,    48,
    48,    48,    45,   nil,    47,    47,    47,   nil,   nil,   nil,
   nil,   nil,    45,    48,    48,    48,    48,    48,    47,    47,
    47,    47,    47,    69,   nil,   nil,    45,    45,    45,    45,
    45,    39,   nil,    69,    69,    69,   nil,   nil,   nil,   nil,
   nil,    39,    39,    39,   nil,   nil,   nil,    69,    69,    69,
    69,    69,    42,   nil,   nil,    39,    39,    39,    39,    39,
    28,   nil,    42,    42,    42,   nil,   nil,   nil,   nil,   nil,
    28,    28,    28,   nil,   nil,   nil,    42,    42,    42,    42,
    42,   nil,   nil,   nil,    28,    28,    28,    28,    28,    40,
   nil,    40,   nil,   nil,    40,    40,    36,   nil,    36,    36,
   nil,    36,    36,   nil,   nil,    33,    33,    33,    40,    40,
    33,    33,   nil,   nil,    40,    40,    40,   nil,   nil,   nil,
   nil,    36,    36,    36,   nil,   nil,   nil,   nil,   nil,   nil,
    33,    33,    33,    59,   nil,    59,   nil,   nil,    59,    59,
    18,    18,    18,   nil,   nil,    18,    18,    19,   nil,    19,
    19,   nil,    19,    19,   nil,   nil,   nil,   nil,    59,    59,
    59,   nil,   nil,   nil,   nil,    18,    18,    18,   nil,   nil,
   nil,   nil,    19,    19,    19 ]

racc_action_pointer = [
     9,   144,    40,   141,     3,   nil,   -23,    27,    39,    42,
   nil,   nil,    -5,   nil,   nil,   nil,   nil,   -33,   422,   429,
   nil,   nil,   nil,   nil,   nil,    17,    67,   138,   345,   nil,
   nil,    14,   nil,   387,   nil,   nil,   378,   nil,   119,   316,
   371,   127,   337,   nil,   nil,   287,   nil,   279,   274,   nil,
    -4,   nil,    38,   nil,   nil,   nil,   nil,   nil,    85,   415,
    47,   nil,   nil,   nil,     2,    95,   nil,   177,   245,   308,
    -2,   nil,   nil,   nil,   240,   211,   206,   143,   109,   104,
    75,    70,    41,    36,     7,   nil,   nil,   100,   nil,   nil,
    90,   109,   nil,   nil,   nil,   nil,    29,    58,    81,    79,
    72,    67,    77,    94,   nil,   172,   102 ]

racc_action_default = [
    -4,   -66,    -1,    -2,   -66,    -7,   -66,   -66,    -3,   -66,
    -8,    -5,   -66,   -63,   107,    -6,    -9,   -66,   -66,   -66,
   -19,   -20,   -21,   -22,   -23,   -66,   -66,   -66,   -66,   -64,
   -65,   -66,   -11,   -66,   -15,   -17,   -66,   -16,   -24,   -66,
   -66,   -29,   -66,   -31,   -32,   -66,   -34,   -66,   -66,   -37,
   -44,   -41,   -51,   -54,   -59,   -60,   -61,   -62,   -28,   -66,
   -66,   -13,   -18,   -14,   -66,   -26,   -27,   -66,   -66,   -58,
   -66,   -33,   -35,   -36,   -66,   -66,   -66,   -66,   -66,   -66,
   -66,   -66,   -66,   -66,   -66,   -10,   -12,   -25,   -52,   -53,
   -57,   -66,   -30,   -38,   -39,   -40,   -42,   -43,   -45,   -46,
   -47,   -48,   -49,   -50,   -55,   -66,   -56 ]

racc_goto_table = [
    40,    58,    32,    10,    12,    16,     1,     3,    10,     8,
    26,    71,    65,    96,    97,    70,    26,    26,    31,    72,
    73,    88,    89,    38,    33,    36,    62,     2,    91,    62,
   nil,    26,   nil,    66,    26,   nil,   nil,    87,    26,   nil,
   nil,   nil,    90,   nil,   nil,    86,    93,    94,    95,   nil,
   nil,   nil,    85,   nil,   nil,   nil,   nil,    26,    98,    99,
   100,   101,   102,   103,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   106 ]

racc_goto_check = [
    15,    15,     8,     4,     5,     6,     1,     3,     4,     3,
     5,    19,    15,    21,    21,    15,     5,     5,     7,    20,
    20,    23,    23,     5,    10,    10,     6,     2,    24,     6,
   nil,     5,   nil,     6,     5,   nil,   nil,    15,     5,   nil,
   nil,   nil,    15,   nil,   nil,     8,    20,    20,    20,   nil,
   nil,   nil,     6,   nil,   nil,   nil,   nil,     5,    22,    22,
    22,    22,    22,    22,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    15 ]

racc_goto_pointer = [
   nil,     6,    27,     7,     0,    -2,    -7,     1,   -15,   nil,
     6,   nil,   nil,   nil,   nil,   -27,   nil,   nil,   nil,   -34,
   -28,   -64,   -21,   -46,   -41 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,     5,    41,    35,   nil,    21,    20,
   nil,    22,    23,    24,    25,   nil,    46,    43,    44,    49,
    51,    50,    52,    53,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  2, 37, :_reduce_none,
  0, 37, :_reduce_none,
  2, 38, :_reduce_5,
  3, 38, :_reduce_none,
  1, 39, :_reduce_7,
  2, 39, :_reduce_8,
  3, 40, :_reduce_9,
  6, 40, :_reduce_10,
  1, 43, :_reduce_11,
  3, 43, :_reduce_12,
  3, 45, :_reduce_13,
  3, 45, :_reduce_14,
  2, 45, :_reduce_15,
  2, 45, :_reduce_16,
  1, 46, :_reduce_17,
  2, 46, :_reduce_18,
  1, 42, :_reduce_none,
  1, 42, :_reduce_none,
  1, 42, :_reduce_none,
  1, 42, :_reduce_none,
  1, 42, :_reduce_none,
  2, 44, :_reduce_24,
  4, 44, :_reduce_25,
  3, 47, :_reduce_26,
  3, 48, :_reduce_27,
  2, 49, :_reduce_28,
  1, 52, :_reduce_29,
  3, 52, :_reduce_30,
  1, 52, :_reduce_none,
  1, 52, :_reduce_none,
  2, 55, :_reduce_33,
  1, 55, :_reduce_none,
  2, 56, :_reduce_35,
  2, 56, :_reduce_36,
  1, 56, :_reduce_none,
  3, 57, :_reduce_38,
  3, 57, :_reduce_39,
  3, 57, :_reduce_40,
  1, 57, :_reduce_none,
  3, 58, :_reduce_42,
  3, 58, :_reduce_43,
  1, 58, :_reduce_none,
  3, 59, :_reduce_45,
  3, 59, :_reduce_46,
  3, 59, :_reduce_47,
  3, 59, :_reduce_48,
  3, 59, :_reduce_none,
  3, 59, :_reduce_none,
  1, 59, :_reduce_none,
  3, 51, :_reduce_none,
  3, 51, :_reduce_none,
  1, 51, :_reduce_none,
  4, 53, :_reduce_none,
  3, 60, :_reduce_none,
  1, 60, :_reduce_none,
  0, 60, :_reduce_none,
  1, 54, :_reduce_59,
  1, 54, :_reduce_60,
  1, 54, :_reduce_61,
  1, 54, :_reduce_62,
  1, 41, :_reduce_none,
  1, 50, :_reduce_none,
  1, 50, :_reduce_none ]

racc_reduce_n = 66

racc_shift_n = 107

racc_token_table = {
  false => 0,
  :error => 1,
  :REQUIRE => 2,
  :STRING => 3,
  :DEF => 4,
  "(" => 5,
  ")" => 6,
  "," => 7,
  :DO => 8,
  :END => 9,
  "{" => 10,
  "}" => 11,
  "=" => 12,
  :IF => 13,
  :RETURN => 14,
  "!" => 15,
  "+" => 16,
  "-" => 17,
  "*" => 18,
  "/" => 19,
  "%" => 20,
  :EQUAL => 21,
  :NOT_EQUAL => 22,
  :LT => 23,
  :GT => 24,
  :LTE => 25,
  :GTE => 26,
  :AND => 27,
  :OR => 28,
  :DECIMAL => 29,
  :HEX => 30,
  :TRUE => 31,
  :FALSE => 32,
  :IDENT => 33,
  :INT => 34,
  :BOOL => 35 }

racc_nt_base = 36

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "REQUIRE",
  "STRING",
  "DEF",
  "\"(\"",
  "\")\"",
  "\",\"",
  "DO",
  "END",
  "\"{\"",
  "\"}\"",
  "\"=\"",
  "IF",
  "RETURN",
  "\"!\"",
  "\"+\"",
  "\"-\"",
  "\"*\"",
  "\"/\"",
  "\"%\"",
  "EQUAL",
  "NOT_EQUAL",
  "LT",
  "GT",
  "LTE",
  "GTE",
  "AND",
  "OR",
  "DECIMAL",
  "HEX",
  "TRUE",
  "FALSE",
  "IDENT",
  "INT",
  "BOOL",
  "$start",
  "target",
  "require_list",
  "function_list",
  "function",
  "ident",
  "statement",
  "arguments",
  "variable_declare",
  "code_block",
  "statement_list",
  "variable_set",
  "if_statement",
  "return_statement",
  "type",
  "expression",
  "term",
  "function_call",
  "constant",
  "negation",
  "unary",
  "mult",
  "add",
  "relation",
  "params" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

# reduce 3 omitted

# reduce 4 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 13)
  def _reduce_5(val, _values, result)
                 puts "ERROR: requires not yet supported."
             exit
           
    result
  end
.,.,

# reduce 6 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 20)
  def _reduce_7(val, _values, result)
     result = FunctionListEval.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 23)
  def _reduce_8(val, _values, result)
                val[0].add_member val[1]
            result = val[0]
          
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 29)
  def _reduce_9(val, _values, result)
     result = FunctionEval.new(val[1], Evaluator.new, val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 30)
  def _reduce_10(val, _values, result)
     result = FunctionEval.new(val[1], val[3], val[5]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 34)
  def _reduce_11(val, _values, result)
     result = ArgumentListEval.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 37)
  def _reduce_12(val, _values, result)
                val[0].add_member val[2]
            result = val[0]
          
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 43)
  def _reduce_13(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 44)
  def _reduce_14(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 45)
  def _reduce_15(val, _values, result)
     result = Evaluator.new 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 46)
  def _reduce_16(val, _values, result)
     result = Evaluator.new 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 50)
  def _reduce_17(val, _values, result)
     result = StatementListEval.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 53)
  def _reduce_18(val, _values, result)
                val[0].add_member val[1]
            result = val[0]
          
    result
  end
.,.,

# reduce 19 omitted

# reduce 20 omitted

# reduce 21 omitted

# reduce 22 omitted

# reduce 23 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 67)
  def _reduce_24(val, _values, result)
     result = DefineVariableEval.new(val[0], val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 70)
  def _reduce_25(val, _values, result)
                var = DefineVariableEval.new(val[0], val[1])
            result = SetVariableEval.new(var, val[3])
          
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 78)
  def _reduce_26(val, _values, result)
                var = GetVariableEval.new(val[0])
            result = SetVariableEval.new(var, val[2])
          
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 84)
  def _reduce_27(val, _values, result)
     result = IfStatementEval.new(val[1], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 88)
  def _reduce_28(val, _values, result)
     result = ReturnStatementEval.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 92)
  def _reduce_29(val, _values, result)
     result = GetVariableEval.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 93)
  def _reduce_30(val, _values, result)
     result = val[1] 
    result
  end
.,.,

# reduce 31 omitted

# reduce 32 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 99)
  def _reduce_33(val, _values, result)
     result = SingleOperationEval.new(val[1], :negation) 
    result
  end
.,.,

# reduce 34 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 104)
  def _reduce_35(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 105)
  def _reduce_36(val, _values, result)
     result = SingleOperationEval.new(val[1], :unary) 
    result
  end
.,.,

# reduce 37 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 110)
  def _reduce_38(val, _values, result)
     result = SimpleOperationEval.new(val[0], val[2], :mul) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 111)
  def _reduce_39(val, _values, result)
     result = SimpleOperationEval.new(val[0], val[2], :div) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 112)
  def _reduce_40(val, _values, result)
     result = SimpleOperationEval.new(val[0], val[2], :mod) 
    result
  end
.,.,

# reduce 41 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 117)
  def _reduce_42(val, _values, result)
     result = SimpleOperationEval.new(val[0], val[2], :add) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 118)
  def _reduce_43(val, _values, result)
     result = SimpleOperationEval.new(val[0], val[2], :sub) 
    result
  end
.,.,

# reduce 44 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 123)
  def _reduce_45(val, _values, result)
     result = ComparisonOperationEval.new(val[0], val[2], :equal) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 124)
  def _reduce_46(val, _values, result)
     result = ComparisonOperationEval.new(val[0], val[2], :not_equal) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 125)
  def _reduce_47(val, _values, result)
     result = ComparisonOperationEval.new(val[0], val[2], :lt) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 126)
  def _reduce_48(val, _values, result)
     result = ComparisonOperationEval.new(val[0], val[2], :gt) 
    result
  end
.,.,

# reduce 49 omitted

# reduce 50 omitted

# reduce 51 omitted

# reduce 52 omitted

# reduce 53 omitted

# reduce 54 omitted

# reduce 55 omitted

# reduce 56 omitted

# reduce 57 omitted

# reduce 58 omitted

module_eval(<<'.,.,', 'mpp_parser.y', 149)
  def _reduce_59(val, _values, result)
     result = LiteralEval.new(:int, val[0].to_i) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 150)
  def _reduce_60(val, _values, result)
     result = LiteralEval.new(:int, val[0].hex) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 151)
  def _reduce_61(val, _values, result)
     result = LiteralEval.new(:bool, true) 
    result
  end
.,.,

module_eval(<<'.,.,', 'mpp_parser.y', 152)
  def _reduce_62(val, _values, result)
     result = LiteralEval.new(:bool, false) 
    result
  end
.,.,

# reduce 63 omitted

# reduce 64 omitted

# reduce 65 omitted

def _reduce_none(val, _values, result)
  val[0]
end

end   # class MPP
