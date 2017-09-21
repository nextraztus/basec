/**
 * vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
 *
 * C Entry Point
 *
 */
#include "main.h"

extern long asmadd(long, long);

int main(int argc, char *argv[])
{
    printf("Goodbye universe!\n");
    printf("Calling asmadd, 2+2=%zu", asmadd(2, 2));
    return 0;
}
