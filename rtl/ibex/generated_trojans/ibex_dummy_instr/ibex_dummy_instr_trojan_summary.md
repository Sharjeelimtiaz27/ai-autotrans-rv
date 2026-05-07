# Trojan Generation Summary

**Module:** ibex_dummy_instr
**File:** ibex_dummy_instr.sv
**Type:** Sequential
**Total Candidates:** 4

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (4):**
- dummy_instr_en_i
- dummy_instr_seed_en_i
- fetch_valid_i
- id_in_ready_i

**Payload Signals (4):**
- dummy_instr_en_i
- dummy_instr_seed_en_i
- fetch_valid_i
- id_in_ready_i

**Generated File:** T1_ibex_dummy_instr_DoS.sv

---

### T2: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (5):**
- dummy_instr_data_o
- dummy_instr_data_o
- op_b
- op_a
- dummy_opcode

**Payload Signals (2):**
- dummy_instr_data_o
- dummy_instr_data_o

**Generated File:** T2_ibex_dummy_instr_Integrity.sv

---

### T3: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (4):**
- fetch_valid_i
- op_b
- op_a
- dummy_opcode

**Payload Signals (2):**
- fetch_valid_i
- id_in_ready_i

**Generated File:** T3_ibex_dummy_instr_Availability.sv

---

### T4: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (3):**
- fetch_valid_i
- dummy_instr_data_o
- dummy_instr_data_o

**Payload Signals (4):**
- fetch_valid_i
- id_in_ready_i
- dummy_instr_data_o
- dummy_instr_data_o

**Generated File:** T4_ibex_dummy_instr_Covert.sv

---

