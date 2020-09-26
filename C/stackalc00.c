#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void evaluate(char **code, int *pos, int *stack, int *top) {
    char *instruction = code[*pos];
    int n1 = stack[*top];
    int n2 = stack[*top-1];
    if (strcmp("ADD", instruction) == 0) {
        stack[*top-1] = n1+n2;
        int newTop = *top-1;
        *top = newTop;
    } else if (strcmp("SUB", instruction) == 0) {
        stack[*top-1] = n2-n1;
        int newTop = *top-1;
        *top = newTop;
    } else if (strcmp("MULT", instruction) == 0) {
        stack[*top-1] = n2*n1;
        int newTop = *top-1;
        *top = newTop;
    } else if (strcmp("DIV", instruction) == 0) {
        if (n1) {
            stack[*top-1] = n2/n1;
            int newTop = *top-1;
            *top = newTop;
        }
    } else {
        int number = atoi(instruction);
        if (number) {
            stack[*top+1] = number;
            int newTop = *top+1;
            *top = newTop;
        }
    }
    int newPos = *pos+1;
    *pos = newPos;
}

int main() {
    char* code[] = {"3", "1", "1", "SUB", "DIV"};
    int first = 0;
    int *pos = &first;
    int stack[50];
    int last = -1;
    int *top = &last;

    int result;

    evaluate(code, pos, stack, top);
    result = stack[0];
    printf("%d\n", result);

    evaluate(code, pos, stack, top);
    evaluate(code, pos, stack, top);
    evaluate(code, pos, stack, top);
    result = stack[1];
    printf("%d\n", result);

    evaluate(code, pos, stack, top);
    result = stack[0];
    printf("%d\n", result);
}


