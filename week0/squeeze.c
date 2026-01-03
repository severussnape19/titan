#include <stdio.h>
#include <stdbool.h>

#define MAXLEN 100

char *del_identical(char s[], char t[], bool debug);

int main() {
    char s[MAXLEN];
    char t[MAXLEN];
    int c, i;

    i = 0;
    printf("First string: ");
    while ((c = getchar()) != EOF && c != '\n')
        s[i++] = putchar(c);
    s[i] = '\0';
    
    i = 0;
    printf("\nSecond string: ");
    while ((c = getchar()) != EOF && c != '\n')
        t[i++] = putchar(c);
    s[i] = '\0';

    printf("\n");
    char *p = del_identical(s, t, 0);

    printf("%s\n", p);
}

char *del_identical(char s[], char t[], bool debug) {
    int i, j, k;
    for (i = 0; s[i] != '\0' ; i++) {
        for (j = 0; t[j] != '\0'; j++) {
            if (s[i] == t[j]) {
                printf("1st str -> %c = 2nd str -> %c\n", s[i], t[j]);
                for (k = i; s[k] != '\0'; k++) {
                    if (debug) {
                        if (s[k + 1] == '\0')
                            printf("Shifting: %c <- %c\n", s[k], s[k + 1]);
                        printf("Shifting: %c <- %c\n", s[k], s[k + 1]);    
                    }
                    s[k] = s[k + 1];
                }
            }
        }
    }
    return s;
}
