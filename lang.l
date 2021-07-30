%option noyywrap yylineno 
	// yylineno é uma opcao pra guardar o numero de \n do proprio FLEX!
	
	/* ========================================================================== */
	/* =========================== Sessão headers =============================== */
	/* ========================================================================== */
%{
#include <stdio.h>
#include <string.h>
void invalidToken();
#define TAM 99999

int row = 1;
int cont_col = 1;
int id = 0;
typedef struct symbol{
    int id;
    int row;
    int column;
    char content[100];
    char *type;
} symbol;
symbol **symbolsTable;
%}
	/* ========================================================================== */
	/* =========================== Sessão Definições ============================ */
	/* ========================================================================== */

ConstINT [0-9]+ 
IDENTIFICADOR [a-zA-Z_][a-zA-Z0-9_]*
BIBLIOTECA <{IDENTIFICADOR}.h>
STRING \".*\"

%%
	/* ========================================================================== */
	/* =========================== Sessão REGRAS ================================ */
	/* ========================================================================== */
	
[ ]			{ ++cont_col;}
"\n"        { cont_col = 1;}
"#include"  { }
"#define"   { }
"int"       { }
"("         { }
")"         { }
"{"         { }
"}"         { }
","         { }
\"          { }
";"         { }
":"	 	    { }
"["         { }
"\\"		{ }
"]"         { }
"for"       { }
"="         { }
"<"         { }
">"         { }
"_"         { }
"+"         { }
"%"         { }
"&"         { }
"-"         { }
"return"    { }
{ConstINT}      	{ }
{IDENTIFICADOR} 	{ }
{BIBLIOTECA}      	{ }
{STRING}			{ }
"{"[^}\n]*"}"     /* eat up one-line comments */
[ \t]+           /* eat up whitespace */
[[:space:]]|[[:space:]]+;  /* Linhas em branco não tem importancia! */
. printf("Caracter não reconhecido %s\n", yytext ); //erros

%%
	/* ========================================================================== */
	/* ======================== Sessão Codigo Especifico ======================== */
	/* ========================================================================== */

