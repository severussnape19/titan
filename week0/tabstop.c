#include <stdio.h>

#define TABSTOP 4;
#define MAXLINE 100

int inputLine(char s[]);

char str[MAXLINE];

int main() {
    int len, i;

    i = 0;
    extern char str[];
    while ((len = inputLine(str)) > 0) {
        for (i = 0; i < len; i++) {
            if (str[i] == '\t')
                printf("\\t");
            else if (str[i] == ' ')
                printf("\\b");
            else printf("%c", str[i]);
        }
        printf("\n");
    }

    return 0;
}

int inputLine(char s[]) {
    int c, i;

    i = 0;
    while ((c = getchar()) != EOF && c != '\n') {
        str[i] = c;
        if (str[i] == '\t') {
            int fill = i % TABSTOP;
            int fill_until = 0;
            if (fill == 3) {
                fill_until = i + 1;
            } else if (fill == 2) {
                fill_until = i + 2;            
            } else if (fill == 1) {
                fill_until = i + 3;
            } else if (fill == 0) {
                fill_until = 4 + i;
            }
            while (i < fill_until) {
                str[i] = ' ';
                ++i;
            }
        }
        ++i;
    }

    s[i] = '\0';

    return i;
}
