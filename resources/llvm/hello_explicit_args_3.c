
#include <stdio.h>

int custom(char* str) {
  printf(str);
  return 69;
}

int main(int argc, char** argv) {
  int ret = custom("hello world\n");
}
