/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_LANG_TAB_H_INCLUDED
# define YY_YY_LANG_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_Let = 258,
    T_Import = 259,
    T_Func = 260,
    T_OpenParen = 261,
    T_CloseParen = 262,
    T_OpenCloseParen = 263,
    T_OpenBracket = 264,
    T_CloseBracket = 265,
    T_Comma = 266,
    T_Quote = 267,
    T_DotComma = 268,
    T_doubleDot = 269,
    T_Dot = 270,
    T_For = 271,
    T_If = 272,
    T_OpenSquareBracket = 273,
    T_BackSlash = 274,
    T_CloseSquareBracket = 275,
    T_Equals = 276,
    T_SmallerThan = 277,
    T_BiggerThan = 278,
    T_UnderScore = 279,
    T_Percent = 280,
    T_ComercialAND = 281,
    T_return = 282,
    T_EndLine = 283,
    T_IntValue = 284,
    T_FloatValue = 285,
    T_String = 286,
    T_Biblioteca = 287,
    T_Identificador = 288,
    T_Minus = 289,
    T_Plus = 290,
    T_Divide = 291,
    T_Times = 292,
    T_Negative = 293,
    T_Power = 294
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 18 "lang.y"

    int ival;
    int fval;
    char* sval;

#line 103 "lang.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_LANG_TAB_H_INCLUDED  */
