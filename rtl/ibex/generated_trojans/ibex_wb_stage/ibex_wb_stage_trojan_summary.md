# Trojan Generation Summary

**Module:** ibex_wb_stage
**File:** ibex_wb_stage.sv
**Type:** Sequential
**Total Candidates:** 5

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (15):**
- en_wb_i
- ready_wb_o
- rf_we_id_i
- rf_we_lsu_i
- rf_we_wb_o
- ... and 10 more

**Payload Signals (18):**
- en_wb_i
- ready_wb_o
- rf_we_id_i
- rf_we_lsu_i
- rf_we_wb_o
- ... and 13 more

**Generated File:** T1_ibex_wb_stage_DoS.sv

---

### T2: Leak - Information Leakage

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** Critical
**Confidence:** 1.00
**Description:** Leaks sensitive data to attacker-accessible location

**Trigger Signals (10):**
- rf_write_wb_o
- rf_we_id_i
- rf_we_lsu_i
- rf_we_wb_o
- rf_write_wb_o
- ... and 5 more

**Payload Signals (20):**
- outstanding_load_wb_o
- outstanding_store_wb_o
- rf_waddr_id_i
- rf_wdata_id_i
- rf_wdata_lsu_i
- ... and 15 more

**Generated File:** T2_ibex_wb_stage_Leak.sv

---

### T3: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (16):**
- rf_waddr_id_i
- rf_wdata_id_i
- rf_wdata_lsu_i
- rf_wdata_fwd_wb_o
- rf_waddr_wb_o
- ... and 11 more

**Payload Signals (17):**
- rf_write_wb_o
- outstanding_load_wb_o
- outstanding_store_wb_o
- rf_wdata_id_i
- rf_wdata_lsu_i
- ... and 12 more

**Generated File:** T3_ibex_wb_stage_Integrity.sv

---

### T4: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (14):**
- outstanding_load_wb_o
- outstanding_store_wb_o
- rf_wdata_lsu_i
- rf_we_lsu_i
- lsu_resp_valid_i
- ... and 9 more

**Payload Signals (9):**
- ready_wb_o
- lsu_resp_valid_i
- instr_done_wb_o
- ready_wb_o
- lsu_resp_valid_i
- ... and 4 more

**Generated File:** T4_ibex_wb_stage_Availability.sv

---

### T5: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (13):**
- outstanding_load_wb_o
- rf_wdata_id_i
- rf_wdata_lsu_i
- rf_wdata_fwd_wb_o
- rf_wdata_wb_o
- ... and 8 more

**Payload Signals (21):**
- ready_wb_o
- outstanding_load_wb_o
- outstanding_store_wb_o
- rf_wdata_id_i
- rf_wdata_lsu_i
- ... and 16 more

**Generated File:** T5_ibex_wb_stage_Covert.sv

---

