#include <stdio.h>

#define LOWER 0
#define UPPER 300
#define STEP 20

int main() {
    float fahr, celsius;

    printf("\nFarenheit to celsius conversion:\n");

    for (fahr = UPPER; LOWER <= fahr; fahr -= STEP) {
        celsius = 5.0 / 9.0 * (fahr - 32);
        printf("%4.1f %6.1f\n", fahr, celsius);
    }

    printf("\nCelsius to Farenheit conversion: \n");
    for (celsius = UPPER; LOWER <= celsius; celsius -= STEP) {
        fahr = (celsius * 9.0) / 5.0 + 32;
        printf("%4.1f %6.1f\n", celsius, fahr);
    }
    return 0;
}
