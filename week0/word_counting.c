#include <stdio.h>

#define IN 1  // Inside a word
#define OUT 0 // Outside a word

/* count lines, words, and characters in input */
int one() {
    int c, nl, nw, nc, state;

    state = OUT;
    nl = nc = nw = 0;
    while ((c = getchar()) != EOF) {
        ++nc;
        if (c == '\n')
            ++nl;
        if (c == ' ' || c == '\n' || c == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
    }
    printf("\nNew word: %d\nNew line: %d\nNew character: %d\n", nw, nl, nc);

    return 0;
}

int two() {
    int c, state;
    state = OUT;
    while ((c = getchar()) != EOF) {
        if (c == ' ' || c == '\t') 
            state = OUT;
        if (state == OUT && c == '\n') {
            putchar(c);
            state = IN;
        } else if (state == IN)
            putchar(c);
    }
    return 0;
}

int main() {
    two();
}
