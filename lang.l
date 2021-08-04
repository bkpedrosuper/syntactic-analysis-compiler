%option noyywrap yylineno 
	// yylineno é uma opcao pra guardar o numero de \n do proprio FLEX!
	
	/* ========================================================================== */
	/* =========================== Sessão headers =============================== */
	/* ========================================================================== */
%{
#include <stdio.h>
#include <string.h>
#include "lang.tab.h"
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
"#include"  { return T_include; }
"#define"   { return T_define; 	}
"int"       { return T_int;		}
"("         { return T_OpenParen;	}
")"         { return T_CloseParen; 	}
"{"         { return T_OpenBracket;	}
"}"         { return T_CloseBracket;	}
","         { return T_Comma;	}
\"          { return T_Quote;	}
";"         { return T_DotComma;	}
":"	 	    { return T_doubleDot;	}
"["         { return T_OpenSquareBracket;	}
"\\"		{ return T_BackSlash;	}
"]"         { return T_CloseSquareBracket;	}
"for"       { return T_For;	}
"="         { return T_Equals;	}
"<"         { return T_SmallerThan;	}
">"         { return T_BiggerThan;	}
"_"         { return T_UnderScore;	}
"+"         { return T_Plus;	}
"%"         { return T_Percent;	}
"&"         { return T_ComercialAND	;}
"-"         { return T_Minus;	}
"return"    { return T_return;	}

{ConstINT}      	{ yylval.ival = atof(yytext); return T_IntValue;	}
{IDENTIFICADOR} 	{ strcpy(yylval.sval, yytext); return T_Identificador;	}
{BIBLIOTECA}      	{ strcpy(yylval.sval, yytext); return T_Biblioteca;	}
{STRING}			{ strcpy(yylval.sval, yytext); return T_String;	}
"{"[^}\n]*"}"     /* eat up one-line comments */
[ \t]+           /* eat up whitespace */
[[:space:]]|[[:space:]]+;  /* Linhas em branco não tem importancia! */
. printf("Caracter não reconhecido %s\n", yytext ); //erros

%%
	/* ========================================================================== */
	/* ======================== Sessão Codigo Especifico ======================== */
	/* ========================================================================== */

