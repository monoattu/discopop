#include "llvm/Support/CommandLine.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/DerivedTypes.h"

#include "InstructionDG.h"

#include "DPUtils.h"


using namespace llvm;
using namespace std;
using namespace dputil;

namespace {
    class DPInstrumentationOmission : public ModulePass {
    private:
        string fileName;
        Type *Void;
        IntegerType *Int32;
        PointerType *CharPtr;
        FunctionCallee ReportBB, ReportBBPair;
        dputil::VariableNameFinder *VNF;
        
    public:
        static char ID;
        StringRef getPassName() const override;
        bool runOnModule(Module &M) override;
        void getAnalysisUsage(AnalysisUsage &AU) const override;
        bool doInitialization(Module &M) override;

        DPInstrumentationOmission() : ModulePass(ID) {}
    };
}