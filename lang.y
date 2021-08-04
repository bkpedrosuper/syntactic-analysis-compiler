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

%union{
    int ival;
    double fval;
    char* sval;
}

%define parse.error verbose

	/* ========================================================================== */
	/* ============================= Sessão Tokens ============================== */
	/* ========================================================================== */

%token<ival> T_INT
%token<fval> T_REAL





%start program

%%

program: %empty

%%

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


