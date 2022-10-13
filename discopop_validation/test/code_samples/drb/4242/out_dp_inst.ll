; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"retval\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"n\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"i\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"dummy\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"sum\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  call void @__dp_func_entry(i32 16385, i32 1)
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %dummy = alloca i32, align 4
  %n = alloca i32, align 4
  %sum = alloca i32, align 4
  %a = alloca [10 x double], align 16
  %0 = ptrtoint i32* %retval to i64
  call void @__dp_write(i32 16385, i64 %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %dummy, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %n, metadata !17, metadata !DIExpression()), !dbg !18
  %1 = ptrtoint i32* %n to i64
  call void @__dp_write(i32 16387, i64 %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i32 0, i32 0))
  store i32 10, i32* %n, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata [10 x double]* %a, metadata !21, metadata !DIExpression()), !dbg !25
  %2 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16390, i64 %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 0, i32* %i, align 4, !dbg !26
  br label %for.cond, !dbg !28

for.cond:                                         ; preds = %for.inc, %entry
  call void @__dp_loop_entry(i32 16390, i32 0)
  %3 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16390, i64 %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %4 = load i32, i32* %i, align 4, !dbg !29
  %5 = ptrtoint i32* %n to i64
  call void @__dp_read(i32 16390, i64 %5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i32 0, i32 0))
  %6 = load i32, i32* %n, align 4, !dbg !31
  %cmp = icmp slt i32 %4, %6, !dbg !32
  br i1 %cmp, label %for.body, label %for.end, !dbg !33

for.body:                                         ; preds = %for.cond
  %7 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16391, i64 %7, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %8 = load i32, i32* %i, align 4, !dbg !34
  %conv = sitofp i32 %8 to double, !dbg !35
  %9 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16391, i64 %9, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %10 = load i32, i32* %i, align 4, !dbg !36
  %idxprom = sext i32 %10 to i64, !dbg !37
  %arrayidx = getelementptr inbounds [10 x double], [10 x double]* %a, i64 0, i64 %idxprom, !dbg !37
  %11 = ptrtoint double* %arrayidx to i64
  call void @__dp_write(i32 16391, i64 %11, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double %conv, double* %arrayidx, align 8, !dbg !38
  br label %for.inc, !dbg !37

for.inc:                                          ; preds = %for.body
  %12 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16390, i64 %12, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %13 = load i32, i32* %i, align 4, !dbg !39
  %inc = add nsw i32 %13, 1, !dbg !39
  %14 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16390, i64 %14, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 %inc, i32* %i, align 4, !dbg !39
  br label %for.cond, !dbg !40, !llvm.loop !41

for.end:                                          ; preds = %for.cond
  call void @__dp_loop_exit(i32 16393, i32 0)
  %15 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16393, i64 %15, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 0, i32* %i, align 4, !dbg !43
  br label %for.cond1, !dbg !45

for.cond1:                                        ; preds = %for.inc9, %for.end
  call void @__dp_loop_entry(i32 16393, i32 1)
  %16 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16393, i64 %16, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %17 = load i32, i32* %i, align 4, !dbg !46
  %18 = ptrtoint i32* %n to i64
  call void @__dp_read(i32 16393, i64 %18, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i32 0, i32 0))
  %19 = load i32, i32* %n, align 4, !dbg !48
  %cmp2 = icmp slt i32 %17, %19, !dbg !49
  br i1 %cmp2, label %for.body4, label %for.end11, !dbg !50

for.body4:                                        ; preds = %for.cond1
  %20 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16394, i64 %20, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %21 = load i32, i32* %i, align 4, !dbg !51
  %sub = sub nsw i32 %21, 1, !dbg !52
  %rem = srem i32 %sub, 10, !dbg !53
  %idxprom5 = sext i32 %rem to i64, !dbg !54
  %arrayidx6 = getelementptr inbounds [10 x double], [10 x double]* %a, i64 0, i64 %idxprom5, !dbg !54
  %22 = ptrtoint double* %arrayidx6 to i64
  call void @__dp_read(i32 16394, i64 %22, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %23 = load double, double* %arrayidx6, align 8, !dbg !54
  %24 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16394, i64 %24, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %25 = load i32, i32* %i, align 4, !dbg !55
  %idxprom7 = sext i32 %25 to i64, !dbg !56
  %arrayidx8 = getelementptr inbounds [10 x double], [10 x double]* %a, i64 0, i64 %idxprom7, !dbg !56
  %26 = ptrtoint double* %arrayidx8 to i64
  call void @__dp_write(i32 16394, i64 %26, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double %23, double* %arrayidx8, align 8, !dbg !57
  br label %for.inc9, !dbg !56

for.inc9:                                         ; preds = %for.body4
  %27 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16393, i64 %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %28 = load i32, i32* %i, align 4, !dbg !58
  %inc10 = add nsw i32 %28, 1, !dbg !58
  %29 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16393, i64 %29, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 %inc10, i32* %i, align 4, !dbg !58
  br label %for.cond1, !dbg !59, !llvm.loop !60

for.end11:                                        ; preds = %for.cond1
  call void @__dp_loop_exit(i32 16396, i32 1)
  %arrayidx12 = getelementptr inbounds [10 x double], [10 x double]* %a, i64 0, i64 3, !dbg !62
  %30 = ptrtoint double* %arrayidx12 to i64
  call void @__dp_read(i32 16396, i64 %30, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %31 = load double, double* %arrayidx12, align 8, !dbg !62
  %arrayidx13 = getelementptr inbounds [10 x double], [10 x double]* %a, i64 0, i64 2, !dbg !63
  %32 = ptrtoint double* %arrayidx13 to i64
  call void @__dp_read(i32 16396, i64 %32, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %33 = load double, double* %arrayidx13, align 16, !dbg !63
  %add = fadd double %31, %33, !dbg !64
  %conv14 = fptosi double %add to i32, !dbg !62
  %34 = ptrtoint i32* %dummy to i64
  call void @__dp_write(i32 16396, i64 %34, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0))
  store i32 %conv14, i32* %dummy, align 4, !dbg !65
  %35 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16398, i64 %35, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 0, i32* %i, align 4, !dbg !66
  br label %for.cond15, !dbg !68

for.cond15:                                       ; preds = %for.inc24, %for.end11
  call void @__dp_loop_entry(i32 16398, i32 2)
  %36 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16398, i64 %36, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %37 = load i32, i32* %i, align 4, !dbg !69
  %38 = ptrtoint i32* %n to i64
  call void @__dp_read(i32 16398, i64 %38, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i32 0, i32 0))
  %39 = load i32, i32* %n, align 4, !dbg !71
  %cmp16 = icmp slt i32 %37, %39, !dbg !72
  br i1 %cmp16, label %for.body18, label %for.end26, !dbg !73

for.body18:                                       ; preds = %for.cond15
  %40 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16399, i64 %40, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %41 = load i32, i32* %i, align 4, !dbg !74
  %idxprom19 = sext i32 %41 to i64, !dbg !76
  %arrayidx20 = getelementptr inbounds [10 x double], [10 x double]* %a, i64 0, i64 %idxprom19, !dbg !76
  %42 = ptrtoint double* %arrayidx20 to i64
  call void @__dp_read(i32 16399, i64 %42, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %43 = load double, double* %arrayidx20, align 8, !dbg !76
  %44 = ptrtoint i32* %sum to i64
  call void @__dp_read(i32 16399, i64 %44, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i32 0, i32 0))
  %45 = load i32, i32* %sum, align 4, !dbg !77
  %conv21 = sitofp i32 %45 to double, !dbg !77
  %add22 = fadd double %conv21, %43, !dbg !77
  %conv23 = fptosi double %add22 to i32, !dbg !77
  %46 = ptrtoint i32* %sum to i64
  call void @__dp_write(i32 16399, i64 %46, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i32 0, i32 0))
  store i32 %conv23, i32* %sum, align 4, !dbg !77
  br label %for.inc24, !dbg !78

for.inc24:                                        ; preds = %for.body18
  %47 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16398, i64 %47, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %48 = load i32, i32* %i, align 4, !dbg !79
  %inc25 = add nsw i32 %48, 1, !dbg !79
  %49 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16398, i64 %49, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 %inc25, i32* %i, align 4, !dbg !79
  br label %for.cond15, !dbg !80, !llvm.loop !81

for.end26:                                        ; preds = %for.cond15
  call void @__dp_loop_exit(i32 16402, i32 2)
  call void @__dp_finalize(i32 16402), !dbg !83
  ret i32 0, !dbg !83
}

declare void @__dp_func_entry(i32, i32)

declare void @__dp_write(i32, i64, i8*)

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__dp_loop_entry(i32, i32)

declare void @__dp_read(i32, i64, i8*)

declare void @__dp_loop_exit(i32, i32)

declare void @__dp_finalize(i32)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.1.0-6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "simple.c", directory: "/home/lukas/git/discopop/discopop_validation/test/code_samples/drb/4242")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{!"Ubuntu clang version 11.1.0-6"}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !10, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 3, type: !12)
!14 = !DILocation(line: 3, column: 7, scope: !9)
!15 = !DILocalVariable(name: "dummy", scope: !9, file: !1, line: 3, type: !12)
!16 = !DILocation(line: 3, column: 10, scope: !9)
!17 = !DILocalVariable(name: "n", scope: !9, file: !1, line: 3, type: !12)
!18 = !DILocation(line: 3, column: 17, scope: !9)
!19 = !DILocalVariable(name: "sum", scope: !9, file: !1, line: 3, type: !12)
!20 = !DILocation(line: 3, column: 23, scope: !9)
!21 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 4, type: !22)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 640, elements: !23)
!23 = !{!24}
!24 = !DISubrange(count: 10)
!25 = !DILocation(line: 4, column: 10, scope: !9)
!26 = !DILocation(line: 6, column: 8, scope: !27)
!27 = distinct !DILexicalBlock(scope: !9, file: !1, line: 6, column: 3)
!28 = !DILocation(line: 6, column: 7, scope: !27)
!29 = !DILocation(line: 6, column: 11, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 6, column: 3)
!31 = !DILocation(line: 6, column: 13, scope: !30)
!32 = !DILocation(line: 6, column: 12, scope: !30)
!33 = !DILocation(line: 6, column: 3, scope: !27)
!34 = !DILocation(line: 7, column: 19, scope: !30)
!35 = !DILocation(line: 7, column: 10, scope: !30)
!36 = !DILocation(line: 7, column: 7, scope: !30)
!37 = !DILocation(line: 7, column: 5, scope: !30)
!38 = !DILocation(line: 7, column: 9, scope: !30)
!39 = !DILocation(line: 6, column: 17, scope: !30)
!40 = !DILocation(line: 6, column: 3, scope: !30)
!41 = distinct !{!41, !33, !42}
!42 = !DILocation(line: 7, column: 20, scope: !27)
!43 = !DILocation(line: 9, column: 8, scope: !44)
!44 = distinct !DILexicalBlock(scope: !9, file: !1, line: 9, column: 3)
!45 = !DILocation(line: 9, column: 7, scope: !44)
!46 = !DILocation(line: 9, column: 11, scope: !47)
!47 = distinct !DILexicalBlock(scope: !44, file: !1, line: 9, column: 3)
!48 = !DILocation(line: 9, column: 13, scope: !47)
!49 = !DILocation(line: 9, column: 12, scope: !47)
!50 = !DILocation(line: 9, column: 3, scope: !44)
!51 = !DILocation(line: 10, column: 15, scope: !47)
!52 = !DILocation(line: 10, column: 16, scope: !47)
!53 = !DILocation(line: 10, column: 19, scope: !47)
!54 = !DILocation(line: 10, column: 12, scope: !47)
!55 = !DILocation(line: 10, column: 7, scope: !47)
!56 = !DILocation(line: 10, column: 5, scope: !47)
!57 = !DILocation(line: 10, column: 10, scope: !47)
!58 = !DILocation(line: 9, column: 17, scope: !47)
!59 = !DILocation(line: 9, column: 3, scope: !47)
!60 = distinct !{!60, !50, !61}
!61 = !DILocation(line: 10, column: 22, scope: !44)
!62 = !DILocation(line: 12, column: 11, scope: !9)
!63 = !DILocation(line: 12, column: 18, scope: !9)
!64 = !DILocation(line: 12, column: 16, scope: !9)
!65 = !DILocation(line: 12, column: 9, scope: !9)
!66 = !DILocation(line: 14, column: 8, scope: !67)
!67 = distinct !DILexicalBlock(scope: !9, file: !1, line: 14, column: 3)
!68 = !DILocation(line: 14, column: 7, scope: !67)
!69 = !DILocation(line: 14, column: 11, scope: !70)
!70 = distinct !DILexicalBlock(scope: !67, file: !1, line: 14, column: 3)
!71 = !DILocation(line: 14, column: 13, scope: !70)
!72 = !DILocation(line: 14, column: 12, scope: !70)
!73 = !DILocation(line: 14, column: 3, scope: !67)
!74 = !DILocation(line: 15, column: 14, scope: !75)
!75 = distinct !DILexicalBlock(scope: !70, file: !1, line: 14, column: 20)
!76 = !DILocation(line: 15, column: 12, scope: !75)
!77 = !DILocation(line: 15, column: 9, scope: !75)
!78 = !DILocation(line: 16, column: 3, scope: !75)
!79 = !DILocation(line: 14, column: 17, scope: !70)
!80 = !DILocation(line: 14, column: 3, scope: !70)
!81 = distinct !{!81, !73, !82}
!82 = !DILocation(line: 16, column: 3, scope: !67)
!83 = !DILocation(line: 18, column: 3, scope: !9)
