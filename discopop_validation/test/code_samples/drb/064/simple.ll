; ModuleID = 'simple.c'
source_filename = "simple.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@n = dso_local global i32 100, align 4, !dbg !0
@m = dso_local global i32 100, align 4, !dbg !6
@b = dso_local global [100 x [100 x double]] zeroinitializer, align 16, !dbg !9

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foo() #0 !dbg !19 {
entry:
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %j, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 0, i32* %i, align 4, !dbg !26
  br label %for.cond, !dbg !28

for.cond:                                         ; preds = %for.inc10, %entry
  %0 = load i32, i32* %i, align 4, !dbg !29
  %1 = load i32, i32* @n, align 4, !dbg !31
  %cmp = icmp slt i32 %0, %1, !dbg !32
  br i1 %cmp, label %for.body, label %for.end12, !dbg !33

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %j, align 4, !dbg !34
  br label %for.cond1, !dbg !36

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32, i32* %j, align 4, !dbg !37
  %3 = load i32, i32* @m, align 4, !dbg !39
  %cmp2 = icmp slt i32 %2, %3, !dbg !40
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !41

for.body3:                                        ; preds = %for.cond1
  %4 = load i32, i32* %i, align 4, !dbg !42
  %idxprom = sext i32 %4 to i64, !dbg !43
  %arrayidx = getelementptr inbounds [100 x [100 x double]], [100 x [100 x double]]* @b, i64 0, i64 %idxprom, !dbg !43
  %5 = load i32, i32* %j, align 4, !dbg !44
  %sub = sub nsw i32 %5, 1, !dbg !45
  %idxprom4 = sext i32 %sub to i64, !dbg !43
  %arrayidx5 = getelementptr inbounds [100 x double], [100 x double]* %arrayidx, i64 0, i64 %idxprom4, !dbg !43
  %6 = load double, double* %arrayidx5, align 8, !dbg !43
  %7 = load i32, i32* %i, align 4, !dbg !46
  %idxprom6 = sext i32 %7 to i64, !dbg !47
  %arrayidx7 = getelementptr inbounds [100 x [100 x double]], [100 x [100 x double]]* @b, i64 0, i64 %idxprom6, !dbg !47
  %8 = load i32, i32* %j, align 4, !dbg !48
  %idxprom8 = sext i32 %8 to i64, !dbg !47
  %arrayidx9 = getelementptr inbounds [100 x double], [100 x double]* %arrayidx7, i64 0, i64 %idxprom8, !dbg !47
  store double %6, double* %arrayidx9, align 8, !dbg !49
  br label %for.inc, !dbg !47

for.inc:                                          ; preds = %for.body3
  %9 = load i32, i32* %j, align 4, !dbg !50
  %inc = add nsw i32 %9, 1, !dbg !50
  store i32 %inc, i32* %j, align 4, !dbg !50
  br label %for.cond1, !dbg !51, !llvm.loop !52

for.end:                                          ; preds = %for.cond1
  br label %for.inc10, !dbg !53

for.inc10:                                        ; preds = %for.end
  %10 = load i32, i32* %i, align 4, !dbg !54
  %inc11 = add nsw i32 %10, 1, !dbg !54
  store i32 %inc11, i32* %i, align 4, !dbg !54
  br label %for.cond, !dbg !55, !llvm.loop !56

for.end12:                                        ; preds = %for.cond
  ret void, !dbg !58
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !59 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @foo(), !dbg !62
  ret i32 0, !dbg !63
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!15, !16, !17}
!llvm.ident = !{!18}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "n", scope: !2, file: !3, line: 53, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.1.0-6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "simple.c", directory: "/home/lukas/git/discopop/discopop_validation/test/code_samples/drb/064")
!4 = !{}
!5 = !{!0, !6, !9}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "m", scope: !2, file: !3, line: 53, type: !8, isLocal: false, isDefinition: true)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIGlobalVariableExpression(var: !10, expr: !DIExpression())
!10 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 54, type: !11, isLocal: false, isDefinition: true)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 640000, elements: !13)
!12 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!13 = !{!14, !14}
!14 = !DISubrange(count: 100)
!15 = !{i32 7, !"Dwarf Version", i32 4}
!16 = !{i32 2, !"Debug Info Version", i32 3}
!17 = !{i32 1, !"wchar_size", i32 4}
!18 = !{!"Ubuntu clang version 11.1.0-6"}
!19 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 56, type: !20, scopeLine: 57, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!20 = !DISubroutineType(types: !21)
!21 = !{null}
!22 = !DILocalVariable(name: "i", scope: !19, file: !3, line: 58, type: !8)
!23 = !DILocation(line: 58, column: 7, scope: !19)
!24 = !DILocalVariable(name: "j", scope: !19, file: !3, line: 58, type: !8)
!25 = !DILocation(line: 58, column: 9, scope: !19)
!26 = !DILocation(line: 60, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !19, file: !3, line: 60, column: 3)
!28 = !DILocation(line: 60, column: 8, scope: !27)
!29 = !DILocation(line: 60, column: 12, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !3, line: 60, column: 3)
!31 = !DILocation(line: 60, column: 14, scope: !30)
!32 = !DILocation(line: 60, column: 13, scope: !30)
!33 = !DILocation(line: 60, column: 3, scope: !27)
!34 = !DILocation(line: 61, column: 11, scope: !35)
!35 = distinct !DILexicalBlock(scope: !30, file: !3, line: 61, column: 5)
!36 = !DILocation(line: 61, column: 10, scope: !35)
!37 = !DILocation(line: 61, column: 14, scope: !38)
!38 = distinct !DILexicalBlock(scope: !35, file: !3, line: 61, column: 5)
!39 = !DILocation(line: 61, column: 16, scope: !38)
!40 = !DILocation(line: 61, column: 15, scope: !38)
!41 = !DILocation(line: 61, column: 5, scope: !35)
!42 = !DILocation(line: 62, column: 17, scope: !38)
!43 = !DILocation(line: 62, column: 15, scope: !38)
!44 = !DILocation(line: 62, column: 20, scope: !38)
!45 = !DILocation(line: 62, column: 21, scope: !38)
!46 = !DILocation(line: 62, column: 9, scope: !38)
!47 = !DILocation(line: 62, column: 7, scope: !38)
!48 = !DILocation(line: 62, column: 12, scope: !38)
!49 = !DILocation(line: 62, column: 14, scope: !38)
!50 = !DILocation(line: 61, column: 19, scope: !38)
!51 = !DILocation(line: 61, column: 5, scope: !38)
!52 = distinct !{!52, !41, !53}
!53 = !DILocation(line: 62, column: 23, scope: !35)
!54 = !DILocation(line: 60, column: 17, scope: !30)
!55 = !DILocation(line: 60, column: 3, scope: !30)
!56 = distinct !{!56, !33, !57}
!57 = !DILocation(line: 62, column: 23, scope: !27)
!58 = !DILocation(line: 63, column: 1, scope: !19)
!59 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 65, type: !60, scopeLine: 66, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!60 = !DISubroutineType(types: !61)
!61 = !{!8}
!62 = !DILocation(line: 67, column: 3, scope: !59)
!63 = !DILocation(line: 68, column: 3, scope: !59)