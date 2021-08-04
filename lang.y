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
    void yyerror();
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

%token T_include T_define T_int 
%token T_OpenParen T_CloseParen 
%token T_OpenBracket T_CloseBracket 
%token T_Comma T_Quote T_DotComma T_doubleDot 
%token T_OpenSquareBracket T_BackSlash T_CloseSquareBracket T_For T_Equals 
%token T_SmallerThan T_BiggerThan T_UnderScore T_Plus T_Percent T_ComercialAND T_Minus T_return;
%token<ival> T_IntValue;
%token<fval> T_FloatValue;
%token<sval> T_String T_Biblioteca T_Identificador;


    /* ========================================================================== */
	/* ============================ Sessão Gramatica ============================ */
	/* ========================================================================== */

%start program
%%

program: %empty

%%
	/* ========================================================================== */
	/* ======================== Sessão Codigo Especifico ======================== */
	/* ========================================================================== */

int main() {
    yyin = fopen("texto-para-teste.txt", "r");

    do{
        yyparse();
    } while(!feof(yyin));

    yyout = fopen("tabela.out", "w");
    
    fclose(yyout);

    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "\t\t%s\n", s);
    exit(1);
}


