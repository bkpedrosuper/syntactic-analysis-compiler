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
%token T_For T_If
%token T_OpenSquareBracket T_BackSlash T_CloseSquareBracket T_Equals 
%token T_SmallerThan T_BiggerThan T_UnderScore T_Percent T_ComercialAND  T_return;
%token T_EndLine;
%token<ival> T_IntValue;
%token<fval> T_FloatValue;
%token<sval> T_String T_Biblioteca T_Identificador;



%type<ival> expression;
%type<fval> mixed_expression;

%left T_Minus T_Plus
%left T_Divide T_Times
%left T_Negative
%right T_Power



    /* ========================================================================== */
	/* ============================ Sessão Gramatica ============================ */
	/* ========================================================================== */

%start program
%%

program: /* empty */;
    | program structures;

structures:  T_EndLine
    | function_declaration;
    | T_Import;

function_declaration: T_Func T_String T_OpenCloseParen T_OpenBracket T_EndLine line T_CloseBracket;

line: T_EndLine T_DotComma
    | variable_declaration T_DotComma
    | function_usage;
    | logical_structure;

variable_declaration: T_String T_Equals variable;

function_usage: T_Dot function_usage
    | T_String T_OpenCloseParen function_usage
    | "";

logical_structure: T_For
    | T_If;

variable: T_String
    | T_IntValue
    | T_FloatValue
    | expression
    | function_usage;

expression: T_IntValue {$$=$1; printf("int\n");}
    | expression T_Plus expression { printf("int + int\n"); $$ = $1 + $3;  }
    | expression T_Minus expression { $$ = $1 - $3; }
    | expression T_Times expression { $$ = $1 * $3; }
    | expression T_Divide expression { $$ = $1 / $3; }
    | T_Minus expression %prec T_Negative { $$ = -$2;}
    | expression T_Power expression { $$ = pow($1, $3);}
    | T_OpenParen expression T_CloseParen { $$ = $2; };



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

