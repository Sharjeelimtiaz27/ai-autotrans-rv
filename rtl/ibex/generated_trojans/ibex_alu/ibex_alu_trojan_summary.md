# Trojan Generation Summary

**Module:** ibex_alu
**File:** ibex_alu.sv
**Type:** Combinational
**Total Candidates:** 5

---

## Generated Trojans

### T1: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (8):**
- imd_val_we_o
- imd_val_we_o
- shift_sbmode
- crc_hmode
- crc_bmode
- ... and 3 more

**Payload Signals (42):**
- operand_a_i
- operand_b_i
- multdiv_operand_a_i
- multdiv_operand_b_i
- adder_result_o
- ... and 37 more

**Generated File:** T1_ibex_alu_Leak.sv

---

### T2: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (29):**
- ibex_pkg::alu_op_e
- operator_i
- operand_a_i
- operand_b_i
- multdiv_operand_a_i
- ... and 24 more

**Payload Signals (38):**
- adder_result_o
- adder_result_ext_o
- result_o
- comparison_result_o
- is_equal_result_o
- ... and 33 more

**Generated File:** T2_ibex_alu_Integrity.sv

---

### T3: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (4):**
- operand_a_i
- operand_b_i
- multdiv_operand_a_i
- multdiv_operand_b_i

**Payload Signals (38):**
- adder_result_o
- adder_result_ext_o
- result_o
- comparison_result_o
- is_equal_result_o
- ... and 33 more

**Generated File:** T3_ibex_alu_Covert.sv

---

### T4: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 0.80
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (2):**
- imd_val_we_o
- imd_val_we_o

**Payload Signals (2):**
- imd_val_we_o
- imd_val_we_o

**Generated File:** T4_ibex_alu_DoS.sv

---

### T5: Privilege - Privilege Escalation

**Trust-Hub Status:** Not applicable (processor-specific)
**Severity:** Critical
**Confidence:** 0.80
**Description:** Escalates privilege level to machine mode

**Trigger Signals (8):**
- imd_val_we_o
- imd_val_we_o
- shift_sbmode
- crc_hmode
- crc_bmode
- ... and 3 more

**Payload Signals (6):**
- shift_sbmode
- crc_hmode
- crc_bmode
- shuffle_mode
- clmul_rmode
- ... and 1 more

**Generated File:** T5_ibex_alu_Privilege.sv

---

