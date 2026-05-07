# Ibex Core Examples

**Processor:** Ibex (RV32IMC)  
**Source:** lowRISC  
**Architecture:** In-order, 2-stage pipeline  
**Repository:** https://github.com/lowRISC/ibex

---

## 📁 Folder Structure

\\\
ibex/
├── original/           # Original Ibex RTL modules (30 files)
├── generated_trojans/  # Generated Trojan code snippets
├── trojaned_rtl/       # Complete RTL with Trojans inserted
└── results/            # Simulation and validation results
\\\

---

## 🎯 Modules Included (30 Total)

### Control & Security Modules ⭐ High Priority
- \ibex_cs_registers.sv\ - Control and Status Registers (CSR)
- \ibex_controller.sv\ - Main control unit
- \ibex_decoder.sv\ - Instruction decoder
- \ibex_pmp.sv\ - Physical Memory Protection

### Execution Units
- \ibex_alu.sv\ - Arithmetic Logic Unit
- \ibex_multdiv_slow.sv\ - Multiplier/Divider (slow)
- \ibex_multdiv_fast.sv\ - Multiplier/Divider (fast)
- \ibex_load_store_unit.sv\ - Load/Store Unit
- \ibex_ex_block.sv\ - Execute Block

### Pipeline Stages
- \ibex_if_stage.sv\ - Instruction Fetch
- \ibex_id_stage.sv\ - Instruction Decode
- \ibex_wb_stage.sv\ - Writeback Stage

### Memory & Cache
- \ibex_icache.sv\ - Instruction Cache
- \ibex_prefetch_buffer.sv\ - Prefetch Buffer
- \ibex_fetch_fifo.sv\ - Fetch FIFO

### Register Files
- \ibex_register_file_ff.sv\ - FF-based register file
- \ibex_register_file_fpga.sv\ - FPGA-optimized
- \ibex_register_file_latch.sv\ - Latch-based

### Other
- \ibex_core.sv\ - Top-level core
- \ibex_top.sv\ - Top module
- \ibex_pkg.sv\ - Package definitions
- And 9 more modules...

---

## 🔒 Security-Critical Modules

**Priority 1 (CSR & Control):**
1. \ibex_cs_registers.sv\ - Privilege escalation, leak, integrity
2. \ibex_controller.sv\ - DoS, availability
3. \ibex_pmp.sv\ - Access control bypass

**Priority 2 (Execution):**
4. \ibex_load_store_unit.sv\ - Memory integrity
5. \ibex_alu.sv\ - Data corruption
6. \ibex_decoder.sv\ - Instruction manipulation

---

## 📊 Trojan Generation

**Single Module:**
\\\ash
python scripts/generate_trojans.py examples/ibex/original/ibex_cs_registers.sv --output examples/ibex/generated_trojans/
\\\

**All Modules (Batch):**
\\\ash
python scripts/batch_generate.py examples/ibex/original/ --output examples/ibex/generated_trojans/
\\\

**Expected Output:**
- 6 Trojan variants per module (DoS, Leak, Privilege, Integrity, Availability, Covert)
- ~180 total Trojan files (30 modules × 6 patterns)

---

## 🧪 Validation

**Simulation Tool:** QuestaSim or Verilator  
**Testbench:** \	estbenches/generic_tb.sv\  
**Results Location:** \esults/\

**Run Validation:**
\\\ash
python scripts/validate_trojans.py examples/ibex/generated_trojans/
\\\

---

## 📈 Current Status

- ✅ 30 original RTL modules downloaded
- ✅ 6 Trojans generated for \ibex_cs_registers.sv\
- ⏸️ Remaining 29 modules pending generation
- ⏸️ Validation framework pending

---

## 📚 References

- Ibex User Manual: https://ibex-core.readthedocs.io
- lowRISC GitHub: https://github.com/lowRISC/ibex
- RISC-V Spec: https://riscv.org/specifications/
- Trust-Hub: https://trust-hub.org
