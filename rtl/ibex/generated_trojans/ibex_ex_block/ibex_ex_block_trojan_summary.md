# Trojan Generation Summary

**Module:** ibex_ex_block
**File:** ibex_ex_block.sv
**Type:** Sequential
**Total Candidates:** 6

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (10):**
- mult_en_i
- div_en_i
- multdiv_ready_id_i
- imd_val_we_o
- ex_valid_o
- ... and 5 more

**Payload Signals (10):**
- mult_en_i
- div_en_i
- multdiv_ready_id_i
- imd_val_we_o
- ex_valid_o
- ... and 5 more

**Generated File:** T1_ibex_ex_block_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (5):**
- multdiv_signed_mode_i
- imd_val_we_o
- imd_val_we_o
- alu_imd_val_we
- multdiv_imd_val_we

**Payload Signals (13):**
- alu_operand_a_i
- alu_operand_b_i
- bt_a_operand_i
- bt_b_operand_i
- multdiv_operand_a_i
- ... and 8 more

**Generated File:** T2_ibex_ex_block_Leak.sv

---

### T3: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 1.00
**Description:** Escalates privilege level to machine mode

**Trigger Signals (5):**
- multdiv_signed_mode_i
- imd_val_we_o
- imd_val_we_o
- alu_imd_val_we
- multdiv_imd_val_we

**Payload Signals (1):**
- multdiv_signed_mode_i

**Generated File:** T3_ibex_ex_block_Privilege.sv

---

### T4: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (14):**
- ibex_pkg::alu_op_e
- alu_operator_i
- alu_operand_a_i
- alu_operand_b_i
- bt_a_operand_i
- ... and 9 more

**Payload Signals (7):**
- data_ind_timing_i
- alu_adder_result_ex_o
- result_ex_o
- alu_adder_result_ex_o
- result_ex_o
- ... and 2 more

**Generated File:** T4_ibex_ex_block_Integrity.sv

---

### T5: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (13):**
- ibex_pkg::alu_op_e
- alu_operator_i
- alu_operand_a_i
- alu_operand_b_i
- bt_a_operand_i
- ... and 8 more

**Payload Signals (4):**
- multdiv_ready_id_i
- ex_valid_o
- ex_valid_o
- multdiv_valid

**Generated File:** T5_ibex_ex_block_Availability.sv

---

### T6: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (7):**
- alu_operand_a_i
- alu_operand_b_i
- bt_a_operand_i
- bt_b_operand_i
- multdiv_operand_a_i
- ... and 2 more

**Payload Signals (11):**
- multdiv_ready_id_i
- data_ind_timing_i
- alu_adder_result_ex_o
- result_ex_o
- ex_valid_o
- ... and 6 more

**Generated File:** T6_ibex_ex_block_Covert.sv

---

