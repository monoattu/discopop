; ModuleID = 'DRB045-doall1-orig-no.c'
source_filename = "DRB045-doall1-orig-no.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = common dso_local global [100 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !14 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 0, i32* %i, align 4, !dbg !19
  br label %for.cond, !dbg !21

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !22
  %cmp = icmp slt i32 %0, 100, !dbg !24
  br i1 %cmp, label %for.body, label %for.end, !dbg !25

for.body:                                         ; preds = %for.cond
  call void @incr_loop_counter(i32 1)
  %1 = load i32, i32* %i, align 4, !dbg !26
  %idxprom = sext i32 %1 to i64, !dbg !27
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* @a, i64 0, i64 %idxprom, !dbg !27
  %2 = ptrtoint i32* %arrayidx to i64
  call void @add_ptr_instr_rec(i32 55, i64 1, i32 0, i64 %2)
  %3 = load i32, i32* %arrayidx, align 4, !dbg !27
  %add = add nsw i32 %3, 1, !dbg !28
  %4 = load i32, i32* %i, align 4, !dbg !29
  %idxprom1 = sext i32 %4 to i64, !dbg !30
  %arrayidx2 = getelementptr inbounds [100 x i32], [100 x i32]* @a, i64 0, i64 %idxprom1, !dbg !30
  %5 = ptrtoint i32* %arrayidx2 to i64
  call void @add_ptr_instr_rec(i32 55, i64 1, i32 1, i64 %5)
  store i32 %add, i32* %arrayidx2, align 4, !dbg !31
  br label %for.inc, !dbg !30

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !32
  %inc = add nsw i32 %6, 1, !dbg !32
  store i32 %inc, i32* %i, align 4, !dbg !32
  br label %for.cond, !dbg !33, !llvm.loop !34

for.end:                                          ; preds = %for.cond
  call void @loop_counter_output(), !dbg !36
  ret i32 0, !dbg !36
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @add_instr_rec(i32, i64, i32)

declare void @add_ptr_instr_rec(i32, i64, i32, i64)

declare void @incr_loop_counter(i32)

declare void @loop_counter_output()

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 50, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.1-9 (tags/RELEASE_801/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "DRB045-doall1-orig-no.c", directory: "/home/lukas/git/discopop/discopop_validation/test/code_samples/benchmark_datarace/do_all/DRB045")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 3200, elements: !8)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!9}
!9 = !DISubrange(count: 100)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 8.0.1-9 (tags/RELEASE_801/final)"}
!14 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 51, type: !15, scopeLine: 52, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{!7}
!17 = !DILocalVariable(name: "i", scope: !14, file: !3, line: 53, type: !7)
!18 = !DILocation(line: 53, column: 5, scope: !14)
!19 = !DILocation(line: 55, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !14, file: !3, line: 55, column: 3)
!21 = !DILocation(line: 55, column: 8, scope: !20)
!22 = !DILocation(line: 55, column: 12, scope: !23)
!23 = distinct !DILexicalBlock(scope: !20, file: !3, line: 55, column: 3)
!24 = !DILocation(line: 55, column: 13, scope: !23)
!25 = !DILocation(line: 55, column: 3, scope: !20)
!26 = !DILocation(line: 56, column: 12, scope: !23)
!27 = !DILocation(line: 56, column: 10, scope: !23)
!28 = !DILocation(line: 56, column: 14, scope: !23)
!29 = !DILocation(line: 56, column: 7, scope: !23)
!30 = !DILocation(line: 56, column: 5, scope: !23)
!31 = !DILocation(line: 56, column: 9, scope: !23)
!32 = !DILocation(line: 55, column: 19, scope: !23)
!33 = !DILocation(line: 55, column: 3, scope: !23)
!34 = distinct !{!34, !25, !35}
!35 = !DILocation(line: 56, column: 15, scope: !20)
!36 = !DILocation(line: 57, column: 3, scope: !14)
