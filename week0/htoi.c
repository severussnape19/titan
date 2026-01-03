#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

long long int hex_to_int(char s[]);
int to_lower_char(int c);
int to_number(int c, bool debug);
int intChar_to_int(int c);

int main() {
    int c, i;
    size_t len = 10;
    char str[len];

    i = 0;
    printf("Enter the hex code: ");
    while (i <= len && ((c = getchar()) != EOF && c != '\n')) {
        str[i++] = putchar(c);
    }

    printf("\nHex code: %s | Decimal equivalent: %lld\n", str, hex_to_int(str));
}

int to_lower_char(int c) {
    return c + 'a' - 'A';
}

int intChar_to_int(int c) {
    return c - '0';
}

int to_number(int c, bool debug) {
    int temp = c;
    if (c <= 'F' && c >= 'A') {
        c = to_lower_char(c);
        if (debug)
            printf("c: %1c | c_int: %3d | c -= 'a': %1d\n", temp, c, c - 'a');
        c = (c - 'a') + 10;
    } else if (c <= 'f' && c >= 'a') {
        c = (c - 'a') + 10;
    } else if (c >= '0' && c <= '9') {
        c = intChar_to_int(c); 
        if (debug)
            printf("c: %1c | c_int: %1d\n", temp, c);
    } else {
        if (c == 'x' || c == 'X')
            return 0;
        fprintf(stderr, "INVALID HEX CODE!\n");
        exit(0);
    }
    return c;
}

long long int hex_to_int(char s[]) {
    long long int result;
    int i;

    result = i = 0;
    while (s[i] != '\0') {
        result = 16 * result + to_number(s[i++], 0);
    }

    return result;
}
/* c = (c - 'a') + 10;

* A - F -> 10 -> 15
* if c = A -> to_lower_char(a) = a
* c -= 'a' -> scales the alphabets(a - f) to numbers between 0 - 5
* c + 10 = hex value of the number

result = 16 * 0 + to_number(s[i++]);
result = 16 * result + to_number(s[i + 1]);
result = 16 * result + to_number(s[i + 2]);
result = 16 * result + to_number(s[i + 3]);

*/
