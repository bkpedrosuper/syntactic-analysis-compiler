	/* ========================================================================== */
	/* =========================== Sessão headers =============================== */
	/* ========================================================================== */
%{
    #include <stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<math.h>
    extern FILE *yyin;
    extern FILE *yyout;
    extern int linha_num;    
    extern int yylex();
    extern int param_cont;
    extern int cont_line;
    extern int cont_col;
    extern int scope;
    extern int scope_in_line[];
    void yyerror(const char* s);

    void print_spaces(int n, int jojase) {
        for(int i=0;i<n+1;i++) printf("\t");
    }
%}

    /* Aqui temos os tipos de valores dos Tokens, no nosso caso temos valores inteiros, reais e caracteres (strings) */
%union{
    int ival;
    int fval;
    char* sval;
}
%define parse.error verbose

	/* ========================================================================== */
	/* ============================= Sessão Tokens ============================== */
	/* ========================================================================== */

%token T_Let T_Import T_Func;
%token T_OpenParen T_CloseParen T_OpenCloseParen
%token T_OpenBracket T_CloseBracket 
%token T_Comma T_Quote T_DotComma T_doubleDot T_Dot
%token T_For T_If T_While T_Else T_Switch T_Case T_Default T_Do
%token T_OpenSquareBracket T_BackSlash T_CloseSquareBracket T_Equals 
%token T_UnderScore T_Percent T_ComercialAND T_Return T_Const;
%token T_EndLine;
%token T_Comment;
%token T_Not T_EqualsEQ T_NegativeEquals T_Or T_And T_SmallerThan T_SmallerThanEQ T_BiggerThan T_BiggerThanEQ
%token<ival> T_IntValue;
%token<fval> T_FloatValue;
%token<sval> T_String T_Biblioteca T_Identificador;

%type<ival> logical_expression;
%type<fval> expression type;

%left T_Minus T_Plus
%left T_Divide T_Times
%left T_Negative
%right T_Power

    /* ========================================================================== */
	/* ============================ Sessão Gramatica ============================ */
	/* ========================================================================== */

%start program
%%

program: { printf("|"); printf("Program begins, Linha: %d Coluna: %d\n", cont_line, cont_col); } lines ; 

lines: lines line
        | /* empty */; 

line:  T_EndLine
    | variable_declaration T_DotComma
    | attribution T_DotComma { print_spaces(scope_in_line[cont_line], 1); printf("|"); printf("Attribution Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);}
    | function_usage T_DotComma { print_spaces(scope_in_line[cont_line], 2); printf("|"); printf("Function Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);}
    | { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("Logical Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} logical_structure
    | import T_DotComma { print_spaces(scope_in_line[cont_line], 4); printf("|"); printf("Import Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);}
    | T_Comment { print_spaces(scope_in_line[cont_line], 5); printf("|");  printf("Comment Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} 
    ;

import: T_Import T_Identificador ;

variable_declaration: T_Let T_Identificador T_Equals variable { print_spaces(scope_in_line[cont_line], 6); printf("|"); printf("Variable declaration Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} 
        | T_Const T_Identificador T_Equals variable { print_spaces(scope_in_line[cont_line], 7); printf("|"); printf("Constant declaration Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);}; 

attribution: T_Identificador attribution_right
        ;

attribution_right:  T_Equals variable
        |  T_Plus T_Equals variable
        |  T_Minus T_Equals variable
        |  T_Divide T_Equals variable
        |  T_Times T_Equals variable
        |  T_Plus T_Plus
        |  T_Minus T_Minus
        ;        

function_usage: T_Identificador T_OpenParen optional_params T_CloseParen;

logical_structure: { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("For Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} structure_for
    | { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("While Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} structure_while
    | { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("Do Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} structure_do T_DotComma
    | { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("IF Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);}  structure_if { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("Else Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} structure_else
    | { print_spaces(scope_in_line[cont_line], 3); printf("|");  printf("Switch Structure Usage, Linha: %d Coluna: %d\n", cont_line, cont_col);} structure_switch
    ;

structure_for: T_For T_OpenSquareBracket T_Identificador T_doubleDot T_OpenParen type T_Comma type T_Comma type T_CloseParen T_CloseSquareBracket T_OpenBracket lines T_CloseBracket;

structure_if: T_If T_OpenSquareBracket logical_expression T_CloseSquareBracket T_OpenBracket lines T_CloseBracket;

structure_else: T_Else T_OpenBracket lines T_CloseBracket;
    | /* empty */;

structure_switch: T_Switch T_OpenSquareBracket T_Identificador T_CloseSquareBracket T_OpenBracket structure_cases structure_default T_CloseBracket;

structure_cases: structure_cases structure_case
    | /* empty */;

structure_case: T_Case T_OpenSquareBracket type T_CloseSquareBracket T_OpenBracket lines T_CloseBracket T_EndLine
    | line;
    ;

structure_default: T_Default T_OpenBracket lines T_CloseBracket T_EndLine;

structure_while: T_While T_OpenSquareBracket logical_expression T_CloseSquareBracket T_OpenBracket lines T_CloseBracket;

structure_do: T_Do T_OpenBracket lines T_CloseBracket T_While T_OpenSquareBracket logical_expression T_CloseSquareBracket;

logical_expression: expression T_EqualsEQ expression {$$ = $1 == $3;  }
        | expression T_NegativeEquals expression {$$ = $1 != $3; }
        | expression T_BiggerThan expression {$$ = $1 > $3; }
        | expression T_SmallerThan expression {$$ = $1 < $3; }
        | expression T_BiggerThanEQ expression {$$ = $1 >= $3; }
        | expression T_SmallerThanEQ expression {$$ = $1 <= $3; }
        | expression T_Or expression {$$ = $1 || $3; }
        | expression T_And expression {$$ = $1 && $3; }
        | T_Not expression {$$ = !$2;};

variable: T_String
    | expression {for(int i=0;i<scope_in_line[cont_line]+1;i++) printf("\t"); printf(" Resultado: %d\n", $1);}
    | function_usage;

expression: type
    | expression T_Plus expression { $$ =$1 + $3;}
    | expression T_Minus expression { $$ = $1 - $3; }
    | expression T_Times expression { $$ = $1 * $3; }
    | expression T_Divide expression { $$ = $1 / $3; }
    | T_Minus expression %prec T_Negative { $$ = -$2;}
    | expression T_Power expression { $$ = pow($1, $3);}
    | T_OpenParen expression T_CloseParen { $$ = $2; };

type: T_IntValue {$$ = $1;}
    | T_FloatValue {$$ = $1;}
    | T_Identificador {$$ = T_Identificador;}
    ;

optional_params: T_String
    | T_Identificador
    | /* empty */;

%%
	/* ========================================================================== */
	/* ======================== Sessão Codigo Especifico ======================== */
	/* ========================================================================== */

int main() {
    yyin = fopen("texto-exemplo.txt", "r");

    do{
        yyparse();
    } while(!feof(yyin));

    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "\t\t%s\n", s);
    exit(1);
}