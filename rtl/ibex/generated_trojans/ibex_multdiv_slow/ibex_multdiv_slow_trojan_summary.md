# Trojan Generation Summary

**Module:** ibex_multdiv_slow
**File:** ibex_multdiv_slow.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (8):**
- mult_en_i
- div_en_i
- imd_val_we_o
- multdiv_ready_id_i
- valid_o
- ... and 3 more

**Payload Signals (8):**
- mult_en_i
- div_en_i
- imd_val_we_o
- multdiv_ready_id_i
- valid_o
- ... and 3 more

**Generated File:** T1_ibex_multdiv_slow_DoS.sv

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

**Generated File:** T2_ibex_multdiv_slow_Leak.sv

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

**Generated File:** T3_ibex_multdiv_slow_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (11):**
- mult_sel_i
- div_sel_i
- ibex_pkg::md_op_e
- operator_i
- op_a_i
- ... and 6 more

**Payload Signals (3):**
- data_ind_timing_i
- multdiv_result_o
- multdiv_result_o

**Generated File:** T4_ibex_multdiv_slow_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (10):**
- ibex_pkg::md_op_e
- operator_i
- op_a_i
- op_b_i
- alu_operand_a_o
- ... and 5 more

**Payload Signals (4):**
- multdiv_ready_id_i
- valid_o
- multdiv_ready_id_i
- valid_o

**Generated File:** T5_ibex_multdiv_slow_Availability.sv

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

**Payload Signals (7):**
- data_ind_timing_i
- multdiv_ready_id_i
- multdiv_result_o
- valid_o
- multdiv_ready_id_i
- ... and 2 more

**Generated File:** T6_ibex_multdiv_slow_Covert.sv

---

