%{
    #include <stdio.h>
    #include "y.tab.h"
    extern int yylval;
%}

%%

[0-9]+  { yylval = atoi(yytext); return NUMBER; }
"*"     { return MULTIPLICACION; }
[ \t\r] {}
\n      { return EOL; }
%%

int yywrap(void) { return 1; }
