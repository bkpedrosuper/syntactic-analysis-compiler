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

    /* Aqui temos os tipos de valores que podem vir junto com os tokens, no nosso caso temos apenas valores inteiros e caracteres (strings) */
%union{
    int ival;
    char* sval;
}

%define parse.error verbose

	/* ========================================================================== */
	/* ============================= Sessão Tokens ============================== */
	/* ========================================================================== */

%token T_include T_define T_int T_OpenParen T_CloseParen T_OpenBracket T_CloseBracket T_Comma T_Quote T_DotComma
T_doubleDot T_OpenSquareBracket T_BackSlash T_CloseSquareBracket T_For T_Equals T_SmallerThan T_BiggerThan T_UnderScore 
T_Plus T_Percent T_ComercialAND T_Minus T_return;
%token<ival> T_IntValue;
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


