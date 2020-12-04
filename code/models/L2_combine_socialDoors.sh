#!/usr/bin/env bash

maindir='/data/projects/STUDIES/social_doors_jw'

sub=$1
nruns=2
sm=6
dtype=dctAROMAnonaggr

MAINOUTPUT=${maindir}/derivatives/fsl/results/lowerLv_results/sub-${sub}
echo $maindir
# Social Doors Task
NCOPES=5

INPUT1=${MAINOUTPUT}/$2
INPUT2=${MAINOUTPUT}/$3
INPUT3=${MAINOUTPUT}/$4
INPUT4=${MAINOUTPUT}/$5
INPUT5=${MAINOUTPUT}/$6
INPUT6=${MAINOUTPUT}/$7
INPUT7=${MAINOUTPUT}/$8
INPUT8=${MAINOUTPUT}/$9

DMEAN1=${10}
DMEAN2=${11}
DMEAN3=${12}
DMEAN4=${13}
DMEAN5=${14}
DMEAN6=${15}
DMEAN7=${16}
DMEAN8=${17}

OUTPUT=${MAINOUTPUT}/L2_task-srSocialDoors_model-01_type-act_sm-${sm}_variant-${dtype}

if [ -e ${OUTPUT}.gfeat/cope${NCOPES}.feat/cluster_mask_zstat1.nii.gz ]; then
    echo "skipping existing output"
else
    echo "re-doing: ${OUTPUT}" >> re-runL2.log
    rm -rf ${OUTPUT}.gfeat
    
    ITEMPLATE=${maindir}/code/templates/l2_design.fsf
    echo $ITEMPLATE
    OTEMPLATE=${MAINOUTPUT}/L2_task-srSocialDoors_model-01_type-act_variant-${dtype}.fsf
    sed -e 's@OUTPUT@'$OUTPUT'@g' \
    -e 's@INPUT1@'$INPUT1'@g' \
    -e 's@INPUT2@'$INPUT2'@g' \
    -e 's@INPUT3@'$INPUT3'@g' \
    -e 's@INPUT4@'$INPUT4'@g' \
    -e 's@INPUT5@'$INPUT5'@g' \
    -e 's@INPUT6@'$INPUT6'@g' \
    -e 's@INPUT7@'$INPUT7'@g' \
    -e 's@INPUT8@'$INPUT8'@g' \
    -e 's@DMEAN1@'$DMEAN1'@g' \
    -e 's@DMEAN2@'$DMEAN2'@g' \
    -e 's@DMEAN3@'$DMEAN3'@g' \
    -e 's@DMEAN4@'$DMEAN4'@g' \
    -e 's@DMEAN5@'$DMEAN5'@g' \
    -e 's@DMEAN6@'$DMEAN6'@g' \
    -e 's@DMEAN7@'$DMEAN7'@g' \
    -e 's@DMEAN8@'$DMEAN8'@g' \
    <$ITEMPLATE> $OTEMPLATE
    feat $OTEMPLATE

    # delete unused files
    for cope in `seq ${NCOPES}`; do
        rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/res4d.nii.gz
        rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/corrections.nii.gz
        rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/threshac1.nii.gz
        rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/filtered_func_data.nii.gz
        rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/var_filtered_func_data.nii.gz
    done

fi

