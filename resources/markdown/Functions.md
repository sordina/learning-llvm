
----

# C Function IR Representation { #functions }

At the moment we are happy with our understanding of Hello World, but we would like to
advance our knowledge further.

In order to do this we have written a new C program containing new features:

* Integers
* Integer Variables
* (Non-Main) Function
* Function Calls
* Assignment
* Incrementing variables
* Arithmetic expressions
* Print formatting and parameters

The file is located in: resources/llvm/hello.c with the contents:

~~~{ .c }
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
~~~

An issue emerged when compiling and interpreting the LLVM IR - OS X Maverics version of XCode had updated `llvm-gcc` to a new version that was incompatible with our version of `lli`. This required an update with `brew install llvm`. And subsequent relinking of paths.

As a side-effect, we discovered that we no longer needed `llvm-gcc` at all and could use `clang` directly with the following command:

~~~{ .shell }
> clang -S -emit-llvm FILE.c
~~~

The output (after some cleaning up) from the linking process was the following:

~~~{ .llvm }
@.str   = private unnamed_addr constant [10 x i8] c"Cheese %s\00"                , align 1
@.str1  = private unnamed_addr constant [ 4 x i8] c"\0A\0A\0A\00"                , align 1
@.str2  = private unnamed_addr constant [ 7 x i8] c"Dope\0A\0A\00"               , align 1
@.str3  = private unnamed_addr constant [15 x i8] c"Hello World!\0A\0A\00"       , align 1
@.str4  = private unnamed_addr constant [18 x i8] c"Hello %d World!\0A\0A\00"    , align 1
@.str5  = private unnamed_addr constant [18 x i8] c"Fuck Knuckles!!!\0A\00"      , align 1
@.str6  = private unnamed_addr constant [18 x i8] c"Hello World! %d \0A\00"      , align 1
@.str7  = private unnamed_addr constant [18 x i8] c"Hello Gay World!\0A\00"      , align 1
@.str8  = private unnamed_addr constant [22 x i8] c"foobar fool bar %d \0A\0A\00", align 1
@.str9  = private unnamed_addr constant [ 8 x i8] c"fazzz\0A\0A\00"              , align 1
@.str10 = private unnamed_addr constant [11 x i8] c"it's true\0A\00"             , align 1
@.str11 = private unnamed_addr constant [12 x i8] c"it's false\0A\00"            , align 1
@.str12 = private unnamed_addr constant [14 x i8] c"Hello World!\0A\00"          , align 1
@.str13 = private unnamed_addr constant [17 x i8] c"Hello World! %d\0A\00"       , align 1

; Function Attrs: nounwind ssp uwtable
define i32 @goober(i8* %something) #0 {
  %1 = alloca i8*, align 8
  store i8* %something, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i8* %2)
  ret i32 6
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %houses = alloca i32, align 4
  %cake = alloca i32, align 4
  %something_is_true = alloca i32, align 4
  %cakehouses = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0))
  %3 = call i32 @goober(i8* getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0))
  store i32 %3, i32* %houses, align 4
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i32 0, i32 0))
  %5 = load i32* %houses, align 4
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str4, i32 0, i32 0), i32 %5)
  %7 = load i32* %houses, align 4
  %8 = add nsw i32 %7, 1
  store i32 %8, i32* %houses, align 4
  %9 = load i32* %houses, align 4
  %10 = mul nsw i32 %9, 4
  store i32 %10, i32* %houses, align 4
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str5, i32 0, i32 0))
  store i32 490, i32* %cake, align 4
  %12 = load i32* %houses, align 4
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str6, i32 0, i32 0), i32 %12)
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str7, i32 0, i32 0))
  %15 = load i32* %cake, align 4
  %16 = load i32* %houses, align 4
  %17 = mul nsw i32 %15, %16
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str8, i32 0, i32 0), i32 %17)
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str9, i32 0, i32 0))
  %20 = load i32* %cake, align 4
  %21 = load i32* %houses, align 4
  %22 = sub nsw i32 %20, %21
  store i32 %22, i32* %something_is_true, align 4
  %23 = load i32* %something_is_true, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %27

; <label>:25                                      ; preds = %0
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str10, i32 0, i32 0))
  br label %29

; <label>:27                                      ; preds = %0
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str11, i32 0, i32 0))
  br label %29

; <label>:29                                      ; preds = %27, %25
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str12, i32 0, i32 0))
  %31 = load i32* %cake, align 4
  %32 = load i32* %houses, align 4
  %33 = mul nsw i32 %32, 400
  %34 = add nsw i32 %31, %33
  store i32 %34, i32* %cakehouses, align 4
  %35 = load i32* %cakehouses, align 4
  %36 = load i32* %cake, align 4
  %37 = mul nsw i32 %35, %36
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str13, i32 0, i32 0), i32 %37)
  %39 = load i32* %1
  ret i32 %39
}
~~~

This introduced some new pieces of syntax to us that we were not familiar with:

* `%1 = ...`
* `#1 ...`
* `store ...`
* `; <label>:25`

Let's see if we can figure out what's going on...

## %n

These seemed at first to be indicating instruction numbers. This checked out okay because the branch instructions seemed to be referring to them which would make a kind of sense. However, certain instructions did not seem to have a corresponding `%` variable, which was confusing.

Another hint was that these variables were referred to inside other instructions. The clincher was the `printf` call. With a little knowledge of `printf` it seemed that this really was being used to name the location of where the result of `printf` was being stored:

~~~{ .man }
     int printf(const char * restrict format, ...);

      ...

     These functions return the number of characters printed (not including
     the trailing `\0' used to end output to strings) or a negative value if
     an output error occurs, except for snprintf() and vsnprintf(), which
     return the number of characters that would have been printed if the n
     were unlimited (again, not including the final `\0').
~~~

Since I wasn't using the return code from `printf`, it shouldn't be referred to in
subsequent instructions, and low-and-behold, it wasn't. Bingo Bango.

With that mystery solved, let's move onto...

## #n

This marker appears just after function definitions in the following manner:

~~~{ .llvm }
define i32 @goober(i8* %something) #0 {
                                  /
                            This /
~~~

It doesn't appear to be referenced from anywhere else, so it is potentially some
kind of metadata surrounding how the function is defined or used.

One guess is that refers to how many arguments the function takes...

Let's look at all occurrences throughout our code:

~~~{ .llvm }
define i32 @goober(i8* %something) #0
...
declare i32 @printf(i8*, ...) #1
...
define i32 @main() #0 {
~~~

This seems to hold up, however, `printf` can take multiple arguments, but has only
one EXPLICIT argument, this makes sense as the same is true with `main`.

Let's test this assumption. I will create a new C program that has main defined with
its arguments explicitly and see if the result is as expected.

~~~{ .c }
#include <stdio.h>

int main(int argc, char** argv) {
  printf("hello world\n");
}
~~~

Clang LLVM IR Output:

~~~{ .llvm }
define i32 @main(i32 %argc, i8** %argv) #0 {
...
~~~

Mayhaps there is some special behavior for `main`, so lets try again
with a normal function:

~~~{ .c }
#include <stdio.h>

void custom(char** str) {
  printf(str);
}

int main(int argc, char** argv) {
  custom("hello world\n");
}
~~~

(Ignoring the security warning and removing the unused lines)

Clang LLVM IR Output:

~~~{ .llvm }
@.str = private unnamed_addr constant [13 x i8] c"hello world\0A\00", align 1

define void @custom(i8* %str) nounwind uwtable ssp {
  %1 = alloca i8*, align 8
  store i8* %str, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* %2)
  ret void
}

declare i32 @printf(i8*, ...)

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable ssp {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  call void @custom(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}
~~~

This is very weird, no `#n` symbols at all now... Potentially because I made my function
void??

Let's try a non-void version:

~~~{ .c }
#include <stdio.h>

int custom(char** str) {
  printf(str);
  return 69;
}

int main(int argc, char** argv) {
  int ret = custom("hello world\n");
}
~~~

Clang LLVM IR Output:

~~~{ .llvm }
@.str = private unnamed_addr constant [13 x i8] c"hello world\0A\00", align 1

define i32 @custom(i8* %str) nounwind uwtable ssp {
  %1 = alloca i8*, align 8
  store i8* %str, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* %2)
  ret i32 69
}

declare i32 @printf(i8*, ...)

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable ssp {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  %ret = alloca i32, align 4
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  %3 = call i32 @custom(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0))
  store i32 %3, i32* %ret, align 4
  ret i32 0
}
~~~


Okay, I figured out that the issue was that `clang` doesn't generate these symbols, but `llvm-gcc` does.

Just to be sure, let's now compile with `llvm-gcc`:

~~~{ .c }
#include <stdio.h>

int main(int argc, char** argv) {
  printf("hello world\n");
}
~~~

Clang LLVM IR Output:

~~~{ .llvm }
@.str = private unnamed_addr constant [13 x i8] c"hello world\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 5.1 (clang-503.0.40) (based on LLVM 3.4svn)"}
~~~

I believe this verifies the hypothesis.

Let's make sure we only use `clang` from now on...

So, inspecting the output again, it looks like this has nothing to do with number of arguments. Instead I believe that it is referring to the `attributes` section at the bottom of the generated IR. Such as:

~~~{ .text }
attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" ...
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" ...
~~~

## Store

I believe we've resolved our initial confusion regarding the special treatment of store's return value since we now understand the purpose of `%` variables. However, now would probably be a good time to track down a full list of LLVM's built in instructions such as `store`, `load`, `br`, etc!

GOOGLE FU

[The LLVM Language Reference](http://llvm.org/docs/LangRef.html)

A simple example can be found [in the manual](http://llvm.org/docs/LangRef.html#store-instruction):

~~~{ .llvm }
%ptr = alloca i32                               ; yields {i32*}:ptr
store i32 3, i32* %ptr                          ; yields {void}
%val = load i32* %ptr                           ; yields {i32}:val = i32 3
~~~

* 32 bits of memory is allocated for integer storage and named %ptr
* The immediate value '3' is stored in the %ptr location
* The value is loaded from %ptr into %val

## labels

I don't know what labels are... = )
Labels are pretty confusing. I still don't understand but Lyndon is making me write some stuff...so

Mayhaps, labels can be used to tell if something is true or false.
We tested tested that by changing the lables that were referenced in the branch instruction. We mucked around with the label numbers to see what would happen. An error occured when we changed the label reference in the branch statement. 

~~~
error: instruction forward referenced with type 'label'
~~~

Everytime we used a %variable as a label, we got an error message. 

Here are some examples of times we didn't recieve an error message while changing the label reference:

* 

