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
    void yyerror(const char* s);
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
%token T_UnderScore T_Percent T_ComercialAND  T_return;
%token T_EndLine;
%token T_Comment;
%token T_Not T_EqualsEQ T_NegativeEquals T_Or T_And T_SmallerThan T_SmallerThanEQ T_BiggerThan T_BiggerThanEQ
%token<ival> T_IntValue;
%token<fval> T_FloatValue;
%token<sval> T_String T_Biblioteca T_Identificador;



%type<ival> logical_expression;
%type<fval> mixed_expression expression type;

%left T_Minus T_Plus
%left T_Divide T_Times
%left T_Negative
%right T_Power



    /* ========================================================================== */
	/* ============================ Sessão Gramatica ============================ */
	/* ========================================================================== */

%start program
%%

program: structures;

structures: structures structure
        | /* empty */;

structure:  T_EndLine
    | variable_declaration T_DotComma {printf("variable declaration\n");}
    | attribution T_DotComma {printf("attribution\n");}
    | function_usage T_DotComma {printf("function\n");}
    | logical_structure
    | import T_DotComma {printf("import\n");}
    | logical_expression T_DotComma
    | T_Comment
    ;

import: T_Import T_Identificador ;

variable_declaration: T_Let T_Identificador T_Equals variable;

attribution: T_Identificador T_Equals variable
        | T_Identificador T_Plus T_Equals variable
        | T_Identificador T_Minus T_Equals variable
        | T_Identificador T_Divide T_Equals variable
        | T_Identificador T_Times T_Equals variable
        | T_Identificador T_Plus T_Plus
        | T_Identificador T_Minus T_Minus
        ;

function_usage: T_Identificador T_OpenParen T_CloseParen;

logical_structure: structure_for
    | structure_while
    | structure_if structure_else
    | structure_switch
    ;

structure_for: T_For T_OpenSquareBracket T_Identificador T_doubleDot T_OpenParen type T_Comma type T_Comma type T_CloseParen T_CloseSquareBracket T_OpenBracket structures T_CloseBracket;

structure_if: T_If T_OpenSquareBracket logical_expression T_CloseSquareBracket T_OpenBracket structures T_CloseBracket;

structure_else: T_Else T_OpenBracket structures T_CloseBracket;
    | /* empty */;

structure_switch: T_Switch T_OpenSquareBracket T_Identificador T_CloseSquareBracket T_OpenBracket structure_cases structure_default T_CloseBracket;

structure_cases: structure_cases structure_case
    | /* empty */;

structure_case: T_Case T_OpenSquareBracket type T_CloseSquareBracket T_OpenBracket structures T_CloseBracket T_EndLine
    | structure;
    ;

structure_default: T_Default T_OpenBracket structures T_CloseBracket T_EndLine;

structure_while: T_While T_OpenSquareBracket logical_expression T_CloseSquareBracket T_OpenBracket structures T_CloseBracket;

logical_expression: type
        | expression T_EqualsEQ expression {$$ = $1 == $3;  }
        | expression T_NegativeEquals expression {$$ = $1 != $3; }
        | expression T_BiggerThan expression {$$ = $1 > $3; }
        | expression T_SmallerThan expression {$$ = $1 < $3; }
        | expression T_BiggerThanEQ expression {$$ = $1 >= $3; }
        | expression T_SmallerThanEQ expression {$$ = $1 <= $3; }
        | expression T_Or expression {$$ = $1 || $3; }
        | expression T_And expression {$$ = $1 && $3; }
        | T_Not expression {$$ = !$2;};

variable: T_String
    | T_IntValue
    | T_FloatValue
    | expression
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
    | T_Identificador
    ;
%%
	/* ========================================================================== */
	/* ======================== Sessão Codigo Especifico ======================== */
	/* ========================================================================== */


int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}

