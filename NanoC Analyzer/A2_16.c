#include <stdio.h>
#include "lex.yy.c"

extern int yylex(void);

int main(){
    yylex();
}