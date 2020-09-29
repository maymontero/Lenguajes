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
    //char *code[] = {"1", "2", "3", "MULT", "ADD"};
    char *code[10];
    int first = 0;
    int *pos = &first;
    int stack[50];
    int last = -1;
    int *top = &last;
    
    char text[50];
    fgets(text, 50, stdin);

    int n = 0;
    int count = 0;
    

    while (text[0] != '\n'){

        char *token = strtok(text, " ");

        while( token != NULL ) {
            if (strstr(token, "\n"))
                token = strtok(token, "\n");
            code[n] = token;
            token = strtok(NULL, " ");
            n++;
        }

        for (int i = 0; i < n; i++) {
            evaluate(code, pos, stack, top);
        }

        n = 0;
        count++;
        first = 0;
        last = count - 1;

        for (int j = 0; j < count; j++)  {
            printf("%d ", stack[j]);
        }

        printf("\n");
        fgets(text, 50, stdin);
    }
}



    

/*
int main() {
    char* code[] = {"1", "2", "3", "MULT", "ADD"};
    int first = 0;
    int *pos = &first;
    int stack[50];
    int last = -1;
    int *top = &last;

    int result;

    evaluate(code, pos, stack, top);
    evaluate(code, pos, stack, top);
    evaluate(code, pos, stack, top);
    evaluate(code, pos, stack, top);
    evaluate(code, pos, stack, top);
    result = stack[0];
    printf("%d\n", result);
}
*/
