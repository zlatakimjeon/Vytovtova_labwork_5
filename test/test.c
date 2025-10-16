#include "../include/recurrence.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static void expect_equal(const char *got, const char *want, const char *case_name) {
    if (strcmp(got, want) != 0) {
        fprintf(stderr, "Failed %s\n  got : '%s'\n  want: '%s'\n", case_name, got, want);
        exit(2);
    } else {
        fprintf(stderr, "Passed %s\n", case_name);
    }
}

int main(void) {
    char buf[256];

    format_formula(1.0, 1.0, 1.0, 1.0, buf, sizeof(buf));
    expect_equal(buf, "x_n = 0.7*(1.6)^(n-1) + 0.3*(-0.6)^(n-1)", "D>0 (fib-like)");

    format_formula(2.0, -1.0, 3.0, 3.0, buf, sizeof(buf));
    expect_equal(buf, "x_n = (3.0 + 0.0*(n-1))*(1.0)^(n-1)", "D==0 nonzero r");

    format_formula(0.0, 0.0, 5.0, -2.0, buf, sizeof(buf));
    expect_equal(buf, "x_n = 5.0 (n==1); x_n = -2.0 (n==2); x_n = 0.0 (n>=3)", "r==0 special");

    format_formula(1.0, -1.0, 1.0, 0.0, buf, sizeof(buf));
    expect_equal(buf, "x_n = 1.0^(n-1)*(1.0*cos((n-1)*1.0) + -0.6*sin((n-1)*1.0))", "complex roots");

    printf("All tests passed\n");
    return 0;
}
