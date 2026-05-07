# Trojan Generation Summary

**Module:** ibex_controller
**File:** ibex_controller.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (20):**
- instr_valid_i
- instr_bp_taken_i
- instr_valid_clear_o
- id_in_ready_o
- instr_req_o
- ... and 15 more

**Payload Signals (18):**
- instr_valid_i
- instr_bp_taken_i
- instr_valid_clear_o
- id_in_ready_o
- instr_req_o
- ... and 13 more

**Generated File:** T1_ibex_controller_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (41):**
- csr_pipe_flush_i
- csr_mstatus_mie_i
- nmi_mode_o
- debug_req_i
- debug_cause_o
- ... and 36 more

**Payload Signals (22):**
- csr_pipe_flush_i
- lsu_addr_last_i
- csr_mstatus_mie_i
- debug_csr_save_o
- csr_save_if_o
- ... and 17 more

**Generated File:** T2_ibex_controller_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (33):**
- csr_pipe_flush_i
- lsu_addr_last_i
- csr_mstatus_mie_i
- nmi_mode_o
- debug_csr_save_o
- ... and 28 more

**Payload Signals (15):**
- csr_mstatus_mie_i
- nmi_mode_o
- debug_mode_o
- debug_mode_entering_o
- ibex_pkg::priv_lvl_e
- ... and 10 more

**Generated File:** T3_ibex_controller_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (6):**
- ibex_pkg::pc_sel_e
- ibex_pkg::exc_pc_sel_e
- lsu_addr_last_i
- ibex_pkg::pc_sel_e
- ibex_pkg::exc_pc_sel_e
- ... and 1 more

**Payload Signals (2):**
- store_err_i
- store_err_i

**Generated File:** T4_ibex_controller_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (20):**
- instr_valid_i
- instr_valid_clear_o
- instr_req_o
- lsu_addr_last_i
- load_err_i
- ... and 15 more

**Payload Signals (15):**
- ctrl_busy_o
- instr_valid_i
- instr_valid_clear_o
- id_in_ready_o
- stall_id_i
- ... and 10 more

**Generated File:** T5_ibex_controller_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (6):**
- instr_fetch_err_i
- instr_fetch_err_plus2_i
- load_err_i
- instr_fetch_err_i
- instr_fetch_err_plus2_i
- ... and 1 more

**Payload Signals (10):**
- ctrl_busy_o
- instr_valid_i
- instr_valid_clear_o
- id_in_ready_o
- ready_wb_i
- ... and 5 more

**Generated File:** T6_ibex_controller_Covert.sv

---

