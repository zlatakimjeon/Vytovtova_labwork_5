#include "../include/recurrence.h"
#include <stdio.h>
#include <math.h>
#include <string.h>

int format_formula(double a, double b, double c, double d, char *out, size_t out_sz) {
    if (!out || out_sz == 0) return 1;

    double D = a * a + 4 * b;

    if (D > 1e-9) {
        double r1 = (a + sqrt(D)) / 2.0;
        double r2 = (a - sqrt(D)) / 2.0;
        double A = (d - c * r2) / (r1 - r2);
        double B = c - A;
        snprintf(out, out_sz, "x_n = %.1f*(%.1f)^(n-1) + %.1f*(%.1f)^(n-1)", A, r1, B, r2);
    } 
    else if (fabs(D) <= 1e-9) {
        double r = a / 2.0;
        if (fabs(r) < 1e-9) {
            snprintf(out, out_sz, "x_n = %.1f (n==1); x_n = %.1f (n==2); x_n = 0.0 (n>=3)", c, d);
        } else {
            double A = c;
            double B = (d / r) - A;
            snprintf(out, out_sz, "x_n = (%.1f + %.1f*(n-1))*(%.1f)^(n-1)", A, B, r);
        }
    } 
    else {
        double p = a / 2.0;
        double q = sqrt(-D) / 2.0;
        double rho = sqrt(p * p + q * q);
        double theta = atan2(q, p);
        double C1 = c;
        double C2 = (d / rho - C1 * cos(theta)) / sin(theta);
        snprintf(out, out_sz, "x_n = %.1f^(n-1)*(%.1f*cos((n-1)*%.1f) + %.1f*sin((n-1)*%.1f))",
                 rho, C1, theta, C2, theta);
    }

    return 0;
}
