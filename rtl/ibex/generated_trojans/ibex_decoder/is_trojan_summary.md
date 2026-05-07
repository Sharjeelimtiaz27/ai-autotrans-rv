# Trojan Generation Summary

**Module:** is
**File:** ibex_decoder.sv
**Type:** Sequential
**Total Candidates:** 5

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (13):**
- branch_taken_i
- rf_we_o
- mult_en_o
- div_en_o
- data_req_o
- ... and 8 more

**Payload Signals (13):**
- branch_taken_i
- rf_we_o
- mult_en_o
- div_en_o
- data_req_o
- ... and 8 more

**Generated File:** T1_is_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (14):**
- rf_we_o
- multdiv_signed_mode_o
- csr_access_o
- csr_op_o
- csr_addr_o
- ... and 9 more

**Payload Signals (27):**
- instr_rdata_i
- instr_rdata_alu_i
- rf_wdata_sel_o
- rf_raddr_a_o
- rf_raddr_b_o
- ... and 22 more

**Generated File:** T2_is_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (20):**
- rf_we_o
- rf_raddr_a_o
- rf_raddr_b_o
- rf_waddr_o
- multdiv_signed_mode_o
- ... and 15 more

**Payload Signals (2):**
- multdiv_signed_mode_o
- multdiv_signed_mode_o

**Generated File:** T3_is_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (64):**
- instr_rdata_i
- instr_rdata_alu_i
- ibex_pkg::imm_a_sel_e
- imm_a_mux_sel_o
- ibex_pkg::imm_b_sel_e
- ... and 59 more

**Payload Signals (14):**
- instr_rdata_i
- instr_rdata_alu_i
- rf_wdata_sel_o
- data_req_o
- data_we_o
- ... and 9 more

**Generated File:** T4_is_Integrity.sv

---

### T5: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (16):**
- instr_rdata_i
- instr_rdata_alu_i
- rf_wdata_sel_o
- csr_access_o
- data_req_o
- ... and 11 more

**Payload Signals (14):**
- instr_rdata_i
- instr_rdata_alu_i
- rf_wdata_sel_o
- data_req_o
- data_we_o
- ... and 9 more

**Generated File:** T5_is_Covert.sv

---

