; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str.1 = private unnamed_addr constant [7 x i8] c"retval\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"i\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"var\00", align 1
@.str = private unnamed_addr constant [19 x i8] c"Data Race Present\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  call void @__dp_func_entry(i32 16403, i32 1)
  %retval = alloca i32, align 4
  %var = alloca [100 x i32], align 16
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %i12 = alloca i32, align 4
  %0 = ptrtoint i32* %retval to i64
  call void @__dp_write(i32 16403, i64 %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [100 x i32]* %var, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !DIExpression()), !dbg !18
  %1 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16405, i64 %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 0, i32* %i, align 4, !dbg !18
  br label %for.cond, !dbg !19

for.cond:                                         ; preds = %for.inc, %entry
  call void @__dp_loop_entry(i32 16405, i32 0)
  %2 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16405, i64 %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %3 = load i32, i32* %i, align 4, !dbg !20
  %cmp = icmp slt i32 %3, 100, !dbg !22
  br i1 %cmp, label %for.body, label %for.end, !dbg !23

for.body:                                         ; preds = %for.cond
  %4 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16406, i64 %4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %5 = load i32, i32* %i, align 4, !dbg !24
  %idxprom = sext i32 %5 to i64, !dbg !26
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* %var, i64 0, i64 %idxprom, !dbg !26
  %6 = ptrtoint i32* %arrayidx to i64
  call void @__dp_write(i32 16406, i64 %6, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  store i32 0, i32* %arrayidx, align 4, !dbg !27
  br label %for.inc, !dbg !28

for.inc:                                          ; preds = %for.body
  %7 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16405, i64 %7, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %8 = load i32, i32* %i, align 4, !dbg !29
  %inc = add nsw i32 %8, 1, !dbg !29
  %9 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16405, i64 %9, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 %inc, i32* %i, align 4, !dbg !29
  br label %for.cond, !dbg !30, !llvm.loop !31

for.end:                                          ; preds = %for.cond
  call void @__dp_loop_exit(i32 16411, i32 0)
  call void @llvm.dbg.declare(metadata i32* %i1, metadata !33, metadata !DIExpression()), !dbg !35
  %10 = ptrtoint i32* %i1 to i64
  call void @__dp_write(i32 16411, i64 %10, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 1, i32* %i1, align 4, !dbg !35
  br label %for.cond2, !dbg !36

for.cond2:                                        ; preds = %for.inc9, %for.end
  call void @__dp_loop_entry(i32 16411, i32 1)
  %11 = ptrtoint i32* %i1 to i64
  call void @__dp_read(i32 16411, i64 %11, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %12 = load i32, i32* %i1, align 4, !dbg !37
  %cmp3 = icmp slt i32 %12, 100, !dbg !39
  br i1 %cmp3, label %for.body4, label %for.end11, !dbg !40

for.body4:                                        ; preds = %for.cond2
  %13 = ptrtoint i32* %i1 to i64
  call void @__dp_read(i32 16412, i64 %13, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %14 = load i32, i32* %i1, align 4, !dbg !41
  %sub = sub nsw i32 %14, 1, !dbg !43
  %idxprom5 = sext i32 %sub to i64, !dbg !44
  %arrayidx6 = getelementptr inbounds [100 x i32], [100 x i32]* %var, i64 0, i64 %idxprom5, !dbg !44
  %15 = ptrtoint i32* %arrayidx6 to i64
  call void @__dp_read(i32 16412, i64 %15, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  %16 = load i32, i32* %arrayidx6, align 4, !dbg !44
  %add = add nsw i32 %16, 1, !dbg !45
  %17 = ptrtoint i32* %i1 to i64
  call void @__dp_read(i32 16412, i64 %17, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %18 = load i32, i32* %i1, align 4, !dbg !46
  %idxprom7 = sext i32 %18 to i64, !dbg !47
  %arrayidx8 = getelementptr inbounds [100 x i32], [100 x i32]* %var, i64 0, i64 %idxprom7, !dbg !47
  %19 = ptrtoint i32* %arrayidx8 to i64
  call void @__dp_write(i32 16412, i64 %19, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  store i32 %add, i32* %arrayidx8, align 4, !dbg !48
  br label %for.inc9, !dbg !49

for.inc9:                                         ; preds = %for.body4
  %20 = ptrtoint i32* %i1 to i64
  call void @__dp_read(i32 16411, i64 %20, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %21 = load i32, i32* %i1, align 4, !dbg !50
  %inc10 = add nsw i32 %21, 1, !dbg !50
  %22 = ptrtoint i32* %i1 to i64
  call void @__dp_write(i32 16411, i64 %22, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 %inc10, i32* %i1, align 4, !dbg !50
  br label %for.cond2, !dbg !51, !llvm.loop !52

for.end11:                                        ; preds = %for.cond2
  call void @__dp_loop_exit(i32 16415, i32 1)
  call void @llvm.dbg.declare(metadata i32* %i12, metadata !54, metadata !DIExpression()), !dbg !56
  %23 = ptrtoint i32* %i12 to i64
  call void @__dp_write(i32 16415, i64 %23, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 0, i32* %i12, align 4, !dbg !56
  br label %for.cond13, !dbg !57

for.cond13:                                       ; preds = %for.inc19, %for.end11
  call void @__dp_loop_entry(i32 16415, i32 2)
  %24 = ptrtoint i32* %i12 to i64
  call void @__dp_read(i32 16415, i64 %24, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %25 = load i32, i32* %i12, align 4, !dbg !58
  %cmp14 = icmp slt i32 %25, 100, !dbg !60
  br i1 %cmp14, label %for.body15, label %for.end21, !dbg !61

for.body15:                                       ; preds = %for.cond13
  %26 = ptrtoint i32* %i12 to i64
  call void @__dp_read(i32 16416, i64 %26, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %27 = load i32, i32* %i12, align 4, !dbg !62
  %idxprom16 = sext i32 %27 to i64, !dbg !65
  %arrayidx17 = getelementptr inbounds [100 x i32], [100 x i32]* %var, i64 0, i64 %idxprom16, !dbg !65
  %28 = ptrtoint i32* %arrayidx17 to i64
  call void @__dp_read(i32 16416, i64 %28, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  %29 = load i32, i32* %arrayidx17, align 4, !dbg !65
  %30 = ptrtoint i32* %i12 to i64
  call void @__dp_read(i32 16416, i64 %30, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %31 = load i32, i32* %i12, align 4, !dbg !66
  %cmp18 = icmp ne i32 %29, %31, !dbg !67
  br i1 %cmp18, label %if.then, label %if.end, !dbg !68

if.then:                                          ; preds = %for.body15
  call void @__dp_call(i32 16417), !dbg !69
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0)), !dbg !69
  %32 = ptrtoint i32* %retval to i64
  call void @__dp_write(i32 16418, i64 %32, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %retval, align 4, !dbg !71
  br label %return, !dbg !71

if.end:                                           ; preds = %for.body15
  br label %for.inc19, !dbg !72

for.inc19:                                        ; preds = %if.end
  %33 = ptrtoint i32* %i12 to i64
  call void @__dp_read(i32 16415, i64 %33, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  %34 = load i32, i32* %i12, align 4, !dbg !73
  %inc20 = add nsw i32 %34, 1, !dbg !73
  %35 = ptrtoint i32* %i12 to i64
  call void @__dp_write(i32 16415, i64 %35, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store i32 %inc20, i32* %i12, align 4, !dbg !73
  br label %for.cond13, !dbg !74, !llvm.loop !75

for.end21:                                        ; preds = %for.cond13
  call void @__dp_loop_exit(i32 16421, i32 2)
  %36 = ptrtoint i32* %retval to i64
  call void @__dp_write(i32 16421, i64 %36, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %retval, align 4, !dbg !77
  br label %return, !dbg !77

return:                                           ; preds = %for.end21, %if.then
  %37 = ptrtoint i32* %retval to i64
  call void @__dp_read(i32 16422, i64 %37, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0))
  %38 = load i32, i32* %retval, align 4, !dbg !78
  call void @__dp_finalize(i32 16422), !dbg !78
  ret i32 %38, !dbg !78
}

declare void @__dp_func_entry(i32, i32)

declare void @__dp_write(i32, i64, i8*)

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__dp_loop_entry(i32, i32)

declare void @__dp_read(i32, i64, i8*)

declare void @__dp_loop_exit(i32, i32)

declare void @__dp_call(i32)

declare dso_local i32 @printf(i8*, ...) #2

declare void @__dp_finalize(i32)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.1.0-6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "simple.c", directory: "/home/lukas/git/discopop/discopop_validation/test/code_samples/drb/156")
!2 = !{}
!3 = !{!"Ubuntu clang version 11.1.0-6"}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 19, type: !8, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "var", scope: !7, file: !1, line: 20, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 3200, elements: !13)
!13 = !{!14}
!14 = !DISubrange(count: 100)
!15 = !DILocation(line: 20, column: 7, scope: !7)
!16 = !DILocalVariable(name: "i", scope: !17, file: !1, line: 21, type: !10)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 21, column: 3)
!18 = !DILocation(line: 21, column: 11, scope: !17)
!19 = !DILocation(line: 21, column: 7, scope: !17)
!20 = !DILocation(line: 21, column: 16, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 21, column: 3)
!22 = !DILocation(line: 21, column: 17, scope: !21)
!23 = !DILocation(line: 21, column: 3, scope: !17)
!24 = !DILocation(line: 22, column: 9, scope: !25)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 21, column: 25)
!26 = !DILocation(line: 22, column: 5, scope: !25)
!27 = !DILocation(line: 22, column: 11, scope: !25)
!28 = !DILocation(line: 23, column: 3, scope: !25)
!29 = !DILocation(line: 21, column: 22, scope: !21)
!30 = !DILocation(line: 21, column: 3, scope: !21)
!31 = distinct !{!31, !23, !32}
!32 = !DILocation(line: 23, column: 3, scope: !17)
!33 = !DILocalVariable(name: "i", scope: !34, file: !1, line: 27, type: !10)
!34 = distinct !DILexicalBlock(scope: !7, file: !1, line: 27, column: 3)
!35 = !DILocation(line: 27, column: 12, scope: !34)
!36 = !DILocation(line: 27, column: 8, scope: !34)
!37 = !DILocation(line: 27, column: 17, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 27, column: 3)
!39 = !DILocation(line: 27, column: 18, scope: !38)
!40 = !DILocation(line: 27, column: 3, scope: !34)
!41 = !DILocation(line: 28, column: 16, scope: !42)
!42 = distinct !DILexicalBlock(scope: !38, file: !1, line: 27, column: 26)
!43 = !DILocation(line: 28, column: 17, scope: !42)
!44 = !DILocation(line: 28, column: 12, scope: !42)
!45 = !DILocation(line: 28, column: 20, scope: !42)
!46 = !DILocation(line: 28, column: 9, scope: !42)
!47 = !DILocation(line: 28, column: 5, scope: !42)
!48 = !DILocation(line: 28, column: 11, scope: !42)
!49 = !DILocation(line: 29, column: 3, scope: !42)
!50 = !DILocation(line: 27, column: 23, scope: !38)
!51 = !DILocation(line: 27, column: 3, scope: !38)
!52 = distinct !{!52, !40, !53}
!53 = !DILocation(line: 29, column: 3, scope: !34)
!54 = !DILocalVariable(name: "i", scope: !55, file: !1, line: 31, type: !10)
!55 = distinct !DILexicalBlock(scope: !7, file: !1, line: 31, column: 3)
!56 = !DILocation(line: 31, column: 11, scope: !55)
!57 = !DILocation(line: 31, column: 7, scope: !55)
!58 = !DILocation(line: 31, column: 16, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 31, column: 3)
!60 = !DILocation(line: 31, column: 17, scope: !59)
!61 = !DILocation(line: 31, column: 3, scope: !55)
!62 = !DILocation(line: 32, column: 12, scope: !63)
!63 = distinct !DILexicalBlock(scope: !64, file: !1, line: 32, column: 8)
!64 = distinct !DILexicalBlock(scope: !59, file: !1, line: 31, column: 25)
!65 = !DILocation(line: 32, column: 8, scope: !63)
!66 = !DILocation(line: 32, column: 16, scope: !63)
!67 = !DILocation(line: 32, column: 14, scope: !63)
!68 = !DILocation(line: 32, column: 8, scope: !64)
!69 = !DILocation(line: 33, column: 7, scope: !70)
!70 = distinct !DILexicalBlock(scope: !63, file: !1, line: 32, column: 18)
!71 = !DILocation(line: 34, column: 7, scope: !70)
!72 = !DILocation(line: 36, column: 3, scope: !64)
!73 = !DILocation(line: 31, column: 22, scope: !59)
!74 = !DILocation(line: 31, column: 3, scope: !59)
!75 = distinct !{!75, !61, !76}
!76 = !DILocation(line: 36, column: 3, scope: !55)
!77 = !DILocation(line: 37, column: 3, scope: !7)
!78 = !DILocation(line: 38, column: 1, scope: !7)