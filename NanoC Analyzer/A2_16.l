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
INTEGERS [1-9]+[0-9]*
IDENTIFIER [a-zA-Z][a-zA-Z0-9|_]*
PUNCTUATOR [;|,|(|)|\[|\]|{|}|+|\-|*|/|<|>|=|\\]|"<="|">="|"!="|"=="|"#"
SEMICOLON [;]
ESCAPE [\\]['|''|?|\\|a|b|f|n|r|t|v]
MULTICOMMENT "/*"[\n.]*"*/"
WS [\t\r\n]*
ZERO [0]
NEWLINE [\n]+

%x STRINGS
%x MULTILINE_COMMENT_NC    
%x SINGLELINE_COMMENT_NC

%%
"/*"            {BEGIN(MULTILINE_COMMENT_NC); }
<MULTILINE_COMMENT_NC>"*/" {BEGIN(INITIAL); }
<MULTILINE_COMMENT_NC>\n   {}
<MULTILINE_COMMENT_NC>.    {}

"//"            { BEGIN(SINGLELINE_COMMENT_NC); }
<SINGLELINE_COMMENT_NC>\n    { printf("\n"); BEGIN(INITIAL); }
<SINGLELINE_COMMENT_NC>. {}

"\""            { printf("<STRING CONSTANT, %s", yytext); BEGIN(STRINGS); }
<STRINGS>"\""   { printf("\">"); BEGIN(INITIAL); }
<STRINGS>\n     { printf("\n"); }
<STRINGS>.      { printf("%s", yytext);}


{ZERO} {printf("<INTEGER CONSTANT, \"0\">");}
{INT} {printf("<KEYWORD, \"int\"> ");}      
{CHAR} {printf("<KEYWORD, \"char\"> ");}
{ELSE} {printf("<KEYWORD, \"else\"> ");}
{FOR} {printf("<KEYWORD, \"for\"> ");}
{IF} {printf("<KEYWORD, \"if\"> ");}
{INTEGERS} {printf("<INTEGER CONSTANT, \"%s\"> ", yytext);}
{RETURN} {printf("<KEYWORD, return> ");}
{VOID} {printf("<KEYWORD, void> ");}
{IDENTIFIER} {printf("<IDENTIFIER, \"%s\"> ", yytext);}
{SEMICOLON} {printf("<PUNCTUATOR, \"%s\"> ", yytext);}
{PUNCTUATOR} {printf("<PUNCTUATOR, \"%s\"> ", yytext);}
{WS}    {printf("\n");}
%%