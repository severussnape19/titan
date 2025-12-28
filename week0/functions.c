#include <stddef.h>
#include <stdio.h>
#define MAXLINE 1000 /* maximum input of a line */
#define LIMIT 20

int inputLine(char line[], int maxline, int active);
void copy(char to[], char from[]);
void reverse_while(char s[], int len);
void reverse_for(char s[], int len);

int main() {
    int len; /* current line length */
    int max; /* maximum length seen so far */
    char line[MAXLINE];
    char longest[MAXLINE];

    max = 0;
    while ((len = inputLine(line, MAXLINE, 1)) > 0) {
        if (len >= LIMIT) {
            printf("Line Greater than 80 chars: %s\n", line);
        }
        if (len > max) {
                max = len;
               copy(longest, line);
               //reverse_for(longest, max);
               /* printf("Length: %d\nCurrent longest: %s", len, longest); */
            }
    }
    if (max > 0)
        printf("Longest: %s\n", longest);
}

int inputLine(char s[], int lim, int active) {
    int c, i;

    // terminate if crosses limit / if EOF / if newline (\n) -> End of line
    for (i = 0; i < lim - 1 && ((c = getchar()) != EOF) && c != '\n'; ++i) {
        s[i] = c;
    }

   // printf("Last Element: %c\n", s[--i]);

    while (s[i] == ' ' || s[i] == '\t') {
        if (i == 0)
            break;
        else
            --i;
    }
    
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';

    if (active) {
        for (int j = 0; j < i; ++j) {
            if (s[j] == '\n')
                printf("\\n");
            if (s[j] == ' ')
                printf("\\b");
            if (s[j] == '\t')
                printf("\\t");
            if (s[j] == '\0')
                printf("\\0");
            printf("%c", s[j]);
        }
    }
    return i; /* Length of the string */
}

void copy(char to[], char from[]) {
    int i;

    i = 0;
    while ((to[i] = from[i]) != '\0') /* condition gets checked from right to left */
        ++i;
}

void reverse_while(char s[], int len) {
    int i;

    i = 0;
    if (s[len = len - 1] == '\n')
        len = len - 1;
    while (i < len) {
        char temp = s[i];
        s[i] = s[len];
        s[len] = temp;
        ++i;
        --len;
        //printf("string: %s\n", s);
    }
}

void reverse_for(char s[], int len) {
   int i; 

   if (s[len = len - 1] == '\n')
       len = len - 1;
   for (i = 0; i < len; ++i) {
       char temp = s[i];
       s[i] = s[len];
       s[len] = temp;
       --len;
       //printf("string: %s\n", s);
   }
}
