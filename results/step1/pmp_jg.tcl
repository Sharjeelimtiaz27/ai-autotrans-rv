clear -all

analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_pkg.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original/ibex_pmp.sv}
analyze -sv12 +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/ibex/original +incdir+/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/rtl/stubs {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/assertions/fpv/pmp_fpv.sv}

elaborate -top ibex_pmp_fpv
clock -none
reset -none

prove -all

report -results -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/pmp_fpv_baseline.txt}
catch {report -vacuity -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/pmp_vacuity.txt}}
catch {report -cov     -force -file {/home/sharjeel/sharjeelphd/Research/Ai_autoasser_rv/ai-autotrans-rv/results/step1/pmp_cov.txt}}
exit
