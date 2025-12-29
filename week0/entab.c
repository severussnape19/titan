#include <stdio.h>

#define MAXLINE 100
#define TABLEN 4
#define TABSTOP 4

char str[MAXLINE];

int inputLine_while(char s[], int debug_questionmark);
int inputLine_for(char s[]);

int main() {
    size_t len = 0;

    extern char str[];
    while ((len = inputLine_while(str, 0)) > 0)
        printf("String: %s | len: %zu\n", str, len);
}

int inputLine(char s[], int debug_questionmark) {
    int i, j, c, blanks, temp_char;

    blanks = i = 0;
    while ((c = getchar()) != EOF && c != '\n') {
        if (c == '\t')
            blanks += TABLEN;
        if (c == ' ')
            blanks += 1;
        if (blanks % TABSTOP != 0 && (c != ' ' || c != '\t')) {
            while (blanks % 4 != 0) {
                str[i++] = ' ';
                ++blanks;
            }
        }
        str[i] = c;
        ++i;
    }

    str[i] = '\0';

    if (debug_questionmark) {
        for (j = 0; j <= i; ++j) {
            if (str[j] == '\n')
                printf("\\n");
            else if (str[j] == '\t')
                printf("\\t");
            else if (str[j] == '\0')
                printf("\\0");
            else if (str[j] == ' ')
                printf("\\b");
            else
                printf("%c", str[i]);
        }
    }

    printf("\n");

    return i;
}
