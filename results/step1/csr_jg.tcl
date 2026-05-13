clear -all

analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_pkg.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_csr.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_counter.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_cs_registers.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/assertions/translated/csr_bind.sv}

elaborate -top ibex_cs_registers
clock clk_i
reset -expression {!rst_ni}

prove -all

report -results -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/csr_fpv_baseline.txt}
catch {report -vacuity -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/csr_vacuity.txt}}
catch {report -cov     -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/csr_cov.txt}}
exit
