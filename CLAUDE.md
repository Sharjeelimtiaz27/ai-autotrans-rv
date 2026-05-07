# ai-autotrans-rv — CLAUDE.md
# Claude Code reads this automatically every session.
# Read this COMPLETELY before doing anything.
# Last updated: 7 May 2026

---

## PROJECT IDENTITY

**Working title:** "Automated LLM-Assisted Translation of Security Assertions
for RISC-V Processors"

**Venue:** Baltic Electronic Conference (BEC) 2026
**Length:** 6 pages
**Submission target:** 27 May 2026 (advisor review buffer 24-26 May)
**Days from today (7 May): 20**

**Authors:** Sharjeel Imtiaz, Uljana Reinsalu, Tara Ghasempouri
**Institution:** Tallinn University of Technology (TalTech)
**Grant:** Estonian Research Council PSG837
**GitHub:** https://github.com/Sharjeelimtiaz27/ai-autotrans-rv

**Relationship to other papers:**
- ISCAS paper — upstream context (cited, our prior work)
- MEMOCODE 2023 (Chuah et al.) — assertion source (cited, our input data)
- SecMetric journal paper — downstream companion paper (Stages 2-5 of the
  larger flow). The BEC paper is Stage 1 split out as a standalone
  contribution. The journal paper picks up where this one ends.

---

## SCOPE — STAGE 1 ONLY

**This paper does ONLY the translation stage.** Everything else from the
larger flow belongs to the journal paper. Do not scope-creep.

### IN SCOPE

- PyVerilog parses target RTL → signals.json
- Fixed template + signals.json + NS31A assertions → prompt
- Claude Code CLI translates → SVA bind file
- QuestaSim compile loop (max 3 retries)
- JasperGold FPV on clean RTL (Proven + non-vacuous)
- TAR (Translation Acceptance Rate) metric
- Reproducibility claim: same input → same output, every run
- Targets: Ibex (primary), CVA6 (if time allows)

### OUT OF SCOPE — belongs to journal paper

- AQS quality ranking (SRTLC, AER, SAPC, TCFC, AQS)
- Trojan evaluation as a contribution
- ARS refinement stage
- RAVS validation stage

### STRETCH GOALS (only if Phase 1 finishes early)

1. CVA6 as a second target (demonstrates portability)
2. Generate SVA for NS31A properties that had only English description
   (paper gives 1146 properties but only ~600 have SVA code in the paper)
3. Run Stage 1 outputs against RV-TroGen trojans for a quick detection table
   (just a sanity-check appendix, not a contribution)

If a stretch goal would push past 24 May, drop it.

---

## THREE CONTRIBUTIONS (exactly three — do not add more)

1. **LLM-assisted assertion translation pipeline (PyVerilog-grounded,
   fixed-template, reproducible).** The fixed prompt template plus
   PyVerilog parser output makes the LLM deterministic in practice:
   same RTL + same source assertion = same translated SVA, every run.

2. **TAR (Translation Acceptance Rate) metric.** Per-module measure of
   what fraction of source assertions were auto-translated, validated by
   QuestaSim compile + JasperGold FPV (Proven + non-vacuous), without
   manual fixing.

3. **Cross-architecture translation case study: NS31A → Ibex.**
   1146 NS31A security assertions from MEMOCODE 2023 translated to Ibex
   RTL across 9 security modules. (CVA6 added if time.)

---

## NOVELTY STORY (what we tell reviewers)

The pitch in one sentence: **manual assertion translation is slow and
expensive; raw-LLM translation is stochastic and unverifiable; we use a
fixed PyVerilog-grounded prompt template plus JasperGold validation to
get reproducible, mechanically verified translations at near-zero cost.**

Three legs of the argument:

1. **Speed and cost.** Manual translation takes hours per assertion.
   Our pipeline runs in minutes per module on a laptop using only a
   Claude Code subscription (no GPU, no fine-tuning).
2. **Reproducibility.** A naked LLM gives different output each call.
   The PyVerilog parser fixes the input the LLM sees, the template fixes
   the prompt structure, and JasperGold filters output that does not
   formally validate. The only stochastic element is filtered away.
3. **Mechanical verification.** Every output assertion is QuestaSim-
   compiled and JasperGold-FPV-proven before it counts toward TAR. No
   "syntactically valid but semantically wrong" outputs slip through.

Position vs related work:

- **AutoAssert/TrustAssert (DATE 2026, Zhai et al.)** — generates
  assertions from RTL with fine-tuned LLMs, BLEU/ROUGE metrics, 8xA100
  GPU cluster. We translate (not generate), formally verify (not BLEU),
  use Claude Code subscription (no GPU). Different problem, different
  cost profile.
- **AssertLLM (ASPDAC 2025)** — LLM-based generation, not translation.
- **Chuah MEMOCODE 2023** — manual assertion authoring. We are the
  automation layer on top of their manually-written corpus.
- **Translating Common Security Assertions (arXiv 2502.10194)** — the
  closest competitor; they translate too, but without a parser-grounded
  template and without JasperGold-in-the-loop validation as the gate.

---

## RTL SCOPE — IBEX 9 SECURITY MODULES

| Module | RTL File | Type |
|--------|----------|------|
| PMP | ibex_pmp.sv | COMBINATIONAL |
| CSR | ibex_cs_registers.sv | sequential |
| DO | ibex_controller.sv | sequential (shared file) |
| ETI | ibex_controller.sv | sequential (shared file) |
| CF | ibex_controller.sv | sequential (shared file) |
| MT | ibex_controller.sv | sequential (shared file) |
| MA | ibex_load_store_unit.sv | sequential |
| IE | ibex_id_stage.sv + ibex_ex_block.sv | sequential |
| RU | ibex_wb_stage.sv | sequential |

**Critical facts (carried over from old CLAUDE.md):**
- ibex_controller.sv serves 4 logical modules (DO, ETI, CF, MT)
- ibex_csr.sv is a sub-module of ibex_cs_registers.sv — IGNORE IT
- PMP is COMBINATIONAL — no posedge, no ##N, no $past()
- Clock: clk_i (hardcoded all sequential modules)
- Reset: rst_ni active-low (hardcoded all sequential modules)
- Assertions go in BIND FILES ONLY — never modify RTL directly

---

## ASSERTION SOURCE

**Single source for the BEC paper:** the MEMOCODE 2023 (Chuah et al.)
NS31A assertion set, already extracted into CSV files at:

```
assertion_dataset/
  ns31a_pmp.csv
  ns31a_csr.csv
  ns31a_do.csv
  ns31a_eti.csv
  ns31a_cf.csv
  ns31a_mt.csv
  ns31a_ma.csv
  ns31a_ie.csv
  ns31a_ru.csv
```

CSV schema (already produced):
`category, property_id, count, description, sva, example_target, notes`

The `sva` column is the source SVA when the paper provided it. Rows
where `sva` is empty are NS31A properties with English-only descriptions
(stretch goal: generate SVA for those too).

Paper Table 4 totals (must match — already verified during extraction):
1146 properties across 9 categories.

---

## PIPELINE — STAGE 1 ONLY (carried over from old CLAUDE.md, trimmed)

### Sub-step 1A: RTL Parser (parse_rtl.py)

```
python pipeline/parse_rtl.py --module csr
```
Input: `rtl/ibex/original/ibex_<MODULE>.sv`
Output: `pipeline/signals/<MODULE>_signals.json`

JSON schema (extract ALL signals — no security classification at parse time):

```json
{
  "module": "ibex_cs_registers",
  "type": "sequential",
  "clock": "clk_i",
  "reset": "rst_ni",
  "reset_polarity": "active_low",
  "ports": {
    "inputs":  [{"name": "clk_i", "width": 1}, ...],
    "outputs": [{"name": "csr_rdata_o", "width": 32}, ...]
  },
  "internals": [
    {"name": "csr_we_int", "width": 1, "class": "sequential"},
    {"name": "mstatus_en", "width": 1, "class": "sequential"}
  ],
  "parameters": ["RV32E", "DbgTriggerEn"]
}
```

PMP special case: no always_ff means `type = "combinational"` automatically.

### Sub-step 1B: Prompt Builder (build_prompt.py)

```
python pipeline/build_prompt.py --module csr
```
Inputs:
- `pipeline/templates/sequential_prompt.txt` OR `combinational_prompt.txt`
  (FIXED, human-crafted, selected by signals.json `type`)
- `pipeline/signals/<MODULE>_signals.json`
- `assertion_dataset/ns31a_<MODULE>.csv`

Output: `pipeline/prompts/final_prompt_<MODULE>.txt`

**Template design principle.** Templates are FIXED. `build_prompt.py`
substitutes `{{PLACEHOLDERS}}` only:
`{{MODULE_NAME}}, {{CLOCK}}, {{RESET}}, {{PARAMETERS}}, {{INPUT_PORTS}},
{{OUTPUT_PORTS}}, {{INTERNAL_SIGNALS}}, {{MODULE_SHORT}},
{{PORT_DECLARATIONS}}, {{NS31A_ASSERTIONS}}`.
Edit templates only with advisor approval.

Sequential template enforces:
- `@(posedge clk_i) disable iff (!rst_ni)` on every property
- `##N` for temporal delays, `$past()` for previous-cycle values
- Named property + assert, JSON log first, UNTRANSLATABLE flagging

Combinational template (PMP only) enforces:
- ZERO clocking constructs (no `@(posedge)`, `##N`, `$past()`, `disable iff`)
- Plain concurrent properties or `always_comb` immediate assertions

### Sub-step 1C: Claude Code Translation (translate.py)

```
python pipeline/translate.py --module csr
```
Runs:
```
claude -p "$(cat pipeline/prompts/final_prompt_<MODULE>.txt)"
```

Claude outputs two sections:
1. JSON mapping log (parsed for TAR computation)
2. SVA bind file candidate

TAR log written to `pipeline/logs/<MODULE>_tar_log.json`:
```json
{
  "module": "ibex_cs_registers",
  "timestamp": "ISO8601",
  "total_ns31a_signals": 23,
  "auto_accepted": 19,
  "untranslatable": 2,
  "human_corrected": 0,
  "TAR": 82.6,
  "mappings": [
    {"ns31a": "CsrWtAddr",  "ibex": "csr_addr_i",    "status": "auto"},
    {"ns31a": "ModeSignal", "ibex": "UNTRANSLATABLE", "status": "flagged"}
  ]
}
```

### Sub-step 1D: QuestaSim Compile Loop (validate_compile.py)

Max 3 retries. State file tracks attempt count per module.
On FAIL: log to `errors/archive/<MODULE>_compile_<N>.log` (NEVER DELETE).
Build retry prompt = original prompt + error content. Send to Claude.
After 3 failures: set `locked=true`, print ESCALATE, stop.

Retry prompt addition (verbatim):
```
PREVIOUS COMPILATION FAILED (attempt N):
{error_log_content}
Fix SVA bind file to resolve this error.
Use ONLY signals from the original signal list.
Do not change assertion logic — fix syntax only.
```

### Sub-step 1E: Bind Wrapper Builder (build_wrapper.py)

Adds bind statement:
```
bind ibex_cs_registers ibex_csr_assertions u_csr_assertions (
  .clk_i(clk_i), .rst_ni(rst_ni), .*);
```
Output: `assertions/translated/<MODULE>_bind.sv`

### Sub-step 1F: JasperGold FPV Baseline (validate_fpv.py)

Auto-generated TCL:
```
clear -all
analyze -sv12 rtl/ibex/original/<MODULE>.sv
analyze -sv12 assertions/translated/<MODULE>_bind.sv
elaborate -top <MODULE>
clock clk_i
reset -expression {!rst_ni}
prove -bg -all
check_vacuity -all
report -results -file results/step1/<MODULE>_fpv_baseline.txt
report -vacuity -file results/step1/<MODULE>_vacuity.txt
report -cov     -file results/step1/<MODULE>_cov.txt
exit
```

Pass criteria (BOTH required, no human gate):
1. All properties Proven (no JasperGold errors)
2. All properties non-vacuous (vacuity check passes)

**CEX semantics — clean RTL only in this paper.** A counter-example here
means the translated assertion is wrong. Retry the translation, do NOT
treat CEX as a Trojan finding (Trojan handling lives in the journal
paper).

If vacuous: retry prompt
```
assertion {NAME} antecedent never fires, rewrite so trigger is reachable
in normal <MODULE> operation.
```
Max 3 JasperGold retries. After 3 failures, set `locked=true`.

### Master Orchestrator (run_step1.py)

```
python pipeline/run_step1.py --module csr            # single module
python pipeline/run_step1.py --all-modules           # all 9 logical modules
python pipeline/run_step1.py --module csr --mode local   # laptop only
python pipeline/run_step1.py --module csr --mode server  # server only
python pipeline/run_step1.py --status
```

Module names: `pmp, csr, do, eti, cf, mt, ma, ie, ru`.
(Note: 9 logical modules. Paper diagram shows 9. The 10th bind file
listed in the old CLAUDE.md was an artifact of the controller split —
we still produce 4 controller bind files but they count as 4 logical
modules under one RTL file.)

---

## METRICS (BEC paper)

**TAR — Translation Acceptance Rate** (the only novel metric in this paper)

```
TAR = auto_accepted / total_ns31a_signals * 100
```
Computed per module from `<MODULE>_tar_log.json`. Report per-module
table plus aggregate.

**SATR — Security Assertion Translation Rate** (reporting metric, not novel)

```
SATR = successfully_validated_assertions / total_source_assertions * 100
```
"Successfully validated" means QuestaSim compile passed AND JasperGold
FPV Proven AND non-vacuous, all without human intervention.

**Reproducibility check**

Run the full pipeline twice with the same inputs. Diff the outputs.
The pipeline passes the reproducibility check if `diff` is empty across
all bind files. Report this in the experimental section as a hard
property of the pipeline.

That is the entire metric set for the BEC paper. AQS, AER, SAPC, TCFC,
TDER, WTDR, AAD all live in the journal paper.

---

## LAPTOP + SERVER WORKFLOW (carried over)

```
LAPTOP (parse + translate, no licences):
  python pipeline/run_step1.py --module csr --mode local
  git add pipeline/signals/ pipeline/logs/ assertions/translated/
  git commit -m "Step1 local: csr translated"
  git push

SERVER (QuestaSim + JasperGold):
  git pull
  python pipeline/run_step1.py --module csr --mode server
  git add results/ errors/
  git commit -m "Step1 server: csr validated"
  git push

LAPTOP (collect, status):
  git pull
  python pipeline/run_step1.py --status
```

---

## PAPER STRUCTURE — 6 PAGES

```
§1 Introduction              ~0.75 page
§2 Related Work              ~0.75 page
§3 Methodology               ~1.5 pages
   3a. Overview diagram
   3b. PyVerilog parser
   3c. Fixed prompt templates
   3d. Claude Code translation step
   3e. QuestaSim + JasperGold validation gate
§4 Experiments               ~1.75 pages
   4a. Setup (Ibex, NS31A source, environment)
   4b. Per-module TAR table
   4c. SATR aggregate
   4d. Reproducibility result
   4e. Cost comparison vs manual / vs GPU-LLM baselines
§5 Limitations + Future Work ~0.5 page
§6 Conclusion                ~0.25 page
References                   (bottom of last column)
```

Section anchors that must appear in §1:
- Cite ISCAS prior work (our group)
- Cite MEMOCODE 2023 (Chuah, source corpus)
- Cite AutoAssert/TrustAssert DATE 2026 (different problem)
- State the three contributions in a numbered list
- Reproducibility claim: zero GPU, Claude Code subscription only

---

## REPOSITORY STRUCTURE

```
ai-autotrans-rv/
├── CLAUDE.md                        ← THIS FILE
├── README.md
├── requirements.txt                 ← pyverilog, pandas
│
├── pipeline/
│   ├── parse_rtl.py
│   ├── build_prompt.py
│   ├── translate.py
│   ├── validate_compile.py
│   ├── build_wrapper.py
│   ├── validate_fpv.py
│   ├── run_step1.py                 ← master orchestrator
│   ├── templates/
│   │   ├── sequential_prompt.txt    ← FIXED, human-crafted
│   │   └── combinational_prompt.txt ← FIXED, PMP only
│   ├── signals/                     ← parser output (auto-generated)
│   ├── prompts/                     ← built prompts (auto-generated)
│   └── logs/                        ← TAR logs (auto-generated)
│
├── rtl/
│   └── ibex/
│       └── original/                ← Ibex RTL (read-only — never modify)
│
├── assertion_dataset/               ← NS31A source assertions (10 CSVs)
│   ├── ns31a_pmp.csv
│   ├── ns31a_csr.csv
│   └── ... (one per logical module)
│
├── assertions/
│   └── translated/                  ← bind files (one per logical module)
│
├── jasper/
│   └── fpv_baseline.tcl             ← TCL template
│
├── results/
│   └── step1/                       ← FPV reports, vacuity, COV
│
├── errors/
│   └── archive/                     ← compile + FPV failure logs (NEVER DELETE)
│
├── metrics/
│   ├── compute_tar.py
│   └── compute_satr.py
│
└── paper/                           ← LaTeX source for BEC submission
    ├── main.tex
    ├── refs.bib
    └── figures/
```

---

## DECISIONS LOG (locked — do not change without advisor approval)

| Decision | Value | Reason |
|----------|-------|--------|
| Venue | BEC 2026 | Advisor decision, May 2026 |
| Length | 6 pages | BEC limit |
| Stage scope | Stage 1 only | Journal paper covers Stages 2-5 |
| Primary target | Ibex | Available, well-documented |
| Secondary target | CVA6 (stretch) | Adds portability claim if time |
| Source corpus | MEMOCODE 2023 NS31A | Already extracted to CSV |
| Translation method | Fixed template + parser + Claude CLI | Reproducibility |
| Validation gate | QuestaSim + JasperGold FPV | Proven + non-vacuous |
| Max retries | 3 (compile), 3 (FPV) | Same as old CLAUDE.md |
| Human gate | NONE | Validation gate is mechanical |
| Error log policy | NEVER DELETE | Paper evidence |
| Clock | clk_i | Ibex convention |
| Reset | rst_ni active-low | Ibex convention |
| Assertion insertion | BIND FILES ONLY | Never modify RTL |
| BLEU/ROUGE | DO NOT USE | Wrong metrics for HW assertions |
| GPU | NONE | Claude Code subscription only |

---

## 20-DAY TIMELINE (deadline anchor: 27 May 2026)

**Days 1-3 (May 7-9) — repo bootstrap and parser**
- Create GitHub repo `ai-autotrans-rv`, push initial structure
- Copy NS31A CSVs into `assertion_dataset/`
- Copy Ibex RTL into `rtl/ibex/original/` (read-only)
- Write `parse_rtl.py`, test on PMP and CSR
- Acceptance: signals.json produced for all 9 logical modules

**Days 4-6 (May 10-12) — templates and prompt builder**
- Write `sequential_prompt.txt` (the fixed template)
- Write `combinational_prompt.txt` (PMP-only)
- Write `build_prompt.py` placeholder substitution
- Acceptance: a final prompt for CSR can be inspected by hand and looks right

**Days 7-10 (May 13-16) — translation + compile loop**
- Write `translate.py` (Claude Code CLI invocation)
- Write `validate_compile.py` (QuestaSim, max 3 retries)
- Write `build_wrapper.py`
- Run end-to-end on PMP and CSR
- Acceptance: PMP and CSR bind files compile clean

**Days 11-14 (May 17-20) — FPV validation, all modules**
- Write `validate_fpv.py` and `run_step1.py`
- Run all 9 logical modules through end-to-end pipeline
- Capture TAR per module, SATR aggregate
- Run reproducibility check (full pipeline twice, diff outputs)
- Acceptance: results table fully populated

**Days 15-17 (May 21-23) — paper draft**
- LaTeX skeleton, fill §3 and §4 first (methodology + experiments)
- Then §1, §2, §5, §6
- Generate all figures (pipeline diagram, TAR bar chart, cost table)
- Acceptance: complete 6-page draft

**Days 18-20 (May 24-26) — advisor review + revisions**
- Send to Uljana and Tara on May 24
- Two revision rounds
- Final compile, submission package

**May 27 — submit.**

If a phase slips:
- Drop CVA6 first (stretch goal)
- Drop SVA-from-English-only stretch goal next
- Drop the trojan-detection sanity-check appendix next
- Never drop reproducibility check

---

## RULES OF ENGAGEMENT FOR CLAUDE CODE

When working on this codebase:

1. Read this CLAUDE.md completely at the start of every session.
2. Run `python pipeline/run_step1.py --status` to see where the project is.
3. Ask Sharjeel which module or step to work on.
4. Never modify files in `rtl/ibex/original/`.
5. Never delete logs in `errors/archive/` (paper evidence).
6. Always include `check_vacuity` in every JasperGold TCL.
7. Templates in `pipeline/templates/` are FIXED — only edit with advisor
   approval.
8. Commit results after every successful module completion.
9. If scope-drift questions come up ("should we also do X?"), default to
   "no, that belongs to the journal paper." Stage 1 only.
10. Cite ISCAS, MEMOCODE 2023, and the SecMetric companion paper in any
    paper-related text generated.

---

## CURRENT STATUS (update as work progresses)

### Repo bootstrap
- [ ] GitHub repo created
- [ ] CLAUDE.md committed
- [ ] NS31A CSVs in assertion_dataset/
- [ ] Ibex RTL in rtl/ibex/original/

### Pipeline
- [ ] parse_rtl.py written and tested
- [ ] sequential_prompt.txt written
- [ ] combinational_prompt.txt written
- [ ] build_prompt.py written
- [ ] translate.py written
- [ ] validate_compile.py written
- [ ] build_wrapper.py written
- [ ] validate_fpv.py written
- [ ] run_step1.py master written

### Per-module pipeline runs
- [ ] PMP — Stage 1 complete
- [ ] CSR — Stage 1 complete
- [ ] DO — Stage 1 complete
- [ ] ETI — Stage 1 complete
- [ ] CF — Stage 1 complete
- [ ] MT — Stage 1 complete
- [ ] MA — Stage 1 complete
- [ ] IE — Stage 1 complete
- [ ] RU — Stage 1 complete

### Metrics
- [ ] compute_tar.py
- [ ] compute_satr.py
- [ ] Per-module TAR table
- [ ] Reproducibility check (run twice, diff)

### Paper
- [ ] LaTeX skeleton
- [ ] §3 Methodology
- [ ] §4 Experiments
- [ ] §1 Introduction
- [ ] §2 Related Work
- [ ] §5 Limitations
- [ ] §6 Conclusion
- [ ] Figures (pipeline diagram, TAR chart, cost comparison)
- [ ] References (.bib)

### Submission
- [ ] Sent to advisors May 24
- [ ] Revisions complete
- [ ] Submitted to BEC 2026 by 27 May

---

## NAMING (use exactly — no variations)

**Stage:**
- Assertion Translation Stage (ATS) — Stage 1 of the larger flow.
  In this paper, it is THE stage.

**Metrics:**
- Translation Acceptance Rate (TAR)
- Security Assertion Translation Rate (SATR)

**Tools:**
- JasperGold Formal Property Verification (FPV)
- QuestaSim
- Claude Code CLI
- pyverilog

**Files:**
- bind file (not wrapper, not assertion file)
- signals.json

**Processors:**
- NS31A (reference, assertion source)
- Ibex (target, primary)
- CVA6 (target, stretch goal)
