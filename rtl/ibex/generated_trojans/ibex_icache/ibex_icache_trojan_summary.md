# Trojan Generation Summary

**Module:** ibex_icache
**File:** ibex_icache.sv
**Type:** Sequential
**Total Candidates:** 5

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (33):**
- req_i
- ready_i
- valid_o
- instr_req_o
- instr_rvalid_i
- ... and 28 more

**Payload Signals (36):**
- req_i
- ready_i
- valid_o
- instr_req_o
- instr_rvalid_i
- ... and 31 more

**Generated File:** T1_ibex_icache_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (11):**
- ic_tag_write_o
- ic_data_write_o
- ic_tag_write_o
- ic_data_write_o
- tag_write_ic0
- ... and 6 more

**Payload Signals (67):**
- addr_i
- rdata_o
- addr_o
- instr_addr_o
- instr_rdata_i
- ... and 62 more

**Generated File:** T2_ibex_icache_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (60):**
- addr_i
- rdata_o
- addr_o
- instr_addr_o
- instr_rdata_i
- ... and 55 more

**Payload Signals (56):**
- rdata_o
- instr_rdata_i
- ic_tag_write_o
- ic_tag_wdata_o
- ic_tag_rdata_i
- ... and 51 more

**Generated File:** T3_ibex_icache_Integrity.sv

---

### T4: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (30):**
- req_i
- valid_o
- instr_req_o
- instr_rvalid_i
- ic_tag_req_o
- ... and 25 more

**Payload Signals (21):**
- ready_i
- valid_o
- instr_gnt_i
- instr_rvalid_i
- ic_scr_key_valid_i
- ... and 16 more

**Generated File:** T4_ibex_icache_Availability.sv

---

### T5: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (43):**
- rdata_o
- instr_rdata_i
- ic_tag_wdata_o
- ic_tag_rdata_i
- ic_data_req_o
- ... and 38 more

**Payload Signals (61):**
- ready_i
- valid_o
- rdata_o
- instr_rdata_i
- instr_rvalid_i
- ... and 56 more

**Generated File:** T5_ibex_icache_Covert.sv

---

