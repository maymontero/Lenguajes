#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void evaluate(char **code, int *pos, int *stack, int *top, int *v0, int *v1, int *v2, int *v3, int *v4) {
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
    } else if(strcmp("EQ", instruction) == 0) {
        if(n1 == n2)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("DIFF", instruction) == 0) {
        if(n1 == n2)
            stack[*top-1] = 0;
        else
            stack[*top-1] = 1;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("LT", instruction) == 0) {
        if(n2 > n1)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("LTE", instruction) == 0) {
        if(n2 >= n1)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("GT", instruction) == 0) {
        if(n2 < n1)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("GTE", instruction) == 0) {
        if(n2 <= n1)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("NOT", instruction) == 0) {
        if(n1)
            stack[*top] = 0;
        else
            stack[*top] = 1;
    } else if(strcmp("AND", instruction) == 0) {
        if(n2 && n1)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("OR", instruction) == 0) {
        if(n2 || n1)
            stack[*top-1] = 1;
        else
            stack[*top-1] = 0;
        
        int newTop = *top-1;
        *top = newTop;
    } else if(strcmp("0", instruction) == 0) {
        stack[*top+1] = 0;
        int newTop = *top+1;
        *top = newTop;
    } else if(strcmp("DUP", instruction) == 0) {
        stack[*top+1] = n1;
        int newTop = *top+1;
        *top = newTop;
    } else if(strcmp("POP", instruction) == 0) {
        int newTop = *top-1;
        *top = newTop;
    } else if(strstr(instruction, "UJP-") != NULL){
        char jump[2];
        strncpy(jump, instruction+4, 2);
        if(strcmp("00", jump) == 0){
            printf("Operador inválido\n");
            int newPos = *pos+1;
            *pos = newPos;
            return;
        }
        int jumpNumber = atoi(jump);
        if (jumpNumber) {
            int newPos = *pos-(jumpNumber-1);
            *pos = newPos;
        }
    } else if(strstr(instruction, "UJP+") != NULL){
        char jump[2];
        strncpy(jump, instruction+4, 2);
        if(strcmp("00", jump) == 0){
            printf("Operador inválido\n");
            int newPos = *pos+1;
            *pos = newPos;
            return;
        }
        int jumpNumber = atoi(jump);
        if (jumpNumber) {
            int newPos = *pos+(jumpNumber-1);
            *pos = newPos;
        }
    } else if(strstr(instruction, "CJP-") != NULL){
        if (n1){
            char jump[2];
            strncpy(jump, instruction+4, 2);
            if(strcmp("00", jump) == 0){
                printf("Operador inválido\n");
                int newPos = *pos+1;
                *pos = newPos;
                return;
            }
            int jumpNumber = atoi(jump);
            if (jumpNumber) {
                int newPos = *pos-(jumpNumber-1);
                *pos = newPos;
            }
        }
        int newTop = *top-1;
        *top = newTop;
    } else if(strstr(instruction, "CJP+") != NULL){
        if (n1){
            char jump[2];
            strncpy(jump, instruction+4, 2);
            if(strcmp("00", jump) == 0){
                printf("Operador inválido\n");
                int newPos = *pos+1;
                *pos = newPos;
                return;
            }
            int jumpNumber = atoi(jump);
            if (jumpNumber) {
                int newPos = *pos+(jumpNumber-1);
                *pos = newPos;
            }
        }
        int newTop = *top-1;
        *top = newTop;
    } else if(strstr(instruction, "SET") != NULL){
        char var = instruction[4];
        if(var == '0'){
            *v0 = n1;
        } else if (var == '1'){
            *v1 = n1;
        } else if (var == '2'){
            *v2 = n1;
        } else if (var == '3'){
            *v3 = n1;
        } else if (var == '4'){
            *v4 = n1;
        } else {
            printf("Operador inválido\n");
            int newPos = *pos+1;
            *pos = newPos;
            return;
        }
        int newTop = *top-1;
        *top = newTop;
    } else if(strstr(instruction, "GET") != NULL){
        char var = instruction[4];
        if(var == '0'){
            stack[*top+1] = *v0;
        } else if (var == '1'){
            stack[*top+1] = *v1;
        } else if (var == '2'){
            stack[*top+1] = *v2;
        } else if (var == '3'){
            stack[*top+1] = *v3;
        } else if (var == '4'){
            stack[*top+1] = *v4;
        } else {
            printf("Operador inválido\n");
            int newPos = *pos+1;
            *pos = newPos;
            return;
        }
        int newTop = *top+1;
        *top = newTop;
    }

    else {
        //printf("%s ", instruction);
        int number = atoi(instruction);
        if (number) {
            stack[*top+1] = number;
            int newTop = *top+1;
            *top = newTop;
        }
        else {
            printf("Operador inválido error\n");
            int newPos = *pos+1;
            *pos = newPos;
            return;
        }
    }
    int newPos = *pos+1;
    *pos = newPos;
}

int main() {
    //char *code[] = {"1", "2", "3", "MULT", "ADD"};
    char *code[30];
    int first = 0;
    int *pos = &first;
    int stack[50];
    int last = -1;
    int *top = &last;
    
    int init0 = 0;
    int init1 = 0;
    int init2 = 0;
    int init3 = 0;
    int init4 = 0;
    int *variable0 = &init0;
    int *variable1 = &init1;
    int *variable2 = &init2;
    int *variable3 = &init3;
    int *variable4 = &init4;
    
    char text[50];
    fgets(text, 100, stdin);

    int n = 0;
    
    while (text[0] != '\n'){

        char *token = strtok(text, " ");

        while( token != NULL ) {
            if (strstr(token, "\n"))
                token = strtok(token, "\n");
            code[n] = token;
            token = strtok(NULL, " ");
            n++;
        }

        while (*pos < n) {
            evaluate(code, pos, stack, top, variable0, variable1, variable2, variable3, variable4);
        }

        n = 0;

        for (int j = 0; j <= *top; j++)  {
            printf("%d ", stack[j]);
        }
        printf("| 0=%d 1=%d 2=%d 3=%d 4=%d", *variable0, *variable1, *variable2, *variable3, *variable4);

        printf("%s", "\n");
        fgets(text, 100, stdin);
        *pos = 0;
    }
}
