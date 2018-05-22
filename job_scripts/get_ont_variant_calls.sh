
PREFIX=/data_from_the_preprint
REF_FILE=/data_from_the_preprint/references/hs37d5.fa.gz
BAM_FILE=$PREFIX/ONT_HG001_training_data/na12878_ont_rel5_rel3and4_ngmlr-0.2.6_mapped.bam
BAM_IDX=$PREFIX/ONT_HG001_training_data/na12878_ont_rel5_rel3and4_ngmlr-0.2.6_mapped.bam.bai
SAMPLE_NAME="HG001"
MODLE_PREFIX=cv_model-000096

OUTPUT_DIR=ONT_HG001_training_results
MODEL_TAR_BALL=$OUTPUT_DIR/models.tar.gz
# dx mkdir $OUTPUT_DIR 
dx run applets/cv_variant_call -i bam_file=$BAM_FILE\
			       -i bam_idx=$BAM_IDX\
			       -i ref_file=$REF_FILE\
			       -i sample_name=$SAMPLE_NAME\
			       -i model_prefix=$MODLE_PREFIX\
			       -i model_tar_ball=$MODEL_TAR_BALL\
			       -i threshold=0.25\
			       --destination $OUTPUT_DIR 


