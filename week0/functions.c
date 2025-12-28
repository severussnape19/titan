#include <stddef.h>
#include <stdio.h>

#define MAXLINE 1000 /* maximum input of a line */
#define LIMIT 80

int inputLine(char line[], int maxline);
void copy(char to[], char from[]);
void reverse_while(char s[], int len);
void reverse_for(char s[], int len);

int main() {
    int len; /* current line length */
    int max; /* maximum length seen so far */
    char line[MAXLINE];
    char longest[MAXLINE];

    max = 0;
    while ((len = inputLine(line, MAXLINE)) > 0) {
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

int inputLine(char s[], int lim) {
    int c, i = 0;

    // terminate if crosses limit / if EOF / if newline (\n) -> End of line
    for (i = 0; i < lim - 1 && ((c = getchar()) != EOF) && c != '\n'; ++i) {
        s[i] = c;
    }

/*    while (i < lim - 1 && (c = getchar()) != EOF && c != '\n') {
        s[i++] = c;
    } */

    s[i] = '\0';

    int j = i - 1;
    while (j >= 0 && (s[j] == ' ' || s[j] == '\t')) {
        if (s[j] == ' ')
            printf("\nAt: %d -> \\b\n", j);
        else if (s[j] == '\t')
            printf("\nAt: %d -> \\t\n", j);
        else if (s[j] == '\n')
            printf("\nAt: %d -> \\n\n", j);
        else if (s[j] == '\0')
            printf("\nAt: %d -> \\0\n", j);
        else
            printf("At: %d -> %c", j, s[j]);
        
        --j;
    }

    s[j + 1] = '\0';

    return j + 1; /* Length of the string */
}

void copy(char to[], char from[]) {
    int i;

    i = 0;
    while ((to[i] = from[i]) != '\0')
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
