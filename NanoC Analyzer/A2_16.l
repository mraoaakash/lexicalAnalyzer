%{
    #include <stdio.h>    
%}
%option noyywrap

/* Regular expression definitions*/

INT "int"
CHAR "char"
ELSE "else"
FOR "for"
IF "if"
RETURN "return"
VOID "void"
IDENTIFIER [a-zA-Z][a-zA-Z0-9|_]*
CONSTANT [[+|-][0-9]+|[0-9]*|[a-zA-Z0-9]*]
SEMICOLON [;]
PUNCTUATOR [;|,|(||)|\[|\]|{|}|+|-|*|/|<|<=|>|>=|==|!=|=]
STRINGLITERAL ["[a-zA-Z0-9]*\0"]
ESCAPE [\\]['|''|?|\\|a|b|f|n|r|t|v]

%%
{INT} {printf("<KEYWORD, int> ");}
{CHAR} {printf("<KEYWORD, char> ");}
{ELSE} {printf("<KEYWORD, else> ");}
{FOR} {printf("<KEYWORD, for> ");}
{IF} {printf("<KEYWORD, if> ");}
{RETURN} {printf("<KEYWORD, return> ");}
{VOID} {printf("<KEYWORD, void> ");}
{IDENTIFIER} {printf("<IDENTIFIER, %s> ", yytext);}
{CONSTANT} {printf("<CONSTANT, %s> ", yytext);}
{SEMICOLON} {printf("<PUNCTUATOR, %s> ", yytext);}
{PUNCTUATOR} {printf("<PUNCTUATOR, %s> ", yytext);}
[ ] {printf("");}
%%