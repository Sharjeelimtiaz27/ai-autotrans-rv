# Trojan Generation Summary

**Module:** ibex_register_file_ff
**File:** ibex_register_file_ff.sv
**Type:** Sequential
**Total Candidates:** 4

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (6):**
- test_en_i
- we_a_i
- we_a_i
- we_a_dec
- we_a_dec_buf
- ... and 1 more

**Payload Signals (6):**
- test_en_i
- we_a_i
- we_a_i
- we_a_dec
- we_a_dec_buf
- ... and 1 more

**Generated File:** T1_ibex_register_file_ff_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (6):**
- test_en_i
- we_a_i
- we_a_i
- we_a_dec
- we_a_dec_buf
- ... and 1 more

**Payload Signals (11):**
- raddr_a_i
- rdata_a_o
- raddr_b_i
- rdata_b_o
- waddr_a_i
- ... and 6 more

**Generated File:** T2_ibex_register_file_ff_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (11):**
- raddr_a_i
- rdata_a_o
- raddr_b_i
- rdata_b_o
- waddr_a_i
- ... and 6 more

**Payload Signals (6):**
- rdata_a_o
- rdata_b_o
- wdata_a_i
- rdata_a_o
- rdata_b_o
- ... and 1 more

**Generated File:** T3_ibex_register_file_ff_Integrity.sv

---

### T4: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (6):**
- rdata_a_o
- rdata_b_o
- wdata_a_i
- rdata_a_o
- rdata_b_o
- ... and 1 more

**Payload Signals (6):**
- rdata_a_o
- rdata_b_o
- wdata_a_i
- rdata_a_o
- rdata_b_o
- ... and 1 more

**Generated File:** T4_ibex_register_file_ff_Covert.sv

---

