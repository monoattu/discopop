; ModuleID = 'simple.c'
source_filename = "simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"x=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"y=%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foo() #0 !dbg !7 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !10, metadata !DIExpression()), !dbg !12
  store i32 0, i32* %x, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %y, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 2, i32* %y, align 4, !dbg !14
  %0 = load i32, i32* %x, align 4, !dbg !15
  %inc = add nsw i32 %0, 1, !dbg !15
  store i32 %inc, i32* %x, align 4, !dbg !15
  %1 = load i32, i32* %y, align 4, !dbg !16
  %dec = add nsw i32 %1, -1, !dbg !16
  store i32 %dec, i32* %y, align 4, !dbg !16
  %2 = load i32, i32* %x, align 4, !dbg !17
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32 %2), !dbg !18
  %3 = load i32, i32* %y, align 4, !dbg !19
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %3), !dbg !20
  ret void, !dbg !21
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @foo(), !dbg !25
  ret i32 0, !dbg !26
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.1.0-6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "simple.c", directory: "/home/lukas/git/discopop/discopop_validation/test/code_samples/drb/166")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.1.0-6"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !8, scopeLine: 18, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 20, type: !11)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocation(line: 20, column: 7, scope: !7)
!13 = !DILocalVariable(name: "y", scope: !7, file: !1, line: 20, type: !11)
!14 = !DILocation(line: 20, column: 14, scope: !7)
!15 = !DILocation(line: 23, column: 4, scope: !7)
!16 = !DILocation(line: 26, column: 4, scope: !7)
!17 = !DILocation(line: 30, column: 19, scope: !7)
!18 = !DILocation(line: 30, column: 3, scope: !7)
!19 = !DILocation(line: 34, column: 19, scope: !7)
!20 = !DILocation(line: 34, column: 3, scope: !7)
!21 = !DILocation(line: 35, column: 1, scope: !7)
!22 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 38, type: !23, scopeLine: 38, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!11}
!25 = !DILocation(line: 41, column: 3, scope: !22)
!26 = !DILocation(line: 43, column: 3, scope: !22)