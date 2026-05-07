# Trojan Generation Summary

**Module:** ibex_counter
**File:** ibex_counter.sv
**Type:** Sequential
**Total Candidates:** 1

---

## Generated Trojans

### T1: DoS - Denial of Service

**Trust-Hub Status:** Verified RTL Benchmarks
**Severity:** High
**Confidence:** 1.00
**Description:** Disables functionality by forcing control signals to 0

**Trigger Signals (3):**
- counterh_we_i
- counter_we_i
- we

**Payload Signals (3):**
- counterh_we_i
- counter_we_i
- we

**Generated File:** T1_ibex_counter_DoS.sv

---

