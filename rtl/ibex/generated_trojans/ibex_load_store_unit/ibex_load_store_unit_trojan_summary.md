# Trojan Generation Summary

**Module:** ibex_load_store_unit
**File:** ibex_load_store_unit.sv
**Type:** Sequential
**Total Candidates:** 5

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (19):**
- data_req_o
- data_rvalid_i
- data_we_o
- lsu_we_i
- lsu_rdata_valid_o
- ... and 14 more

**Payload Signals (19):**
- data_req_o
- data_rvalid_i
- data_we_o
- lsu_we_i
- lsu_rdata_valid_o
- ... and 14 more

**Generated File:** T1_ibex_load_store_unit_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (5):**
- data_we_o
- lsu_we_i
- data_we_o
- lsu_we_i
- data_we_q

**Payload Signals (49):**
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_bus_err_i
- data_pmp_err_i
- ... and 44 more

**Generated File:** T2_ibex_load_store_unit_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (47):**
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_bus_err_i
- data_pmp_err_i
- ... and 42 more

**Payload Signals (50):**
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_bus_err_i
- data_pmp_err_i
- ... and 45 more

**Generated File:** T3_ibex_load_store_unit_Integrity.sv

---

### T4: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (36):**
- data_req_o
- data_rvalid_i
- lsu_we_i
- lsu_type_i
- lsu_wdata_i
- ... and 31 more

**Payload Signals (12):**
- data_gnt_i
- data_rvalid_i
- lsu_rdata_valid_o
- lsu_req_done_o
- lsu_resp_valid_o
- ... and 7 more

**Generated File:** T4_ibex_load_store_unit_Availability.sv

---

### T5: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (49):**
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_bus_err_i
- data_pmp_err_i
- ... and 44 more

**Payload Signals (48):**
- data_req_o
- data_gnt_i
- data_rvalid_i
- data_bus_err_i
- data_pmp_err_i
- ... and 43 more

**Generated File:** T5_ibex_load_store_unit_Covert.sv

---

