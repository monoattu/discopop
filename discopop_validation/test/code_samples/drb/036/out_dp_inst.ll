; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"retval\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"argc\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"argv\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"tmp\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"len\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"saved_stack\00", align 1
@.str.6 = private unnamed_addr constant [12 x i8] c"__vla_expr0\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"i\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"a\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !7 {
entry:
  call void @__dp_func_entry(i32 16437, i32 1)
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %tmp = alloca i32, align 4
  %len = alloca i32, align 4
  %saved_stack = alloca i8*, align 8
  %__vla_expr0 = alloca i64, align 8
  %0 = ptrtoint i32* %retval to i64
  call void @__dp_write(i32 16437, i64 %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  store i32 0, i32* %retval, align 4
  %1 = ptrtoint i32* %argc.addr to i64
  call void @__dp_write(i32 16437, i64 %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0))
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !14, metadata !DIExpression()), !dbg !15
  %2 = ptrtoint i8*** %argv.addr to i64
  call void @__dp_write(i32 16437, i64 %2, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0))
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %tmp, metadata !20, metadata !DIExpression()), !dbg !21
  %3 = ptrtoint i32* %tmp to i64
  call void @__dp_write(i32 16441, i64 %3, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  store i32 10, i32* %tmp, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %len, metadata !23, metadata !DIExpression()), !dbg !24
  %4 = ptrtoint i32* %len to i64
  call void @__dp_write(i32 16442, i64 %4, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0))
  store i32 100, i32* %len, align 4, !dbg !24
  %5 = ptrtoint i32* %argc.addr to i64
  call void @__dp_read(i32 16444, i64 %5, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0))
  %6 = load i32, i32* %argc.addr, align 4, !dbg !25
  %cmp = icmp sgt i32 %6, 1, !dbg !27
  br i1 %cmp, label %if.then, label %if.end, !dbg !28

if.then:                                          ; preds = %entry
  %7 = ptrtoint i8*** %argv.addr to i64
  call void @__dp_read(i32 16445, i64 %7, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0))
  %8 = load i8**, i8*** %argv.addr, align 8, !dbg !29
  %arrayidx = getelementptr inbounds i8*, i8** %8, i64 1, !dbg !29
  %9 = ptrtoint i8** %arrayidx to i64
  call void @__dp_read(i32 16445, i64 %9, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0))
  %10 = load i8*, i8** %arrayidx, align 8, !dbg !29
  call void @__dp_call(i32 16445), !dbg !30
  %call = call i32 @atoi(i8* %10) #4, !dbg !30
  %11 = ptrtoint i32* %len to i64
  call void @__dp_write(i32 16445, i64 %11, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0))
  store i32 %call, i32* %len, align 4, !dbg !31
  br label %if.end, !dbg !32

if.end:                                           ; preds = %if.then, %entry
  %12 = ptrtoint i32* %len to i64
  call void @__dp_read(i32 16447, i64 %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0))
  %13 = load i32, i32* %len, align 4, !dbg !33
  %14 = zext i32 %13 to i64, !dbg !34
  call void @__dp_call(i32 16447), !dbg !34
  %15 = call i8* @llvm.stacksave(), !dbg !34
  %16 = ptrtoint i8** %saved_stack to i64
  call void @__dp_write(i32 16447, i64 %16, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0))
  store i8* %15, i8** %saved_stack, align 8, !dbg !34
  %vla = alloca i32, i64 %14, align 16, !dbg !34
  %17 = ptrtoint i64* %__vla_expr0 to i64
  call void @__dp_write(i32 16447, i64 %17, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.6, i32 0, i32 0))
  store i64 %14, i64* %__vla_expr0, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata i64* %__vla_expr0, metadata !35, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata i32* %vla, metadata !38, metadata !DIExpression()), !dbg !42
  %18 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16449, i64 %18, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  store i32 0, i32* %i, align 4, !dbg !43
  br label %for.cond, !dbg !45

for.cond:                                         ; preds = %for.inc, %if.end
  call void @__dp_loop_entry(i32 16449, i32 0)
  %19 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16449, i64 %19, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %20 = load i32, i32* %i, align 4, !dbg !46
  %21 = ptrtoint i32* %len to i64
  call void @__dp_read(i32 16449, i64 %21, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0))
  %22 = load i32, i32* %len, align 4, !dbg !48
  %cmp1 = icmp slt i32 %20, %22, !dbg !49
  br i1 %cmp1, label %for.body, label %for.end, !dbg !50

for.body:                                         ; preds = %for.cond
  %23 = ptrtoint i32* %tmp to i64
  call void @__dp_read(i32 16451, i64 %23, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  %24 = load i32, i32* %tmp, align 4, !dbg !51
  %25 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16451, i64 %25, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %26 = load i32, i32* %i, align 4, !dbg !53
  %idxprom = sext i32 %26 to i64, !dbg !54
  %arrayidx2 = getelementptr inbounds i32, i32* %vla, i64 %idxprom, !dbg !54
  %27 = ptrtoint i32* %arrayidx2 to i64
  call void @__dp_write(i32 16451, i64 %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i32 0, i32 0))
  store i32 %24, i32* %arrayidx2, align 4, !dbg !55
  %28 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16452, i64 %28, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %29 = load i32, i32* %i, align 4, !dbg !56
  %idxprom3 = sext i32 %29 to i64, !dbg !57
  %arrayidx4 = getelementptr inbounds i32, i32* %vla, i64 %idxprom3, !dbg !57
  %30 = ptrtoint i32* %arrayidx4 to i64
  call void @__dp_read(i32 16452, i64 %30, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i32 0, i32 0))
  %31 = load i32, i32* %arrayidx4, align 4, !dbg !57
  %32 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16452, i64 %32, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %33 = load i32, i32* %i, align 4, !dbg !58
  %add = add nsw i32 %31, %33, !dbg !59
  %34 = ptrtoint i32* %tmp to i64
  call void @__dp_write(i32 16452, i64 %34, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0))
  store i32 %add, i32* %tmp, align 4, !dbg !60
  br label %for.inc, !dbg !61

for.inc:                                          ; preds = %for.body
  %35 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 16449, i64 %35, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %36 = load i32, i32* %i, align 4, !dbg !62
  %inc = add nsw i32 %36, 1, !dbg !62
  %37 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 16449, i64 %37, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  store i32 %inc, i32* %i, align 4, !dbg !62
  br label %for.cond, !dbg !63, !llvm.loop !64

for.end:                                          ; preds = %for.cond
  call void @__dp_loop_exit(i32 16454, i32 0)
  %38 = ptrtoint i32* %retval to i64
  call void @__dp_write(i32 16454, i64 %38, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  store i32 0, i32* %retval, align 4, !dbg !66
  %39 = ptrtoint i8** %saved_stack to i64
  call void @__dp_read(i32 16455, i64 %39, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0))
  %40 = load i8*, i8** %saved_stack, align 8, !dbg !67
  call void @__dp_call(i32 16455), !dbg !67
  call void @llvm.stackrestore(i8* %40), !dbg !67
  %41 = ptrtoint i32* %retval to i64
  call void @__dp_read(i32 16455, i64 %41, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  %42 = load i32, i32* %retval, align 4, !dbg !67
  call void @__dp_finalize(i32 16455), !dbg !67
  ret i32 %42, !dbg !67
}

declare void @__dp_func_entry(i32, i32)

declare void @__dp_write(i32, i64, i8*)

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__dp_read(i32, i64, i8*)

declare void @__dp_call(i32)

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #2

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #3

declare void @__dp_loop_entry(i32, i32)

declare void @__dp_loop_exit(i32, i32)

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #3

declare void @__dp_finalize(i32)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.1.0-6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "simple.c", directory: "/home/lukas/git/discopop/discopop_validation/test/code_samples/drb/036")
!2 = !{}
!3 = !{!"Ubuntu clang version 11.1.0-6"}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 53, type: !8, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DILocalVariable(name: "argc", arg: 1, scope: !7, file: !1, line: 53, type: !10)
!15 = !DILocation(line: 53, column: 14, scope: !7)
!16 = !DILocalVariable(name: "argv", arg: 2, scope: !7, file: !1, line: 53, type: !11)
!17 = !DILocation(line: 53, column: 26, scope: !7)
!18 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 55, type: !10)
!19 = !DILocation(line: 55, column: 7, scope: !7)
!20 = !DILocalVariable(name: "tmp", scope: !7, file: !1, line: 56, type: !10)
!21 = !DILocation(line: 56, column: 7, scope: !7)
!22 = !DILocation(line: 57, column: 7, scope: !7)
!23 = !DILocalVariable(name: "len", scope: !7, file: !1, line: 58, type: !10)
!24 = !DILocation(line: 58, column: 7, scope: !7)
!25 = !DILocation(line: 60, column: 7, scope: !26)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 60, column: 7)
!27 = !DILocation(line: 60, column: 11, scope: !26)
!28 = !DILocation(line: 60, column: 7, scope: !7)
!29 = !DILocation(line: 61, column: 16, scope: !26)
!30 = !DILocation(line: 61, column: 11, scope: !26)
!31 = !DILocation(line: 61, column: 9, scope: !26)
!32 = !DILocation(line: 61, column: 5, scope: !26)
!33 = !DILocation(line: 63, column: 9, scope: !7)
!34 = !DILocation(line: 63, column: 3, scope: !7)
!35 = !DILocalVariable(name: "__vla_expr0", scope: !7, type: !36, flags: DIFlagArtificial)
!36 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!37 = !DILocation(line: 0, scope: !7)
!38 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 63, type: !39)
!39 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, elements: !40)
!40 = !{!41}
!41 = !DISubrange(count: !35)
!42 = !DILocation(line: 63, column: 7, scope: !7)
!43 = !DILocation(line: 65, column: 9, scope: !44)
!44 = distinct !DILexicalBlock(scope: !7, file: !1, line: 65, column: 3)
!45 = !DILocation(line: 65, column: 8, scope: !44)
!46 = !DILocation(line: 65, column: 12, scope: !47)
!47 = distinct !DILexicalBlock(scope: !44, file: !1, line: 65, column: 3)
!48 = !DILocation(line: 65, column: 14, scope: !47)
!49 = !DILocation(line: 65, column: 13, scope: !47)
!50 = !DILocation(line: 65, column: 3, scope: !44)
!51 = !DILocation(line: 67, column: 12, scope: !52)
!52 = distinct !DILexicalBlock(scope: !47, file: !1, line: 66, column: 3)
!53 = !DILocation(line: 67, column: 7, scope: !52)
!54 = !DILocation(line: 67, column: 5, scope: !52)
!55 = !DILocation(line: 67, column: 10, scope: !52)
!56 = !DILocation(line: 68, column: 12, scope: !52)
!57 = !DILocation(line: 68, column: 10, scope: !52)
!58 = !DILocation(line: 68, column: 15, scope: !52)
!59 = !DILocation(line: 68, column: 14, scope: !52)
!60 = !DILocation(line: 68, column: 9, scope: !52)
!61 = !DILocation(line: 69, column: 3, scope: !52)
!62 = !DILocation(line: 65, column: 19, scope: !47)
!63 = !DILocation(line: 65, column: 3, scope: !47)
!64 = distinct !{!64, !50, !65}
!65 = !DILocation(line: 69, column: 3, scope: !44)
!66 = !DILocation(line: 70, column: 3, scope: !7)
!67 = !DILocation(line: 71, column: 1, scope: !7)
