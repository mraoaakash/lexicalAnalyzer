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
PUNCTUATOR [;|,|(||)|\[|\]|{|}|+|-|*|/|<|<=|>|>=|==|!=|=]|"=="
STRINGLITERAL \"(\\.|[^"\\])*\"
ESCAPE [\\]['|''|?|\\|a|b|f|n|r|t|v]
MULTICOMMENT "/*"[\n.]*"*/"

SINGLECOMMENT [//][a-zA-Z0-9]+[\\n]
%x C_COMMENT
%x C_SL_COMMENT

%%
"/*"            { printf("<COMMENT, \"%s", yytext); BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { printf("%s\">", yytext); BEGIN(INITIAL); }
<C_COMMENT>\n   { printf("%s", yytext); }
<C_COMMENT>.    { printf("%s", yytext);}
"//"            { printf("<COMMENT, \"%s", yytext); BEGIN(C_SL_COMMENT); }
<C_SL_COMMENT>\n   { printf("\">"); BEGIN(INITIAL); }
<C_SL_COMMENT>.    { printf("%s", yytext);}
{INT} {printf("<KEYWORD, int> ");}
{CHAR} {printf("<KEYWORD, char> ");}
{ELSE} {printf("<KEYWORD, else> ");}
{FOR} {printf("<KEYWORD, for> ");}
{IF} {printf("<KEYWORD, if> ");}
{RETURN} {printf("<KEYWORD, return> ");}
{VOID} {printf("<KEYWORD, void> ");}
{STRINGLITERAL} {printf("<STRING, %s> ", yytext);}
{IDENTIFIER} {printf("<IDENTIFIER, %s> ", yytext);}
{CONSTANT} {printf("<CONSTANT, %s> ", yytext);}
{SEMICOLON} {printf("<PUNCTUATOR, %s> ", yytext);}
{PUNCTUATOR} {printf("<PUNCTUATOR, %s> ", yytext);}
%%