#!/usr/bin/env python3
# Author: Sharjeel Imtiaz
"""
Step 1C: QuestaSim Compile Loop (max 3 retries)
=======================================================
Input:  assertions/<MODULE>_bind.sv
Output: compiled bind file  OR  errors/archive/<MODULE>_compile_<N>.log

On FAIL: log error, build retry prompt (original + error), resend to Claude.
After 3 failures: set locked=true, print ESCALATE, stop.
"""
