# Trojan Generation Summary

**Module:** ibex_fetch_fifo
**File:** ibex_fetch_fifo.sv
**Type:** Sequential
**Total Candidates:** 5

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (7):**
- in_valid_i
- out_valid_o
- out_ready_i
- in_valid_i
- out_valid_o
- ... and 2 more

**Payload Signals (7):**
- in_valid_i
- out_valid_o
- out_ready_i
- in_valid_i
- out_valid_o
- ... and 2 more

**Generated File:** T1_ibex_fetch_fifo_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (1):**
- lowest_free_entry

**Payload Signals (20):**
- in_addr_i
- in_rdata_i
- out_valid_o
- out_ready_i
- out_addr_o
- ... and 15 more

**Generated File:** T2_ibex_fetch_fifo_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (13):**
- in_addr_i
- in_rdata_i
- out_addr_o
- out_rdata_o
- in_addr_i
- ... and 8 more

**Payload Signals (14):**
- in_rdata_i
- out_valid_o
- out_ready_i
- out_addr_o
- out_rdata_o
- ... and 9 more

**Generated File:** T3_ibex_fetch_fifo_Integrity.sv

---

### T4: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (5):**
- in_valid_i
- out_valid_o
- in_valid_i
- out_valid_o
- pop_fifo

**Payload Signals (8):**
- busy_o
- in_valid_i
- out_valid_o
- out_ready_i
- busy_o
- ... and 3 more

**Generated File:** T4_ibex_fetch_fifo_Availability.sv

---

### T5: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (4):**
- in_rdata_i
- out_rdata_o
- in_rdata_i
- out_rdata_o

**Payload Signals (18):**
- busy_o
- in_valid_i
- in_rdata_i
- out_valid_o
- out_ready_i
- ... and 13 more

**Generated File:** T5_ibex_fetch_fifo_Covert.sv

---

