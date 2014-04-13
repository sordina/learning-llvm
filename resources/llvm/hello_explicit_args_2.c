
#include <stdio.h>

void custom(char* str) {
  printf(str);
}

int main(int argc, char** argv) {
  custom("hello world\n");
}
