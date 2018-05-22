
PREFIX=/data_from_the_preprint/
REF_FILE=/data_from_the_preprint/references/hs37d5.fa.gz
BAM_FILE=$PREFIX/all_reads.fa.giab_h002_ngmlr-0.2.3_mapped.rg.bam
BAM_IDX=$PREFIX/all_reads.fa.giab_h002_ngmlr-0.2.3_mapped.rg.bam.bai
SAMPLE_NAME="HG002"
MODLE_PREFIX=cv_model-000043

OUTPUT_DIR=PacBio_HG001_training_results
MODEL_TAR_BALL=$OUTPUT_DIR/models.tar.gz
# dx mkdir $OUTPUT_DIR 
dx run applets/cv_variant_call -i bam_file=$BAM_FILE\
			       -i bam_idx=$BAM_IDX\
			       -i ref_file=$REF_FILE\
			       -i sample_name=$SAMPLE_NAME\
			       -i model_prefix=$MODLE_PREFIX\
			       -i model_tar_ball=$MODEL_TAR_BALL\
			       -i threshold=0.2\
			       --destination $OUTPUT_DIR 


