#!/bin/bash 

###########################################
# 目录变量
###########################################
EXPER_DIR=$(dirname $0)

##########################################
# You can either use this script to generate the DenseCRF post-processed results
# or use the densecrf_layer (wrapper) in Caffe
###########################################
DATASET=voc12
LOAD_MAT_FILE=1

MODEL_NAME=vgg16

TEST_SET=val           #val, test

# the features  folder save the features computed via the model trained with the train set
# the features2 folder save the features computed via the model trained with the trainval set
FEATURE_NAME=features #features, features2
FEATURE_TYPE=fc8

# specify the parameters
MAX_ITER=10

Bi_W=4
Bi_X_STD=49
Bi_Y_STD=49
Bi_R_STD=5
Bi_G_STD=5 
Bi_B_STD=5

POS_W=3
POS_X_STD=3
POS_Y_STD=3


#######################################
# MODIFY THE PATY FOR YOUR SETTING
#######################################
SAVE_DIR=${EXPER_DIR}/${DATASET}/res/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}/post_densecrf_W${Bi_W}_XStd${Bi_X_STD}_RStd${Bi_R_STD}_PosW${POS_W}_PosXStd${POS_X_STD}

echo "SAVE TO ${SAVE_DIR}"

if [ "${EXPER_DIR}" == "." ]; then
    CRF_DIR=../densecrf
else
    CRF_DIR=$(dirname $EXPER_DIR)/densecrf
fi

# NOTE THAT the densecrf code only loads ppm images
IMG_DIR=${EXPER_DIR}/${DATASET}/dataset/PPMImages

if [ ${LOAD_MAT_FILE} == 1 ]
then
    # the features are saved in .mat format
    CRF_BIN=${CRF_DIR}/prog_refine_pascal_v4
    FEATURE_DIR=${EXPER_DIR}/${DATASET}/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}
else
    # the features are saved in .bin format (has called SaveMatAsBin.m in the densecrf/my_script)
    CRF_BIN=${CRF_DIR}/prog_refine_pascal
    FEATURE_DIR=${EXPER_DIR}/${DATASET}/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}/bin
fi

if [ ! -f "${CRF_BIN}" ]; then
	pushd $(dirname ${CRF_BIN})
		make
	popd
fi

mkdir -p ${SAVE_DIR}

# run the program
INIT=${EXPER_DIR}/${DATASET}/init.sh
if [ -f $INIT ]; then
    sh $INIT
fi
${CRF_BIN} -id ${IMG_DIR} -fd ${FEATURE_DIR} -sd ${SAVE_DIR} -i ${MAX_ITER} -px ${POS_X_STD} -py ${POS_Y_STD} -pw ${POS_W} -bx ${Bi_X_STD} -by ${Bi_Y_STD} -br ${Bi_R_STD} -bg ${Bi_G_STD} -bb ${Bi_B_STD} -bw ${Bi_W}

