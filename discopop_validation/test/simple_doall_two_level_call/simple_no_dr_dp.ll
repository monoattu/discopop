; ModuleID = '/home/lukas/Schreibtisch/dp_no_dr/simple_no_dr.c'
source_filename = "/home/lukas/Schreibtisch/dp_no_dr/simple_no_dr.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [18 x i8] c"p_read_value.addr\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"i_0.addr\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"p_arr.addr\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"y\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"i_0\00", align 1
@.str.7 = private unnamed_addr constant [4 x i8] c"arr\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"z\00", align 1
@.str.9 = private unnamed_addr constant [7 x i8] c"retval\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_Z12write_to_arrPiiS_(i32* %p_arr, i32 %i_0, i32* %p_read_value) #0 !dbg !7 {
entry:
  call void @__dp_func_entry(i32 16388, i32 0)
  %p_arr.addr = alloca i32*, align 8
  %i_0.addr = alloca i32, align 4
  %p_read_value.addr = alloca i32*, align 8
  store i32* %p_arr, i32** %p_arr.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %p_arr.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 %i_0, i32* %i_0.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i_0.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store i32* %p_read_value, i32** %p_read_value.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %p_read_value.addr, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = ptrtoint i32** %p_read_value.addr to i64
  call void @__dp_read(i32 16389, i64 %0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  %1 = load i32*, i32** %p_read_value.addr, align 8, !dbg !19
  %2 = ptrtoint i32* %1 to i64
  call void @__dp_read(i32 16389, i64 %2, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  %3 = load i32, i32* %1, align 4, !dbg !20
  %4 = ptrtoint i32* %i_0.addr to i64
  call void @__dp_read(i32 16389, i64 %4, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0))
  %5 = load i32, i32* %i_0.addr, align 4, !dbg !21
  %add = add nsw i32 %3, %5, !dbg !22
  %6 = ptrtoint i32** %p_arr.addr to i64
  call void @__dp_read(i32 16389, i64 %6, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0))
  %7 = load i32*, i32** %p_arr.addr, align 8, !dbg !23
  %8 = ptrtoint i32* %i_0.addr to i64
  call void @__dp_read(i32 16389, i64 %8, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0))
  %9 = load i32, i32* %i_0.addr, align 4, !dbg !24
  %idx.ext = sext i32 %9 to i64, !dbg !25
  %add.ptr = getelementptr inbounds i32, i32* %7, i64 %idx.ext, !dbg !25
  %10 = ptrtoint i32* %add.ptr to i64
  call void @__dp_write(i32 16389, i64 %10, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0))
  store i32 %add, i32* %add.ptr, align 4, !dbg !26
  call void @__dp_func_exit(i32 16390, i32 0), !dbg !27
  ret void, !dbg !27
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_Z17call_write_to_arrPiiS_(i32* %p_arr, i32 %i_0, i32* %p_read_value) #0 !dbg !28 {
entry:
  call void @__dp_func_entry(i32 16392, i32 0)
  %p_arr.addr = alloca i32*, align 8
  %i_0.addr = alloca i32, align 4
  %p_read_value.addr = alloca i32*, align 8
  store i32* %p_arr, i32** %p_arr.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %p_arr.addr, metadata !29, metadata !DIExpression()), !dbg !30
  store i32 %i_0, i32* %i_0.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i_0.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store i32* %p_read_value, i32** %p_read_value.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %p_read_value.addr, metadata !33, metadata !DIExpression()), !dbg !34
  %0 = ptrtoint i32** %p_arr.addr to i64
  call void @__dp_read(i32 16393, i64 %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0))
  %1 = load i32*, i32** %p_arr.addr, align 8, !dbg !35
  %2 = ptrtoint i32* %i_0.addr to i64
  call void @__dp_read(i32 16393, i64 %2, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0))
  %3 = load i32, i32* %i_0.addr, align 4, !dbg !36
  %4 = ptrtoint i32** %p_read_value.addr to i64
  call void @__dp_read(i32 16393, i64 %4, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  %5 = load i32*, i32** %p_read_value.addr, align 8, !dbg !37
  call void @__dp_call(i32 16393), !dbg !38
  call void @_Z12write_to_arrPiiS_(i32* %1, i32 %3, i32* %5), !dbg !38
  call void @__dp_func_exit(i32 16394, i32 0), !dbg !39
  ret void, !dbg !39
}

; Function Attrs: noinline norecurse nounwind optnone uwtable
define dso_local i32 @main() #2 !dbg !40 {
entry:
  call void @__dp_func_entry(i32 16397, i32 1)
  %retval = alloca i32, align 4
  %arr = alloca [10 x i32], align 16
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %a = alloca i32, align 4
  %i_0 = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [10 x i32]* %arr, metadata !43, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.declare(metadata i32* %x, metadata !48, metadata !DIExpression()), !dbg !49
  %0 = ptrtoint i32* %x to i64
  call void @__dp_write(i32 16398, i64 %0, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store i32 0, i32* %x, align 4, !dbg !49
  call void @llvm.dbg.declare(metadata i32* %y, metadata !50, metadata !DIExpression()), !dbg !51
  %1 = ptrtoint i32* %y to i64
  call void @__dp_write(i32 16399, i64 %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  store i32 0, i32* %y, align 4, !dbg !51
  call void @llvm.dbg.declare(metadata i32* %a, metadata !52, metadata !DIExpression()), !dbg !54
  %2 = ptrtoint i32* %a to i64
  call void @__dp_write(i32 16400, i64 %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  store i32 0, i32* %a, align 4, !dbg !54
  br label %for.cond, !dbg !55

for.cond:                                         ; preds = %for.inc, %entry
  call void @__dp_loop_entry(i32 16400, i32 0)
  %3 = ptrtoint i32* %a to i64
  call void @__dp_read(i32 16400, i64 %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  %4 = load i32, i32* %a, align 4, !dbg !56
  %cmp = icmp slt i32 %4, 10, !dbg !58
  br i1 %cmp, label %for.body, label %for.end, !dbg !59

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %i_0, metadata !60, metadata !DIExpression()), !dbg !62
  %5 = ptrtoint i32* %a to i64
  call void @__dp_read(i32 16401, i64 %5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  %6 = load i32, i32* %a, align 4, !dbg !63
  %7 = ptrtoint i32* %i_0 to i64
  call void @__dp_write(i32 16401, i64 %7, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  store i32 %6, i32* %i_0, align 4, !dbg !62
  %8 = ptrtoint i32* %a to i64
  call void @__dp_read(i32 16402, i64 %8, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  %9 = load i32, i32* %a, align 4, !dbg !64
  %10 = ptrtoint i32* %i_0 to i64
  call void @__dp_read(i32 16402, i64 %10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %11 = load i32, i32* %i_0, align 4, !dbg !65
  %add = add nsw i32 %9, %11, !dbg !66
  %12 = ptrtoint i32* %i_0 to i64
  call void @__dp_read(i32 16402, i64 %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %13 = load i32, i32* %i_0, align 4, !dbg !67
  %idxprom = sext i32 %13 to i64, !dbg !68
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %arr, i64 0, i64 %idxprom, !dbg !68
  %14 = ptrtoint i32* %arrayidx to i64
  call void @__dp_write(i32 16402, i64 %14, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0))
  store i32 %add, i32* %arrayidx, align 4, !dbg !69
  %arraydecay = getelementptr inbounds [10 x i32], [10 x i32]* %arr, i32 0, i32 0, !dbg !70
  %15 = ptrtoint i32* %i_0 to i64
  call void @__dp_read(i32 16403, i64 %15, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %16 = load i32, i32* %i_0, align 4, !dbg !71
  call void @__dp_call(i32 16403), !dbg !72
  call void @_Z17call_write_to_arrPiiS_(i32* %arraydecay, i32 %16, i32* %a), !dbg !72
  call void @llvm.dbg.declare(metadata i32* %z, metadata !73, metadata !DIExpression()), !dbg !74
  %17 = ptrtoint i32* %z to i64
  call void @__dp_write(i32 16405, i64 %17, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i32 0, i32 0))
  store i32 0, i32* %z, align 4, !dbg !74
  %18 = ptrtoint i32* %x to i64
  call void @__dp_read(i32 16406, i64 %18, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %19 = load i32, i32* %x, align 4, !dbg !75
  %cmp1 = icmp sgt i32 %19, 3, !dbg !77
  br i1 %cmp1, label %if.then, label %if.end, !dbg !78

if.then:                                          ; preds = %for.body
  %20 = ptrtoint i32* %i_0 to i64
  call void @__dp_read(i32 16407, i64 %20, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %21 = load i32, i32* %i_0, align 4, !dbg !79
  %idxprom2 = sext i32 %21 to i64, !dbg !81
  %arrayidx3 = getelementptr inbounds [10 x i32], [10 x i32]* %arr, i64 0, i64 %idxprom2, !dbg !81
  %22 = ptrtoint i32* %arrayidx3 to i64
  call void @__dp_read(i32 16407, i64 %22, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0))
  %23 = load i32, i32* %arrayidx3, align 4, !dbg !81
  %add4 = add nsw i32 %23, 3, !dbg !82
  %24 = ptrtoint i32* %i_0 to i64
  call void @__dp_read(i32 16407, i64 %24, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %25 = load i32, i32* %i_0, align 4, !dbg !83
  %idxprom5 = sext i32 %25 to i64, !dbg !84
  %arrayidx6 = getelementptr inbounds [10 x i32], [10 x i32]* %arr, i64 0, i64 %idxprom5, !dbg !84
  %26 = ptrtoint i32* %arrayidx6 to i64
  call void @__dp_write(i32 16407, i64 %26, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0))
  store i32 %add4, i32* %arrayidx6, align 4, !dbg !85
  br label %if.end, !dbg !86

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc, !dbg !87

for.inc:                                          ; preds = %if.end
  %27 = ptrtoint i32* %a to i64
  call void @__dp_read(i32 16400, i64 %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  %28 = load i32, i32* %a, align 4, !dbg !88
  %inc = add nsw i32 %28, 1, !dbg !88
  %29 = ptrtoint i32* %a to i64
  call void @__dp_write(i32 16400, i64 %29, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  store i32 %inc, i32* %a, align 4, !dbg !88
  br label %for.cond, !dbg !89, !llvm.loop !90

for.end:                                          ; preds = %for.cond
  call void @__dp_loop_exit(i32 16411, i32 0)
  %30 = ptrtoint i32* %x to i64
  call void @__dp_read(i32 16411, i64 %30, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %31 = load i32, i32* %x, align 4, !dbg !92
  %cmp7 = icmp sgt i32 %31, 3, !dbg !94
  br i1 %cmp7, label %if.then8, label %if.else, !dbg !95

if.then8:                                         ; preds = %for.end
  %32 = ptrtoint i32* %y to i64
  call void @__dp_read(i32 16412, i64 %32, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %33 = load i32, i32* %y, align 4, !dbg !96
  %34 = ptrtoint i32* %x to i64
  call void @__dp_read(i32 16412, i64 %34, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %35 = load i32, i32* %x, align 4, !dbg !98
  %add9 = add nsw i32 %33, %35, !dbg !99
  %36 = ptrtoint i32* %y to i64
  call void @__dp_write(i32 16412, i64 %36, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  store i32 %add9, i32* %y, align 4, !dbg !100
  br label %if.end10, !dbg !101

if.else:                                          ; preds = %for.end
  %37 = ptrtoint i32* %y to i64
  call void @__dp_read(i32 16415, i64 %37, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  %38 = load i32, i32* %y, align 4, !dbg !102
  %39 = ptrtoint i32* %x to i64
  call void @__dp_read(i32 16415, i64 %39, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  %40 = load i32, i32* %x, align 4, !dbg !104
  %sub = sub nsw i32 %38, %40, !dbg !105
  %41 = ptrtoint i32* %y to i64
  call void @__dp_write(i32 16415, i64 %41, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0))
  store i32 %sub, i32* %y, align 4, !dbg !106
  br label %if.end10

if.end10:                                         ; preds = %if.else, %if.then8
  %42 = ptrtoint i32* %retval to i64
  call void @__dp_read(i32 16418, i64 %42, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i32 0, i32 0))
  %43 = load i32, i32* %retval, align 4, !dbg !107
  call void @__dp_finalize(i32 16418), !dbg !107
  ret i32 %43, !dbg !107
}

declare void @__dp_init(i32, i32, i32)

declare void @__dp_finalize(i32)

declare void @__dp_read(i32, i64, i8*)

declare void @__dp_write(i32, i64, i8*)

declare void @__dp_call(i32)

declare void @__dp_func_entry(i32, i32)

declare void @__dp_func_exit(i32, i32)

declare void @__dp_loop_entry(i32, i32)

declare void @__dp_loop_exit(i32, i32)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noinline norecurse nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 8.0.1 (tags/RELEASE_801/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "/home/lukas/Schreibtisch/dp_no_dr/simple_no_dr.c", directory: "/home/lukas/Schreibtisch/dp_no_dr/discopop-tmp")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.1 (tags/RELEASE_801/final)"}
!7 = distinct !DISubprogram(name: "write_to_arr", linkageName: "_Z12write_to_arrPiiS_", scope: !8, file: !8, line: 4, type: !9, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "simple_no_dr.c", directory: "/home/lukas/Schreibtisch/dp_no_dr")
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11, !12, !11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "p_arr", arg: 1, scope: !7, file: !8, line: 4, type: !11)
!14 = !DILocation(line: 4, column: 24, scope: !7)
!15 = !DILocalVariable(name: "i_0", arg: 2, scope: !7, file: !8, line: 4, type: !12)
!16 = !DILocation(line: 4, column: 35, scope: !7)
!17 = !DILocalVariable(name: "p_read_value", arg: 3, scope: !7, file: !8, line: 4, type: !11)
!18 = !DILocation(line: 4, column: 45, scope: !7)
!19 = !DILocation(line: 5, column: 23, scope: !7)
!20 = !DILocation(line: 5, column: 22, scope: !7)
!21 = !DILocation(line: 5, column: 38, scope: !7)
!22 = !DILocation(line: 5, column: 36, scope: !7)
!23 = !DILocation(line: 5, column: 7, scope: !7)
!24 = !DILocation(line: 5, column: 15, scope: !7)
!25 = !DILocation(line: 5, column: 13, scope: !7)
!26 = !DILocation(line: 5, column: 20, scope: !7)
!27 = !DILocation(line: 6, column: 1, scope: !7)
!28 = distinct !DISubprogram(name: "call_write_to_arr", linkageName: "_Z17call_write_to_arrPiiS_", scope: !8, file: !8, line: 8, type: !9, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DILocalVariable(name: "p_arr", arg: 1, scope: !28, file: !8, line: 8, type: !11)
!30 = !DILocation(line: 8, column: 29, scope: !28)
!31 = !DILocalVariable(name: "i_0", arg: 2, scope: !28, file: !8, line: 8, type: !12)
!32 = !DILocation(line: 8, column: 40, scope: !28)
!33 = !DILocalVariable(name: "p_read_value", arg: 3, scope: !28, file: !8, line: 8, type: !11)
!34 = !DILocation(line: 8, column: 50, scope: !28)
!35 = !DILocation(line: 9, column: 18, scope: !28)
!36 = !DILocation(line: 9, column: 25, scope: !28)
!37 = !DILocation(line: 9, column: 30, scope: !28)
!38 = !DILocation(line: 9, column: 5, scope: !28)
!39 = !DILocation(line: 10, column: 1, scope: !28)
!40 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 12, type: !41, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!12}
!43 = !DILocalVariable(name: "arr", scope: !40, file: !8, line: 13, type: !44)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 320, elements: !45)
!45 = !{!46}
!46 = !DISubrange(count: 10)
!47 = !DILocation(line: 13, column: 9, scope: !40)
!48 = !DILocalVariable(name: "x", scope: !40, file: !8, line: 14, type: !12)
!49 = !DILocation(line: 14, column: 9, scope: !40)
!50 = !DILocalVariable(name: "y", scope: !40, file: !8, line: 15, type: !12)
!51 = !DILocation(line: 15, column: 9, scope: !40)
!52 = !DILocalVariable(name: "a", scope: !53, file: !8, line: 16, type: !12)
!53 = distinct !DILexicalBlock(scope: !40, file: !8, line: 16, column: 5)
!54 = !DILocation(line: 16, column: 13, scope: !53)
!55 = !DILocation(line: 16, column: 9, scope: !53)
!56 = !DILocation(line: 16, column: 18, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !8, line: 16, column: 5)
!58 = !DILocation(line: 16, column: 20, scope: !57)
!59 = !DILocation(line: 16, column: 5, scope: !53)
!60 = !DILocalVariable(name: "i_0", scope: !61, file: !8, line: 17, type: !12)
!61 = distinct !DILexicalBlock(scope: !57, file: !8, line: 16, column: 30)
!62 = !DILocation(line: 17, column: 13, scope: !61)
!63 = !DILocation(line: 17, column: 17, scope: !61)
!64 = !DILocation(line: 18, column: 20, scope: !61)
!65 = !DILocation(line: 18, column: 24, scope: !61)
!66 = !DILocation(line: 18, column: 22, scope: !61)
!67 = !DILocation(line: 18, column: 13, scope: !61)
!68 = !DILocation(line: 18, column: 9, scope: !61)
!69 = !DILocation(line: 18, column: 18, scope: !61)
!70 = !DILocation(line: 19, column: 27, scope: !61)
!71 = !DILocation(line: 19, column: 32, scope: !61)
!72 = !DILocation(line: 19, column: 9, scope: !61)
!73 = !DILocalVariable(name: "z", scope: !61, file: !8, line: 21, type: !12)
!74 = !DILocation(line: 21, column: 13, scope: !61)
!75 = !DILocation(line: 22, column: 12, scope: !76)
!76 = distinct !DILexicalBlock(scope: !61, file: !8, line: 22, column: 12)
!77 = !DILocation(line: 22, column: 14, scope: !76)
!78 = !DILocation(line: 22, column: 12, scope: !61)
!79 = !DILocation(line: 23, column: 28, scope: !80)
!80 = distinct !DILexicalBlock(scope: !76, file: !8, line: 22, column: 18)
!81 = !DILocation(line: 23, column: 24, scope: !80)
!82 = !DILocation(line: 23, column: 33, scope: !80)
!83 = !DILocation(line: 23, column: 17, scope: !80)
!84 = !DILocation(line: 23, column: 13, scope: !80)
!85 = !DILocation(line: 23, column: 22, scope: !80)
!86 = !DILocation(line: 24, column: 9, scope: !80)
!87 = !DILocation(line: 25, column: 5, scope: !61)
!88 = !DILocation(line: 16, column: 27, scope: !57)
!89 = !DILocation(line: 16, column: 5, scope: !57)
!90 = distinct !{!90, !59, !91}
!91 = !DILocation(line: 25, column: 5, scope: !53)
!92 = !DILocation(line: 27, column: 8, scope: !93)
!93 = distinct !DILexicalBlock(scope: !40, file: !8, line: 27, column: 8)
!94 = !DILocation(line: 27, column: 10, scope: !93)
!95 = !DILocation(line: 27, column: 8, scope: !40)
!96 = !DILocation(line: 28, column: 13, scope: !97)
!97 = distinct !DILexicalBlock(scope: !93, file: !8, line: 27, column: 14)
!98 = !DILocation(line: 28, column: 17, scope: !97)
!99 = !DILocation(line: 28, column: 15, scope: !97)
!100 = !DILocation(line: 28, column: 11, scope: !97)
!101 = !DILocation(line: 29, column: 5, scope: !97)
!102 = !DILocation(line: 31, column: 13, scope: !103)
!103 = distinct !DILexicalBlock(scope: !93, file: !8, line: 30, column: 9)
!104 = !DILocation(line: 31, column: 17, scope: !103)
!105 = !DILocation(line: 31, column: 15, scope: !103)
!106 = !DILocation(line: 31, column: 11, scope: !103)
!107 = !DILocation(line: 34, column: 1, scope: !40)