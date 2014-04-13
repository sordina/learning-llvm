
@greeting = constant [15 x i8] c"Goodbye World!\00"

define i32 @main() nounwind ssp {
entry:
  %0 = call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @greeting, i64 0, i64 0)) nounwind
  ret i32 0
}

declare i32 @puts(i8*)
