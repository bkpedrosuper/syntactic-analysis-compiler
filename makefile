bison -d lang.y --verbose && flex lang.l && gcc lang.tab.c lex.yy.c -o lang -lm