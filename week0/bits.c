#include <stdio.h>
#include <limits.h>
#include <stdbool.h>

#define BITS (sizeof(unsigned int) * CHAR_BIT - 1)

unsigned getbits(unsigned, int, int);
unsigned setbits(unsigned, unsigned, int, int, bool);
unsigned invertbits(unsigned, int, int, bool);
unsigned invertbits_xor(unsigned, int, int, bool);
void print_bits(unsigned int);

unsigned getbits(unsigned x, int p, int n) {
    // x: bits
    // p: start position of the bits
    // n: n bits from position p  
    unsigned shifted = x >> (p + 1 - n);
    unsigned mask = ~(~0 << n);
    return shifted & mask;
}

unsigned setbits(unsigned x, unsigned y, int p, int n, bool enable) {
    unsigned mask = (1U << n) - 1; // 1000 - 1 => 0111
    if (enable)
        print_bits(mask);
    mask = mask << (p - n + 1);
    if (enable)
        print_bits(mask);

    unsigned y_bits = (1U << n) - 1;
    if (enable)
        print_bits(y_bits);

    y_bits = y & y_bits;
    if (enable)
        print_bits(y_bits);
    
    y_bits = y_bits << (p - n + 1);
    if (enable)
        print_bits(y_bits);
    
    return (x & ~mask) | y_bits;
}

unsigned invertbits(unsigned x, int n, int p, bool view) {
    /* n bits from position p in x flipped/inverted */
    unsigned mask = ((1U << n) - 1) << (p - n + 1);  // n bit mask
    unsigned x_bits = x & mask; // extracted part
    if (view) {
        printf("\nInvert bits NO XOR: \n");
        printf("X              : "); print_bits(x);
        printf("\nMask           : "); print_bits(mask);
        printf("\nExtracted bits : "); print_bits(x_bits);
        printf("\nResult         : "); print_bits((x & ~mask) | (~x & mask));
    }
    return (x & ~mask) | (~x & mask);
}

unsigned invertbits_xor(unsigned x, int n, int p, bool view) {
    unsigned mask = ((1U << n) - 1) << (p - n + 1);
    if (view) {
        printf("\nInvert bits WITH XOR: \n");
        printf("X              : "); print_bits(x);
        printf("\nMask           : "); print_bits(mask);
        printf("\nResult         : "); print_bits(x ^ mask);
    }
    return x ^ mask;
}

void print_bits(unsigned int x) {
    for (int i = BITS; i >= 0; i--) {
        putchar((x >> i) & 1 ? '1'  : '0');
        if (i % 4 == 0)
            putchar(' ');
    }
    putchar('\n');
}


int main() {
    int x = 218;
    int y = 5;
    int n = 3, p = 4;

/*
    print_bits(x);
    print_bits(y);
    int result = setbits(x, y, p, n, 0);
    print_bits(result);
*/
    invertbits(x, n, p, 1);
    invertbits_xor(x, n, p, 1);
}
