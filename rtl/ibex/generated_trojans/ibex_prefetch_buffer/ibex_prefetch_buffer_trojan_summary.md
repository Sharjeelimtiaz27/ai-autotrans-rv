# Trojan Generation Summary

**Module:** ibex_prefetch_buffer
**File:** ibex_prefetch_buffer.sv
**Type:** Sequential
**Total Candidates:** 4

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (9):**
- req_i
- ready_i
- valid_o
- instr_req_o
- instr_rvalid_i
- ... and 4 more

**Payload Signals (9):**
- req_i
- ready_i
- valid_o
- instr_req_o
- instr_rvalid_i
- ... and 4 more

**Generated File:** T1_ibex_prefetch_buffer_DoS.sv

---

### T2: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (13):**
- addr_i
- rdata_o
- addr_o
- instr_addr_o
- instr_rdata_i
- ... and 8 more

**Payload Signals (5):**
- rdata_o
- instr_rdata_i
- rdata_o
- instr_rdata_i
- rdata_outstanding_rev

**Generated File:** T2_ibex_prefetch_buffer_Integrity.sv

---

### T3: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (8):**
- req_i
- valid_o
- instr_req_o
- instr_rvalid_i
- valid_o
- ... and 3 more

**Payload Signals (10):**
- ready_i
- valid_o
- instr_gnt_i
- instr_rvalid_i
- busy_o
- ... and 5 more

**Generated File:** T3_ibex_prefetch_buffer_Availability.sv

---

### T4: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (5):**
- rdata_o
- instr_rdata_i
- rdata_o
- instr_rdata_i
- rdata_outstanding_rev

**Payload Signals (13):**
- ready_i
- valid_o
- rdata_o
- instr_rdata_i
- instr_rvalid_i
- ... and 8 more

**Generated File:** T4_ibex_prefetch_buffer_Covert.sv

---

