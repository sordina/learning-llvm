#include <stdio.h>

int goober(char* something)
{
  printf("Cheese %s",something);
  return 6;
}

int main( )
{
  printf("\n\n\n");
  int houses;
  houses = goober("Dope\n\n");
  printf("Hello World!\n\n");
  printf("Hello %d World!\n\n",houses);
  houses++;
  houses = houses * 4;
  printf("Fuck Knuckles!!!\n");

  int cake = 490;

  printf("Hello World! %d \n",houses);
  printf("Hello Gay World!\n");
  printf("foobar fool bar %d \n\n", cake * houses);
  printf("fazzz\n\n");

  int something_is_true = cake - houses;

  if( something_is_true )
  {
    printf("it's true\n");
  }
  else
  {
    printf("it's false\n");
  }

  printf("Hello World!\n");

  int cakehouses = cake + houses * 400;

  printf("Hello World! %d\n", cakehouses * cake);
}
