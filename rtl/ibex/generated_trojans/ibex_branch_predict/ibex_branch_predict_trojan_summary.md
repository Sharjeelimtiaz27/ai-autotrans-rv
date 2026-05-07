# Trojan Generation Summary

**Module:** ibex_branch_predict
**File:** ibex_branch_predict.sv
**Type:** Sequential
**Total Candidates:** 4

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (1):**
- fetch_valid_i

**Payload Signals (1):**
- fetch_valid_i

**Generated File:** T1_ibex_branch_predict_DoS.sv

---

### T2: Integrity - Integrity Violation

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Corrupts computation results or data

**Trigger Signals (1):**
- fetch_rdata_i

**Payload Signals (1):**
- fetch_rdata_i

**Generated File:** T2_ibex_branch_predict_Integrity.sv

---

### T3: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (1):**
- fetch_valid_i

**Payload Signals (1):**
- fetch_valid_i

**Generated File:** T3_ibex_branch_predict_Availability.sv

---

### T4: Covert - Covert Channel

**Trust-Hub Status:** Related to Leak Information (power only, not timing)
**Severity:** High
**Confidence:** 1.00
**Description:** Creates hidden communication channel through timing

**Trigger Signals (3):**
- fetch_rdata_i
- fetch_pc_i
- fetch_valid_i

**Payload Signals (2):**
- fetch_rdata_i
- fetch_valid_i

**Generated File:** T4_ibex_branch_predict_Covert.sv

---

