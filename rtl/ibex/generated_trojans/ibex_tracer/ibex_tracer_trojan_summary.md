# Trojan Generation Summary

**Module:** ibex_tracer
**File:** ibex_tracer.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (2):**
- rvfi_valid
- rvfi_ext_expanded_insn_valid

**Payload Signals (2):**
- rvfi_valid
- rvfi_ext_expanded_insn_valid

**Generated File:** T1_ibex_tracer_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (3):**
- rvfi_mode
- csr_addr)
- unused_rvfi_mode

**Payload Signals (18):**
- rvfi_rs1_addr
- rvfi_rs2_addr
- rvfi_rs3_addr
- rvfi_rs1_rdata
- rvfi_rs2_rdata
- ... and 13 more

**Generated File:** T2_ibex_tracer_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (11):**
- rvfi_mode
- rvfi_rs1_addr
- rvfi_rs2_addr
- rvfi_rs3_addr
- rvfi_rd_addr
- ... and 6 more

**Payload Signals (2):**
- rvfi_mode
- unused_rvfi_mode

**Generated File:** T3_ibex_tracer_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (18):**
- rvfi_rs1_addr
- rvfi_rs2_addr
- rvfi_rs3_addr
- rvfi_rs1_rdata
- rvfi_rs2_rdata
- ... and 13 more

**Payload Signals (9):**
- rvfi_rs1_rdata
- rvfi_rs2_rdata
- rvfi_rs3_rdata
- rvfi_rd_wdata
- rvfi_pc_rdata
- ... and 4 more

**Generated File:** T4_ibex_tracer_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (2):**
- rvfi_valid
- rvfi_ext_expanded_insn_valid

**Payload Signals (2):**
- rvfi_valid
- rvfi_ext_expanded_insn_valid

**Generated File:** T5_ibex_tracer_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (9):**
- rvfi_rs1_rdata
- rvfi_rs2_rdata
- rvfi_rs3_rdata
- rvfi_rd_wdata
- rvfi_pc_rdata
- ... and 4 more

**Payload Signals (11):**
- rvfi_valid
- rvfi_rs1_rdata
- rvfi_rs2_rdata
- rvfi_rs3_rdata
- rvfi_rd_wdata
- ... and 6 more

**Generated File:** T6_ibex_tracer_Covert.sv

---

