#!/bin/bash -l

path_data="/home/rsk3900/Datasets"
epochs=80
workers=12
lr=0.001

MODE="all_vs_one"
MIXED_PREC=0
BATCH_SIZE=27

NUM_CONDS=4

IN_NORM_LIST=(1 1 1 1)
GROWTH_RATE_LIST=(1.2 1.2 1.2 1.2)
AUG_FLAG_LIST=(0 0 0 0)

ADV_DG_LIST=(1 1 0 0)
GRAD_REV_LIST=(0 0 0 0)
ADA_IN_NORM_LIST=(0 0 0 0)
PSEUDO_LABELS_LIST=(1 0 1 0)
MAKE_UNCERTAIN_LIST=(0 0 0 0)

MAKE_ALEATORIC=0

for (( ITR=0; ITR<NUM_CONDS; ITR++ ));
do
    ADV_DG=${ADV_DG_LIST[ITR]}
    IN_NORM=${IN_NORM_LIST[ITR]}
    AUG_FLAG=${AUG_FLAG_LIST[ITR]}
    GRAD_REV=${GRAD_REV_LIST[ITR]}
    GROWTH_RATE=${GROWTH_RATE_LIST[ITR]}
    ADA_IN_NORM=${ADA_IN_NORM_LIST[ITR]}
    PSEUDO_LABELS=${PSEUDO_LABELS_LIST[ITR]}
    MAKE_UNCERTAIN=${MAKE_UNCERTAIN_LIST[ITR]}
    
    EXP_NAME="GR-${GROWTH_RATE}_all_vs_one_AUG-${AUG_FLAG}_IN_NORM-${IN_NORM}_ADV_DG-${ADV_DG}_PSEUDO_LABELS-${PSEUDO_LABELS}"

    runCMD="bash ../launch_RC.bash --BATCH_SIZE ${BATCH_SIZE} --MODE ${MODE} --GPU_TYPE a100:1 "
    runCMD+="--MIXED_PREC ${MIXED_PREC} --EXP_NAME ${EXP_NAME} --EPOCHS ${epochs} --MAKE_UNCERTAIN ${MAKE_UNCERTAIN} "
    runCMD+="--AUG_FLAG ${AUG_FLAG} --GRAD_REV ${GRAD_REV} --IN_NORM ${IN_NORM} --GROWTH_RATE ${GROWTH_RATE} "
    runCMD+="--ADA_IN_NORM ${ADA_IN_NORM} --ADV_DG ${ADV_DG} --PSEUDO_LABELS ${PSEUDO_LABELS}"

    echo $runCMD
    eval $runCMD
done
