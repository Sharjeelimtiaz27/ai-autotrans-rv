# Trojan Generation Summary

**Module:** ibex_id_stage
**File:** ibex_id_stage.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (45):**
- instr_valid_i
- instr_bp_taken_i
- instr_req_o
- instr_valid_clear_o
- id_in_ready_o
- ... and 40 more

**Payload Signals (47):**
- instr_valid_i
- instr_bp_taken_i
- instr_req_o
- instr_valid_clear_o
- id_in_ready_o
- ... and 42 more

**Generated File:** T1_ibex_id_stage_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (65):**
- imd_val_we_ex_i
- multdiv_signed_mode_ex_o
- csr_access_o
- csr_op_o
- csr_addr_o
- ... and 60 more

**Payload Signals (92):**
- instr_rdata_i
- instr_rdata_alu_i
- instr_rdata_c_i
- nt_branch_addr_o
- alu_operand_a_ex_o
- ... and 87 more

**Generated File:** T2_ibex_id_stage_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (71):**
- nt_branch_addr_o
- imd_val_we_ex_i
- multdiv_signed_mode_ex_o
- csr_access_o
- csr_op_o
- ... and 66 more

**Payload Signals (18):**
- multdiv_signed_mode_ex_o
- ibex_pkg::priv_lvl_e
- priv_mode_i
- csr_mstatus_tw_i
- csr_mstatus_mie_i
- ... and 13 more

**Generated File:** T3_ibex_id_stage_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (79):**
- instr_rdata_i
- instr_rdata_alu_i
- instr_rdata_c_i
- ibex_pkg::pc_sel_e
- nt_branch_addr_o
- ... and 74 more

**Payload Signals (43):**
- instr_rdata_i
- instr_rdata_alu_i
- instr_rdata_c_i
- data_ind_timing_i
- lsu_wdata_o
- ... and 38 more

**Generated File:** T4_ibex_id_stage_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (76):**
- instr_valid_i
- instr_req_o
- instr_valid_clear_o
- ex_valid_i
- lsu_resp_valid_i
- ... and 71 more

**Payload Signals (37):**
- ctrl_busy_o
- instr_valid_i
- instr_valid_clear_o
- id_in_ready_o
- ex_valid_i
- ... and 32 more

**Generated File:** T5_ibex_id_stage_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (52):**
- instr_rdata_i
- instr_rdata_alu_i
- instr_rdata_c_i
- instr_fetch_err_i
- instr_fetch_err_plus2_i
- ... and 47 more

**Payload Signals (56):**
- ctrl_busy_o
- instr_valid_i
- instr_rdata_i
- instr_rdata_alu_i
- instr_rdata_c_i
- ... and 51 more

**Generated File:** T6_ibex_id_stage_Covert.sv

---

