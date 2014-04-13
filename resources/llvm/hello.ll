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

define i32 @goober(i8* %something) nounwind uwtable ssp {
  %1 = alloca i8*, align 8
  store i8* %something, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i8* %2)
  ret i32 6
}

declare i32 @printf(i8*, ...)

define i32 @main() nounwind uwtable ssp {
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
