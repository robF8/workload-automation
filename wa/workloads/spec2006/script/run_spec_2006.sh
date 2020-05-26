#!/bin/bash
TARGET_OUT_DIR=$3
if [ $1 = "400.perlbench" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/400.perlbench/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./perlbench_base.none -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1  > '$TARGET_OUT_DIR'/perlbench.ref.checkspam.out 2>  '$TARGET_OUT_DIR'/perlbench.ref.checkspam.err'
    sh -c 'cd /data/local/tmp/spec2k6/400.perlbench/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./perlbench_base.none -I./lib diffmail.pl 4 800 10 17 19 300  > '$TARGET_OUT_DIR'/perlbench.ref.diffmail.out 2>  '$TARGET_OUT_DIR'/perlbench.ref.diffmail.err'
    sh -c 'cd /data/local/tmp/spec2k6/400.perlbench/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./perlbench_base.none -I./lib splitmail.pl 1600 12 26 16 4500  > '$TARGET_OUT_DIR'/perlbench.ref.splitmail.out 2>  '$TARGET_OUT_DIR'/perlbench.ref.splitmail.err'
elif [ $1 = "401.bzip2" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/401.bzip2/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bzip2_base.none chicken.jpg 30 > '$TARGET_OUT_DIR'/bzip2.ref.chicken.out 2>  '$TARGET_OUT_DIR'/bzip2.ref.chicken.err'
    sh -c 'cd /data/local/tmp/spec2k6/401.bzip2/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bzip2_base.none input.source 280 > '$TARGET_OUT_DIR'/bzip2.ref.source.out 2>  '$TARGET_OUT_DIR'/bzip2.ref.source.err' 
    sh -c 'cd /data/local/tmp/spec2k6/401.bzip2/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bzip2_base.none liberty.jpg 30 > '$TARGET_OUT_DIR'/bzip2.ref.liberty.out 2>  '$TARGET_OUT_DIR'/bzip2.ref.liberty.err'
    sh -c 'cd /data/local/tmp/spec2k6/401.bzip2/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bzip2_base.none input.program 280 > '$TARGET_OUT_DIR'/bzip2.ref.program.out 2>  '$TARGET_OUT_DIR'/bzip2.ref.program.err'
    sh -c 'cd /data/local/tmp/spec2k6/401.bzip2/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bzip2_base.none text.html 280 > '$TARGET_OUT_DIR'/bzip2.ref.text.out 2>  '$TARGET_OUT_DIR'/bzip2.ref.text.err'
    sh -c 'cd /data/local/tmp/spec2k6/401.bzip2/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bzip2_base.none input.combined 200 > '$TARGET_OUT_DIR'/bzip2.ref.combined.out 2>  '$TARGET_OUT_DIR'/bzip2.ref.combined.err'
elif [ $1 = "403.gcc" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none 166.in -o 166.s  > '$TARGET_OUT_DIR'/gcc.ref.166.out 2>  '$TARGET_OUT_DIR'/gcc.ref.166.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none 200.in -o 200.s  > '$TARGET_OUT_DIR'/gcc.ref.200.out 2>  '$TARGET_OUT_DIR'/gcc.ref.200.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none c-typeck.in -o c-typeck.s  > '$TARGET_OUT_DIR'/gcc.ref.c-typeck.out 2>  '$TARGET_OUT_DIR'/gcc.ref.c-typeck.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none cp-decl.in -o cp-decl.s  > '$TARGET_OUT_DIR'/gcc.ref.cp-decl.out 2>  '$TARGET_OUT_DIR'/gcc.ref.cp-decl.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none expr.in -o expr.s  > '$TARGET_OUT_DIR'/gcc.ref.expr.out 2>  '$TARGET_OUT_DIR'/gcc.ref.expr.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none expr2.in -o expr2.s  > '$TARGET_OUT_DIR'/gcc.ref.expr2.out 2>  '$TARGET_OUT_DIR'/gcc.ref.expr2.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none g23.in -o g23.s  > '$TARGET_OUT_DIR'/gcc.ref.g23.out 2>  '$TARGET_OUT_DIR'/gcc.ref.g23.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none s04.in -o s04.s  > '$TARGET_OUT_DIR'/gcc.ref.s04.out 2>  '$TARGET_OUT_DIR'/gcc.ref.s04.err'
    sh -c 'cd /data/local/tmp/spec2k6/403.gcc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gcc_base.none scilab.in -o scilab.s  > '$TARGET_OUT_DIR'/gcc.ref.scilab.out 2>  '$TARGET_OUT_DIR'/gcc.ref.scilab.err'
elif [ $1 = "429.mcf" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/429.mcf/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./mcf_base.none inp.in  > '$TARGET_OUT_DIR'/mcf.ref.out 2>  '$TARGET_OUT_DIR'/mcf.ref.err'
elif [ $1 = "445.gobmk" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/445.gobmk/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gobmk_base.none --quiet --mode gtp < 13x13.tst  > '$TARGET_OUT_DIR'/gobmk.ref.13x13.out 2>  '$TARGET_OUT_DIR'/gobmk.ref.13x13.err'
    sh -c 'cd /data/local/tmp/spec2k6/445.gobmk/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gobmk_base.none --quiet --mode gtp < nngs.tst  > '$TARGET_OUT_DIR'/gobmk.reff.nngs.out 2>  '$TARGET_OUT_DIR'/gobmk.ref.nngs.err'
    sh -c 'cd /data/local/tmp/spec2k6/445.gobmk/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gobmk_base.none --quiet --mode gtp < score2.tst  > '$TARGET_OUT_DIR'/gobmk.ref.score2.out 2>  '$TARGET_OUT_DIR'/gobmk.ref.score2.err'
    sh -c 'cd /data/local/tmp/spec2k6/445.gobmk/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gobmk_base.none --quiet --mode gtp < trevorc.tst  > '$TARGET_OUT_DIR'/gobmk.ref.trevorc.out 2>  '$TARGET_OUT_DIR'/gobmk.ref.trevorc.err'
    sh -c 'cd /data/local/tmp/spec2k6/445.gobmk/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gobmk_base.none --quiet --mode gtp < trevord.tst  > '$TARGET_OUT_DIR'/gobmk.ref.trevord.out 2>  '$TARGET_OUT_DIR'/gobmk.ref.trevord.err'
elif [ $1 = "456.hmmer" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/456.hmmer/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./hmmer_base.none nph3.hmm swiss41  > '$TARGET_OUT_DIR'/hmmer.ref.nph3.out 2>  '$TARGET_OUT_DIR'/hmmer.ref.nph3.err'
    sh -c 'cd /data/local/tmp/spec2k6/456.hmmer/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./hmmer_base.none --fixed 0 --mean 500 --num 500000 --sd 350 --seed 0 retro.hmm  > '$TARGET_OUT_DIR'/hmmer.ref.retro.out 2>  '$TARGET_OUT_DIR'/hmmer.ref.retro.err'
elif [ $1 = "458.sjeng" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/458.sjeng/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./sjeng_base.none ref.txt  > '$TARGET_OUT_DIR'sjeng.ref.out 2>  '$TARGET_OUT_DIR'/sjeng.ref.err'
elif [ $1 = "462.libquantum" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/462.libquantum/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./libquantum_base.none 1397 8  > '$TARGET_OUT_DIR'/libquantum.ref.out 2>  '$TARGET_OUT_DIR'libquantum.ref.err'
elif [ $1 = "464.h264ref" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/464.h264ref/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./h264ref_base.none -d foreman_ref_encoder_baseline.cfg  > '$TARGET_OUT_DIR'/h264ref.ref.foreman_baseline.out 2>  '$TARGET_OUT_DIR'/h264ref.ref.foreman_baseline.err'
    sh -c 'cd /data/local/tmp/spec2k6/464.h264ref/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./h264ref_base.none -d foreman_ref_encoder_main.cfg  > '$TARGET_OUT_DIR'/h264ref.ref.foreman_main.out 2>  '$TARGET_OUT_DIR'/h264ref.ref.foreman_main.err'
    sh -c 'cd /data/local/tmp/spec2k6/464.h264ref/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./h264ref_base.none -d sss_encoder_main.cfg  > '$TARGET_OUT_DIR'/h264ref.ref.sss.out 2>  '$TARGET_OUT_DIR'/h264ref.ref.sss.err'
elif [ $1 = "471.omnetpp" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/471.omnetpp/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./omnetpp_base.none omnetpp.ini  > '$TARGET_OUT_DIR'/omnetpp.ref.out 2>  '$TARGET_OUT_DIR'/omnetpp.ref.err'
elif [ $1 = "473.astar" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/473.astar/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./astar_base.none BigLakes2048.cfg  > '$TARGET_OUT_DIR'/astar.ref.BigLakes2048.out 2>  '$TARGET_OUT_DIR'/astar.ref.BigLakes2048.err'
    sh -c 'cd /data/local/tmp/spec2k6/473.astar/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./astar_base.none rivers.cfg  > '$TARGET_OUT_DIR'/astar.ref.rivers.out 2>  '$TARGET_OUT_DIR'/astar.ref.rivers.err'
elif [ $1 = "483.xalancbmk" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/483.xalancbmk/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./Xalan_base.none -v t5.xml xalanc.xsl  > '$TARGET_OUT_DIR'/xalancbmk.ref.out 2>  '$TARGET_OUT_DIR'/xalancbmk.ref.err' 
elif [ $1 = "410.bwaves" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/410.bwaves/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./bwaves_base.none  > '$TARGET_OUT_DIR'/bwaves.ref.out 2> '$TARGET_OUT_DIR'/bwaves.ref.err'
elif [ $1 = "416.gamess" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/416.gamess/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gamess_base.none < cytosine.2.config  > '$TARGET_OUT_DIR'/gamess.ref.cytosine.out 2>  '$TARGET_OUT_DIR'/mess.ref.cytosine.err'
    sh -c 'cd /data/local/tmp/spec2k6/416.gamess/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gamess_base.none < h2ocu2+.gradient.config  > '$TARGET_OUT_DIR'/gamess.ref.h2ocu2+.out 2>  '$TARGET_OUT_DIR'/gamess.ref.h2ocu2+.err'
    sh -c 'cd /data/local/tmp/spec2k6/416.gamess/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gamess_base.none < triazolium.config  > '$TARGET_OUT_DIR'/gamess.ref.triazolium.out 2>  '$TARGET_OUT_DIR'/gamess.ref.triazolium.err'
elif [ $1 = "433.milc" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/433.milc/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./milc_base.none < su3imp.in  > '$TARGET_OUT_DIR'/milc.ref.out 2>  '$TARGET_OUT_DIR'/milc.ref.err'
elif [ $1 = "434.zeusmp" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/434.zeusmp/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./zeusmp_base.none  > '$TARGET_OUT_DIR'/zeusmp.ref.out 2>  '$TARGET_OUT_DIR'/zeusmp.ref.err'
elif [ $1 = "435.gromacs" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/435.gromacs/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./gromacs_base.none -silent -deffnm gromacs -nice 0  > '$TARGET_OUT_DIR'/gromacs.ref.out 2>  '$TARGET_OUT_DIR'/gromacs.ref.err'
elif [ $1 = "436.cactusADM" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/436.cactusADM/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./cactusADM_base.none benchADM.par  > '$TARGET_OUT_DIR'/cactusADM.ref.out 2>  '$TARGET_OUT_DIR'/cactusADM.ref.err'
elif [ $1 = "437.leslie3d" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/437.leslie3d/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./leslie3d_base.none < leslie3d.in  > '$TARGET_OUT_DIR'/leslie3d.ref.out 2>  '$TARGET_OUT_DIR'/leslie3d.ref.err'
elif [ $1 = "444.namd" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/444.namd/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./namd_base.none --input namd.input --iterations 38 --output namd.out  > '$TARGET_OUT_DIR'/namd.ref.out 2>  '$TARGET_OUT_DIR'/namd.ref.err'
elif [ $1 = "447.dealII" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/447.dealII/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./dealII_base.none 23  > '$TARGET_OUT_DIR'/dealII.ref.out 2>  '$TARGET_OUT_DIR'/dealII.ref.err'
elif [ $1 = "450.soplex" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/450.soplex/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./soplex_base.none -s1 -e -m45000 pds-50.mps  > '$TARGET_OUT_DIR'/soplex.ref.pds-50.out 2>  '$TARGET_OUT_DIR'/soplex.ref.pds-50.err'
    sh -c 'cd /data/local/tmp/spec2k6/450.soplex/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./soplex_base.none -m3500 ref.mps  > '$TARGET_OUT_DIR'/soplex.ref.ref.out 2>  '$TARGET_OUT_DIR'/soplex.ref.ref.err'
elif [ $1 = "453.povray" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/453.povray/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./povray_base.none SPEC-benchmark-ref.ini  > '$TARGET_OUT_DIR'/povray.ref.out 2>  '$TARGET_OUT_DIR'/povray.ref.err'
elif [ $1 = "454.calculix" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/454.calculix/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./calculix_base.none -i hyperviscoplastic  > '$TARGET_OUT_DIR'/calculix.ref.out 2>  '$TARGET_OUT_DIR'/calculix.ref.err'
elif [ $1 = "459.GemsFDTD" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/459.GemsFDTD/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./GemsFDTD_base.none  > '$TARGET_OUT_DIR'/GemsFDTD.ref.out 2>  '$TARGET_OUT_DIR'/GemsFDTD.ref.err'
elif [ $1 = "465.tonto" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/465.tonto/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./tonto_base.none  > '$TARGET_OUT_DIR'/tonto.ref.out 2>  '$TARGET_OUT_DIR'/tonto.ref.err'
elif [ $1 = "470.lbm" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/470.lbm/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./lbm_base.none 3000 reference.dat 0 0 100_100_130_ldc.of  > '$TARGET_OUT_DIR'/lbm.ref.out 2>  '$TARGET_OUT_DIR'/lbm.ref.err'
elif [ $1 = "481.wrf" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/481.wrf/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./wrf_base.none  > '$TARGET_OUT_DIR'/wrf.ref.out 2>  '$TARGET_OUT_DIR'/wrf.ref.err'
elif [ $1 = "482.sphinx3" ]
then
    sh -c 'cd /data/local/tmp/spec2k6/482.sphinx3/run/run_base_ref_none.0000 && time /data/local/tmp/bin/busybox taskset '$2' ./sphinx_livepretend_base.none ctlfile . args.an4  > '$TARGET_OUT_DIR'/sphinx3.ref.out 2>  '$TARGET_OUT_DIR'/sphinx3.ref.err'
fi
