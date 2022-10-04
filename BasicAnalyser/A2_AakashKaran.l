%{
 #include <stdio.h>
%}

%%
[0-9]+ {printf("<INTEGER, \"%s\">\n", yytext);}
[a-zA-Z][a-zA-Z]* {printf("<STRING, \"%s\">\n", yytext);}
%%

int main(){
    yylex();
}