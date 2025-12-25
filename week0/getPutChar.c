#include <stdio.h>

// Special char count
int one() {
    int nb, nt, nl;
    nb = nt = nl = 0;
    
    int c;
    while ((c = getchar()) != EOF) {
        if (c == '\n')
            ++nl;
        if (c == '\t')
            ++nt;
        if (c == ' ')
            ++nb;
    }
    printf("\nBlanks: %d\nTabs: %d\nLines: %d\n", nb, nt, nl);
    return 0;
}

// Display special char
int two() {
    int c;

    while ((c = getchar()) != EOF) {
        if (c == '\b')
            printf("\\b");
        if (c == '\t')
            printf("\\t");
        if (c == '\n')
            printf("\\n");
    }

    return 0;
}

// only one space
int three() {
    int c;
    int prev_char;

    while ((c = getchar()) != EOF) {
        if (c == ' ') {
            if (prev_char) {
                continue;
            } else {
                prev_char = 1;
            }
        } else {
            prev_char = 0;   
        }
        putchar(c);
    }

    return 0;
}

int main() {
    three();
}
