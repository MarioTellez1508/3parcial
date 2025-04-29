#ifndef STRUCT_H
#define STRUCT_H

typedef enum {
    SYM_SELECT,
    SYM_INSERT,
    SYM_DELETE
} SymbolType;

typedef struct SymbTbl {
    char *columns;
    char *table;
    char *values;
    SymbolType type;
    int line;
    struct SymbTbl *next;
} symbtbl;

extern symbtbl *st;

symbtbl *putsymb(char *columns, char *table, int line);
symbtbl *putinsertsymb(char *columns, char *table, char *values, int line);
symbtbl *putdeletesymb(char *table, int line);
symbtbl *getsymb(char *table);

#endif
