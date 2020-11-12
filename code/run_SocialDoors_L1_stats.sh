#!/bin/bash

# TODO
# 1) execute with datalad run -m "message" --input "derivatives/fmriprep/*" --output "derivatives/fsl/*" "bash run_L1stats.sh"
# 2) test with subject-specific inputs/ouputs 
# 3) adjust input/output structure (don't need to be writing to derivatives/fmriprep)


for sm in 6; do
	for ppi in 0; do #VS Amyg FFA; putting 0 first will indicate "activation"
		for subrun in "3836 2" "3845 2" "3846 2" "3847 2" "3848 2" "3849 2" "3851 2" "3852 2" "3854 2" "3855 2" "3864 2" "3865 2" "3871 2" "3877 2" "3880 2" "3882 2" "3883 2" "3886 2" "3887 2" "3889 2" "3890 2" "3891 2" "3892 2" "3893 2" "3895 2" "3910 2" "3912 2" "3920 2" "3967 2" "3992 2" "4017 2" "4018 2" "4019 2" "4020 2"; do
		  set -- $subrun
		  sub=$1
		  nruns=$2
		  #echo "$sub $nruns"
		
		  for run in `seq $nruns`; do
		  	#Manages the number of jobs and cores
		  	SCRIPTNAME=models/L1_task-srSociala_model-01.sh
		  	NCORES=7
		  	while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
		    		sleep 1s
		  	done
		  	bash $SCRIPTNAME $sub $run $ppi $sm &
		  	sleep 1s
          	done  

		  for run in `seq $nruns`; do
		  	#Manages the number of jobs and cores
		  	SCRIPTNAME=models/L1_task-srDoorsa_model-01.sh
		  	NCORES=7
		  	while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
		    		sleep 1s
		  	done
		  	bash $SCRIPTNAME $sub $run $ppi $sm &
		  	sleep 1s
		  done

		  for run in `seq $nruns`; do
		  	#Manages the number of jobs and cores
		  	SCRIPTNAME=models/L1_task-srSocialb_model-01.sh
		  	NCORES=7
		  	while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
		    		sleep 1s
		  	done
		  	bash $SCRIPTNAME $sub $run $ppi $sm &
		  	sleep 1s
          	done  

		  for run in `seq $nruns`; do
		  	#Manages the number of jobs and cores
		  	SCRIPTNAME=models/L1_task-srDoorsb_model-01.sh
		  	NCORES=7
		  	while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
		    		sleep 1s
		  	done
		  	bash $SCRIPTNAME $sub $run $ppi $sm &
		  	sleep 1s
		  done
		done
	done
done


# wait to exit so logging is correct in datalad run command
while [ $(ps -ef | grep -v grep | grep models/L1_task-srSocial_model-01.sh | wc -l) -ge 1 ]; do
	sleep 5m
	echo "STATUS: L1_task-srSocial_model-01.sh is waiting to complete at `date`"
done

while [ $(ps -ef | grep -v grep | grep models/L1_task-srDoors_model-01.sh | wc -l) -ge 1 ]; do
	sleep 5m
	echo "STATUS: L1_task-srDoors_model-01.sh is waiting to complete at `date`"
done
