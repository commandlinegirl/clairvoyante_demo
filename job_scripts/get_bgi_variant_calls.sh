
PREFIX=/BGI_SEQ_NA12878_DATA

REF_FILE=$PREFIX/ucsc_hg19_upper.fa.gz
BAM_FILE=$PREFIX/BGISEQ_PE100_NA12878.sorted.bam
BAM_IDX=$PREFIX/BGISEQ_PE100_NA12878.sorted.bam.bai
SAMPLE_NAME="HG001"
MODLE_PREFIX=cv_model-000100

OUTPUT_DIR=BGI_SEQ_NA12878_training_results
MODEL_TAR_BALL=$OUTPUT_DIR/models.tar.gz
# dx mkdir $OUTPUT_DIR 
dx run applets/cv_variant_call -i bam_file=$BAM_FILE\
			       -i bam_idx=$BAM_IDX\
			       -i ref_file=$REF_FILE\
			       -i sample_name=$SAMPLE_NAME\
			       -i model_prefix=$MODLE_PREFIX\
			       -i model_tar_ball=$MODEL_TAR_BALL\
			       -i threshold=0.125\
			       --destination $OUTPUT_DIR 


