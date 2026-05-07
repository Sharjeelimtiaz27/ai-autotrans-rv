# Trojan Generation Summary

**Module:** ibex_multdiv_fast
**File:** ibex_multdiv_fast.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (12):**
- mult_en_i
- div_en_i
- imd_val_we_o
- multdiv_ready_id_i
- valid_o
- ... and 7 more

**Payload Signals (12):**
- mult_en_i
- div_en_i
- imd_val_we_o
- multdiv_ready_id_i
- valid_o
- ... and 7 more

**Generated File:** T1_ibex_multdiv_fast_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (3):**
- signed_mode_i
- imd_val_we_o
- imd_val_we_o

**Payload Signals (7):**
- data_ind_timing_i
- alu_operand_a_o
- alu_operand_b_o
- multdiv_result_o
- alu_operand_a_o
- ... and 2 more

**Generated File:** T2_ibex_multdiv_fast_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (3):**
- signed_mode_i
- imd_val_we_o
- imd_val_we_o

**Payload Signals (1):**
- signed_mode_i

**Generated File:** T3_ibex_multdiv_fast_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (20):**
- mult_sel_i
- div_sel_i
- ibex_pkg::md_op_e
- operator_i
- op_a_i
- ... and 15 more

**Payload Signals (3):**
- data_ind_timing_i
- multdiv_result_o
- multdiv_result_o

**Generated File:** T4_ibex_multdiv_fast_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (20):**
- ibex_pkg::md_op_e
- operator_i
- op_a_i
- op_b_i
- alu_operand_a_o
- ... and 15 more

**Payload Signals (6):**
- multdiv_ready_id_i
- valid_o
- multdiv_ready_id_i
- valid_o
- mult_valid
- ... and 1 more

**Generated File:** T5_ibex_multdiv_fast_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (5):**
- data_ind_timing_i
- alu_operand_a_o
- alu_operand_b_o
- alu_operand_a_o
- alu_operand_b_o

**Payload Signals (9):**
- data_ind_timing_i
- multdiv_ready_id_i
- multdiv_result_o
- valid_o
- multdiv_ready_id_i
- ... and 4 more

**Generated File:** T6_ibex_multdiv_fast_Covert.sv

---

