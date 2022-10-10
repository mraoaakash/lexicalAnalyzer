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
PUNCTUATOR [;|,|(|)|\[|\]|{|}|+|\-|*|/|<|>|=]|"<="|">="|"!="|"=="
SEMICOLON [;]
STRINGLITERAL \"(\\.|[^"\\])*\"
ESCAPE [\\]['|''|?|\\|a|b|f|n|r|t|v]
MULTICOMMENT "/*"[\n.]*"*/"
WS [" " | \t\r]+
NEWLINE [\n]+

%x CONSTANT
%x MULTILINE_COMMENT_NC    
%x SINGLELINE_COMMENT_NC

%%
"/*"            {BEGIN(MULTILINE_COMMENT_NC); }
<MULTILINE_COMMENT_NC>"*/" {BEGIN(INITIAL); }
<MULTILINE_COMMENT_NC>\n   {}
<MULTILINE_COMMENT_NC>.    {}
"//"            { BEGIN(SINGLELINE_COMMENT_NC); }
<SINGLELINE_COMMENT_NC>\n    {}
<SINGLELINE_COMMENT_NC>. {}
[+|\-][1-9]+|[1-9]*|[a-zA-Z0-9]*] {printf("<CONSTANT, \"%s", yytext); BEGIN(CONSTANT); }
<CONSTANT>[;|,|(|)|\[|\]|{|}|+|\-|*|/|<|>|=]|"<="|">="|"!="|"==" {printf("\">");printf("<PUNCTUATOR, %s>", yytext); BEGIN(INITIAL);}
<CONSTANT>. {printf("%s", yytext);}

{INT} {printf("<KEYWORD, int> ");}      
{CHAR} {printf("<KEYWORD, char> ");}
{ELSE} {printf("<KEYWORD, else> ");}
{FOR} {printf("<KEYWORD, for> ");}
{IF} {printf("<KEYWORD, if> ");}
{RETURN} {printf("<KEYWORD, return> ");}
{VOID} {printf("<KEYWORD, void> ");}
{STRINGLITERAL} {printf("<STRING LITERAL, %s> ", yytext);}
{IDENTIFIER} {printf("<IDENTIFIER, %s> ", yytext);}
{SEMICOLON} {printf("<PUNCTUATOR, %s> ", yytext);}
{PUNCTUATOR} {printf("<PUNCTUATOR, %s> ", yytext);}
{NEWLINE} {printf("\n");}
{WS}    {}
%%