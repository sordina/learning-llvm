
----

# From C

After googling "Hello World in LLVM" I was presented with
several results, but they had one thing in common -
They all proposed that the best way to learn how
hello-world works in LLVM is by compiling a C
version of hello-world with llvm-gcc and then looking
at the output:

`hello_llvm.c`

```c
#include <stdio.h>
int main( )
{ 
  printf("Hello World!\n");
}
```

```shell
> llvm-gcc % -S -emit-llvm
```

`hello_llvm.s`

```llvm
; ModuleID = 'hello_llvm.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin11.4"

@.str = private constant [13 x i8] c"Hello World!\00", align 1 ; <[13 x i8]*> [#uses=1]

define i32 @main() nounwind ssp {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=1]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  %0 = call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @.str, i64 0, i64 0)) nounwind ; <i32> [#uses=0]
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)
```

```shell
> lli hello_llvm.s
```

```text
Hello World
```

It works!!! But... The code is pretty cluttered.
