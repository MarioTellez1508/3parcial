%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"

int yylex();
int yyerror(char *s) {
    printf("  -- ERROR --  %s\n", s);
    return 0;
}

symbtbl *ptr;
%}

%union {
    int numerorighe;
    char *text;
}

%token <text> IDENTIFIER CONST
%token SELECT FROM WHERE AND OR INSERT INTO VALUES DELETE
%type <text> identifiers columns values compare cond op

%token <text> '*' '=' '<' '>'
%token ';' ','

%%

lines:
      /* empty */
    | lines line
    | lines error ';'
;

line:
      SELECT identifiers FROM IDENTIFIER WHERE cond ';' {
          ptr = putsymb($2, $4, 0);
      }
    | INSERT INTO IDENTIFIER '(' columns ')' VALUES '(' values ')' ';' {
          ptr = putinsertsymb($5, $3, $9, 0);
      }
    | DELETE FROM IDENTIFIER WHERE cond ';' {
          ptr = putdeletesymb($3, 0);
      }
;

columns:
      IDENTIFIER                   { $$ = $1; }
    | IDENTIFIER ',' columns {
          char *s = malloc(strlen($1) + strlen($3) + 2);
          strcpy(s, $1); strcat(s, ","); strcat(s, $3);
          $$ = s;
      }
;

values:
      CONST                      { $$ = $1; }
    | CONST ',' values {
          char *s = malloc(strlen($1) + strlen($3) + 2);
          strcpy(s, $1); strcat(s, ","); strcat(s, $3);
          $$ = s;
      }
;

identifiers:
      '*'                        { $$ = strdup("*"); }
    | IDENTIFIER                 { $$ = $1; }
    | IDENTIFIER ',' identifiers {
          char *s = malloc(strlen($1) + strlen($3) + 2);
          strcpy(s, $1); strcat(s, ","); strcat(s, $3);
          $$ = s;
      }
;

cond:
      IDENTIFIER op compare             { $$ = strdup("COND"); }
    | IDENTIFIER op compare AND cond   { $$ = strdup("COND"); }
    | IDENTIFIER op compare OR cond    { $$ = strdup("COND"); }
;

compare:
      IDENTIFIER   { $$ = $1; }
    | CONST        { $$ = $1; }
;

op:
      '<'          { $$ = strdup("<"); }
    | '='          { $$ = strdup("="); }
    | '>'          { $$ = strdup(">"); }
;

%%

int main() {
    yyparse();
    return 0;
}
