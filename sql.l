%{
#include <stdio.h>
#include <string.h>
#include "struct.h"
#include "y.tab.h"
%}

%option noyywrap

%%
select          return SELECT;
from            return FROM;
where           return WHERE;
and             return AND;
or              return OR;
insert          return INSERT;
into            return INTO;
values          return VALUES;
delete          return DELETE;

";"             return ';';
"*"             { yylval.text = strdup(yytext); return '*'; }
","             { yylval.text = strdup(yytext); return ','; }
"="             { yylval.text = strdup(yytext); return '='; }
"<"             { yylval.text = strdup(yytext); return '<'; }
">"             { yylval.text = strdup(yytext); return '>'; }

[a-zA-Z_][a-zA-Z0-9_]* { yylval.text = strdup(yytext); return IDENTIFIER; }
[0-9]+               { yylval.text = strdup(yytext); return CONST; }

[ \t\n\r]+           ; // ignora espacios y saltos de línea

%%
