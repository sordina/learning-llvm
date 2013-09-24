
----

# Exploring the Intermediate Representation { #eir }

When presented with a mess like this, the first thing I always
try to do is see what I can remove...

I figure the first three lines can get the hell outta here!!

~~~{ .llvm .leave }
; ModuleID = 'hello_llvm.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin11.4"
~~~

Everything compiles and runs, but just to be sure I look up what
those lines were doing anyway:

* [`;`](http://llvm.org/docs/LangRef.html) is a comment - everything following on the same line is ignored
* [`target datalayout`](http://llvm.org/docs/LangRef.html) sets the format of various bits of data
* [`target triple`](http://llvm.org/docs/CommandGuide/llc.html) specifies the operationg environment that the program is targeting

The targets seem to have reasonable defaults and aren't required so away they go.
With them gone let's have a look at what remains...


The constant declaration of "Hello World" looks like a good place to start:

```llvm
@.str = private constant [13 x i8] c"Hello World!\00", align 1 ; <[13 x i8]*> [#uses=1]
```

Let's modify it to say goodbye and see what happenes...

```llvm
@.str = private constant [13 x i8] c"Goodbye World!\00", align 1 ; <[13 x i8]*> [#uses=1]
```

## Error! { .error }

```text
lli: hello_llvm.s:2:36: error: constant expression type mismatch
@.str = private constant [13 x i8] c"Goodbye World!\00", align 1 ; <[13 x i8]*> [#uses=1]
                                   ^
```

It looks like the length declared has to match the string length otherwise boom.
So we modify the declaration

```llvm
@.str = private constant [15 x i8] c"Goodbye World!\00", align 1 ; <[13 x i8]*> [#uses=1]
```

## Error! { .error }

```text
lli: hello_llvm.s:8:62: error: '@.str' defined with type '[15 x i8]*'
  %0 = call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @.str, i64 0, i64 0)) nounwind ; <i32> [#uses=0]
                                                               ^
```

So... references are typed too?

Let's update that.

```llvm
  %0 = call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0)) nounwind ; <i32> [#uses=0]
```

And...

```text
Goodbye World!
```

Woot!

## Let's have another look at our program

```llvm
@.str = private constant [15 x i8] c"Goodbye World!\00", align 1 ; <[13 x i8]*> [#uses=1]

define i32 @main() nounwind ssp {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=1]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  %0 = call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0)) nounwind ; <i32> [#uses=0]
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)
```

According to [IBM](http://www.ibm.com/developerworks/library/os-createcompilerllvm1/)
the essential components of an LLVM IR program are...


* Comments
* Global identifiers
* Local identifiers
* A strong type system
* Vectors or Arrays
* Global string constants
* Functions
* Return statements
* Function calls

Let's see if we can change the name of our @.str constant to @greeting:

```llvm
@greeting = private constant [15 x i8] c"Goodbye World!\00", align 1 ; <[13 x i8]*> [#uses=1]

define i32 @main() nounwind ssp {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=1]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  %0 = call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @greeting, i64 0, i64 0)) nounwind ; <i32> [#uses=0]
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)
```

And running...

```text
Goodbye World!
```

Yay!

## Super Small:

~~~{ data-language=llvm data-filter=./resources/scripts/lli.sh }
@greeting = constant [15 x i8] c"Goodbye World!\00"

define i32 @main() nounwind ssp {
entry:
  %0 = call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @greeting, i64 0, i64 0)) nounwind
  ret i32 0
}

declare i32 @puts(i8*)
~~~

