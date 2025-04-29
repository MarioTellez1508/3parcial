#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"

symbtbl *st = NULL;

symbtbl *putsymb(char *columns, char *table, int line) {
    symbtbl *p = (symbtbl *)malloc(sizeof(symbtbl));
    p->columns = strdup(columns);
    p->table = strdup(table);
    p->line = line;
    p->type = SYM_SELECT;
    p->values = NULL;
    p->next = st;
    st = p;
    return p;
}

symbtbl *putinsertsymb(char *columns, char *table, char *values, int line) {
    symbtbl *p = (symbtbl *)malloc(sizeof(symbtbl));
    p->columns = strdup(columns);
    p->table = strdup(table);
    p->values = strdup(values);
    p->line = line;
    p->type = SYM_INSERT;
    p->next = st;
    st = p;
    return p;
}

symbtbl *putdeletesymb(char *table, int line) {
    symbtbl *p = (symbtbl *)malloc(sizeof(symbtbl));
    p->columns = NULL;
    p->table = strdup(table);
    p->values = NULL;
    p->line = line;
    p->type = SYM_DELETE;
    p->next = st;
    st = p;
    return p;
}

symbtbl *getsymb(char *table) {
    symbtbl *p;
    for (p = st; p != NULL; p = p->next)
        if (strcmp(p->table, table) == 0)
            return p;
    return NULL;
}
