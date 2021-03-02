/*
 * This file is part of the DiscoPoP software (http://www.discopop.tu-darmstadt.de)
 *
 * Copyright (c) 2020, Technische Universitaet Darmstadt, Germany
 *
 * This software may be modified and distributed under the terms of
 * the 3-Clause BSD License. See the LICENSE file in the package base
 * directory for details.
 *
 */

#ifndef _DP_IFUNCTIONS_H_
#define _DP_IFUNCTIONS_H_

//#define SKIP_DUP_INSTR 1

#include <algorithm>
#include <cstdlib>
#include <pthread.h>
#include <queue>
#include <set>
#include <stack>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <string.h>
#include "DPUtils.h"
// hybrid analysis
 #include <regex>
 // End HA
namespace __dp
{

    /******* Data structures *******/

    typedef enum
    {
        RAW,
        WAR,
        WAW,
        INIT
    }
    depType;

    struct AccessInfo
    {
        AccessInfo(bool isRead, LID lid, char *var, ADDR addr, bool skip = false)
            : isRead(isRead), lid(lid), var(var), addr(addr), skip(skip) {}
        AccessInfo() : lid(0) {}

        bool isRead;
        // hybrid analysis 
        bool skip;
        // End HA
        LID lid;
        char *var;
        ADDR addr;
    };

    // For runtime dependency merging
    struct Dep
    {
        Dep(depType T, LID dep, char *var) : type(T), depOn(dep), var(var) {}

        depType type;
        LID depOn;
        char *var;
    };

    struct compDep
    {
        bool operator()(const Dep &a, const Dep &b)
        {
            if (a.type < b.type)
            {
                return true;
            }
            else if (a.type == b.type && a.depOn < b.depOn)
            {
                return true;
            }
            // comparison between string is very time-consuming. So just compare variable names
            // according to address (we only need to distinguish them)
            else if (a.type == b.type && a.depOn == b.depOn && ((size_t)a.var < (size_t)b.var))
            {
                return true;
            }

            return false;
        }
    };

    typedef std::set<Dep, compDep> depSet;
    typedef std::unordered_map<LID, depSet *> depMap;
    // Hybrid anaysis
    typedef std::unordered_map<std::string, std::set<std::string>> stringDepMap;
    // End HA

    // For loop tracking
    struct LoopTableEntry
    {
        LoopTableEntry(int32_t l, int32_t id, int32_t c, LID b) : funcLevel(l), loopID(id), count(c), begin(b) {}

        int32_t funcLevel;
        int32_t loopID;
        int32_t count;
        LID begin;
    };

    typedef std::stack<LoopTableEntry> LoopTable;

    // For loop merging
    // Assumption: no more than one loops can begin at the same line
    struct LoopRecord
    {
        LoopRecord(LID e, int32_t t, int32_t n) : end(e), total(t), nEntered(n) {}

        LID end;
        int32_t total;
        int32_t nEntered;
    };

    typedef std::unordered_map<LID, LoopRecord *> LoopRecords;

    // For function merging
    // 1) when two BGN func are identical

    typedef std::unordered_map<LID, std::set<LID>*> BGNFuncList;

    // Hybrid analysis
    typedef std::set<int32_t> ReportedBBSet;
    typedef std::set<std::string> ReportedBBPairSet;
    // End HA
    // 2) when two END func are identical

    typedef std::set<LID> ENDFuncList;

    /******* Helper functions *******/

    void addDep(depType type, LID curr, LID depOn, char *var);
    void outputDeps();
    void outputLoops();
    void outputFuncs();
    void readRuntimeInfo();
    void initParallelization();
    void mergeDeps();
    void *analyzeDeps(void *arg);
    void addAccessInfo(bool isRead, LID lid, char *var, ADDR addr);
    void finalizeParallelization();

    /******* Instrumentation functions *******/
    extern "C" {
#ifdef SKIP_DUP_INSTR
        void __dp_read(LID lid, ADDR addr, char *var, ADDR lastaddr, int64_t count);
        void __dp_write(LID lid, ADDR addr, char *var, ADDR lastaddr, int64_t count);
        // hybrid analysis
        void __dp_decl(LID lid, ADDR addr, char *var, ADDR lastaddr, int64_t count);
        void __dp_alloca(LID lid, ADDR addr, char *var, ADDR lastaddr, int64_t count);
        // End HA
#else
        void __dp_read(LID lid, ADDR addr, char *var);
        void __dp_write(LID lid, ADDR addr, char *var);
        // hybrid analysis
        void __dp_decl(LID lid, ADDR addr, char *var);
        void __dp_alloca(LID lid, ADDR addr, char *var);
        // End HA
#endif
        // hybrid analysis
        void __dp_report_bb(int32_t bbIndex);
        void __dp_report_bb_pair(int32_t counter, int32_t bbIndex);
        void __dp_add_bb_deps(char* depStringPtr);
        // End HA
        void __dp_finalize(LID lid);
        void __dp_call(LID lid);
        void __dp_func_entry(LID lid, int32_t isStart);
        void __dp_func_exit(LID lid, int32_t isExit);
        void __dp_loop_entry(LID lid, int32_t loopID);
        void __dp_loop_exit(LID lid, int32_t loopID);
    }
} // namespace __dp
#endif
