#include <stdio.h>

/* Count digits, whitespaces and others */

int one() {
    int c, i, nwhite, nother;
    int ndigits[10];

    nwhite = nother = 0;
    for (i = 0; i < 10; ++i)
        ndigits[i] = 0;

    while ((c = getchar()) != EOF) {
        if (c >= '0' && c <= '9')
            ++ndigits[c - '0'];
        else if (c == '\n' || c == ' ' || c == '\t')
            ++nwhite;
        else
            ++nother;
    }

    printf("Digits = ");
    for (int i = 0; i < 10; ++i)
        printf("%d ", ndigits[i]);
    printf(" , White space: %d, other: %d\n", nwhite, nother);

    return 0;
}

#define OUT 0
#define IN 1
#define MAX 20
#define ALPHABETS 26

/* Histogram of lengths of words */
int two() {
    int c, wl, w, state, freq_other;
    int words[MAX];
    int chars[ALPHABETS];
    int freq_chars[ALPHABETS];

    state = OUT;
    wl = w = freq_other = 0;
    for (int i = 0; i < MAX; ++i)
        words[i] = 0;

    for (int i = 0; i < ALPHABETS; ++i) {
        chars[i] = 97 + i;
        //printf("%c ", chars[i]);
        freq_chars[i] = 0;
    }

    while ((c = getchar()) != EOF) {
        if (c == '\n' || c == ' ' || c == '\t') {
            words[w] = wl;
            ++w;
            wl = 0;
            state = OUT;
        }

        if (state == OUT && c != '\n' || c != ' ' || c != '\t')
            state = IN;

        if (state == IN) {
            ++wl;
            if (c >= '!' && c <= '@')
                ++freq_other;

            for (int i = 0; i < ALPHABETS; ++i) {
                if (c == chars[i]) 
                    ++freq_chars[i]; 
            }
        }
    }

    printf("\nInfo:\n");
    for (int i = 0; i < w; ++i)
        if (i == 0) {
            printf("%3d -> %3d\n", i, words[i]);
        } else {
         printf("%3d -> %3d\n", i, words[i] - 1);
        }

    printf("\nFrequencies of ALPHABETS: \n");
    for (int i = 0; i < ALPHABETS; ++i) {
        if (freq_chars[i] != 0) {
            printf("%3c  -> %3d\n", chars[i], freq_chars[i]);
        }
    }
    printf("\nOther Frequencies: %d\n", freq_other);
    return 0;
}

int main() {
    two();
}
