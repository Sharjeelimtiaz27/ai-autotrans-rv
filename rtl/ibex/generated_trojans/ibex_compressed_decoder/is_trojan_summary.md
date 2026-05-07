# Trojan Generation Summary

**Module:** is
**File:** ibex_compressed_decoder.sv
**Type:** Sequential
**Total Candidates:** 2

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (3):**
- valid_i
- id_in_ready_i
- unused_valid

**Payload Signals (3):**
- valid_i
- id_in_ready_i
- unused_valid

**Generated File:** T1_is_DoS.sv

---

### T2: Availability - Performance Degradation

**Trust-Hub Status:** Category exists (gate-level only)
**Severity:** Medium
**Confidence:** 1.00
**Description:** Degrades performance through artificial delays

**Trigger Signals (2):**
- valid_i
- unused_valid

**Payload Signals (3):**
- valid_i
- id_in_ready_i
- unused_valid

**Generated File:** T2_is_Availability.sv

---

