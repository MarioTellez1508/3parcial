%{
    #include <stdio.h>
    int yylex();
    int yyerror(const char *s) {
        fprintf(stderr, "Error: %s\n", s);
        return 1;
    }
%}

%token NUMBER MULTIPLICACION EOL
%start statements

%%

statements
    : statement statements
    | statement
    ;

statement
    : expresion EOL { printf("= %d\n", $1); }
    ;

expresion
    : NUMBER                         { $$ = $1; printf("numero: %d\n", $$); }
    | expresion MULTIPLICACION expresion      { 
    printf("Linea valida: multiplicacion reconocida.\n");
    $$ = $1 * $3; printf("resultado: %d\n", $$);
    }
    ;

%%

int main() {
    printf("Ingresa una multiplicacion:\n");
    return yyparse();
}
