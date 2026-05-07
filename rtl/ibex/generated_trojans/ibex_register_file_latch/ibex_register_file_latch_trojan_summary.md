# Trojan Generation Summary

**Module:** ibex_register_file_latch
**File:** ibex_register_file_latch.sv
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
- test_en_i
- we_a_i
- we_a_i
- we_r0_dummy

**Payload Signals (4):**
- test_en_i
- we_a_i
- we_a_i
- we_r0_dummy

**Generated File:** T1_ibex_register_file_latch_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (4):**
- test_en_i
- we_a_i
- we_a_i
- we_r0_dummy

**Payload Signals (14):**
- raddr_a_i
- rdata_a_o
- raddr_b_i
- rdata_b_o
- waddr_a_i
- ... and 9 more

**Generated File:** T2_ibex_register_file_latch_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (14):**
- raddr_a_i
- rdata_a_o
- raddr_b_i
- rdata_b_o
- waddr_a_i
- ... and 9 more

**Payload Signals (7):**
- rdata_a_o
- rdata_b_o
- wdata_a_i
- rdata_a_o
- rdata_b_o
- ... and 2 more

**Generated File:** T3_ibex_register_file_latch_Integrity.sv

---

### T4: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (7):**
- rdata_a_o
- rdata_b_o
- wdata_a_i
- rdata_a_o
- rdata_b_o
- ... and 2 more

**Payload Signals (7):**
- rdata_a_o
- rdata_b_o
- wdata_a_i
- rdata_a_o
- rdata_b_o
- ... and 2 more

**Generated File:** T4_ibex_register_file_latch_Covert.sv

---

