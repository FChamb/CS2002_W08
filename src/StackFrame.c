/*
 * StackFrame.c
 *
 * Source file for StackFrame module that provides functionality relating to
 * stack frames and printing out stack frame data.
 *
 */

#include <stdio.h>
#include "StackFrame.h"


/*
 * Non-static (akin to "public") functions that can be called from anywhere.
 * Comments for each function are given in the module interface StackFrame.h
 *
 * At present, they all just return 0 or do nothing.
 *
 * These are the functions you have to implement.
 *
 */

unsigned long getBasePointer() {
    long rbp;
    asm("movq %%rbp, %0;" : "=r"(rbp));
    return rbp;
}

unsigned long getReturnAddress() {
    long rax;
    asm("movq %%rax, %0;" : "=r"(rax));
    return rax;
}

void printStackFrameData(unsigned long basePointer, unsigned long previousBasePointer) {
    char hex[16];
    sprintf(hex, "%x", basePointer);
    printf("%x: %x -- ", previousBasePointer, basePointer);
    for (int i = 16; i > 0; i -= 2) {
        printf(&hex[i], &hex[i - 1])
    }
}

void printStackFrames(int number) {

}
