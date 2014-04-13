; ModuleID = 'resources/llvm/hello_explicit_args_3.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

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
