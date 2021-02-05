#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"

# JW: Need to update lines below here; 
# runs subjects but what does the 2 stand for? need to add comments throughout these scripts; going back to the basics with Andy's Brain Book this weekend to revisit this stuff
for ppi in 0 VMPFC VS ecn dmn; do # putting 0 first will indicate "activation"
	for subrun in "3836 2" "3845 2" "3846 2" "3847 2" "3848 2" "3849 2" "3851 2" "3852 2" "3854 2" "3855 2" "3864 2" "3865 2" "3871 2" "3877 2" "3880 2" "3882 2" "3883 2" "3886 2" "3887 2" "3889 2" "3890 2" "3891 2" "3892 2" "3893 2" "3895 2" "3910 2" "3912 2" "3920 2" "3967 2" "3992 2" "4017 2" "4018 2" "4019 2" "4020 2"; do
	  set -- $subrun
	  sub=$1
	  nruns=$2

	  for run in `seq $nruns`; do
	  	# Manages the number of jobs and cores
	  	SCRIPTNAME=${basedir}/code/L1stats.sh
	  	NCORES=25
	  	while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
	    		sleep 1s
	  	done
	  	bash $SCRIPTNAME $sub $run $ppi &
	  	sleep 1s
	  done

	done
done
