
PREFIX=/data_from_the_preprint/
REF_FILE=/data_from_the_preprint/references/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna.gz
BAM_FILE=$PREFIX/HG002.GRCh38.50x.rg.bam
BAM_IDX=$PREFIX/HG002.GRCh38.50x.rg.bam.bai
SAMPLE_NAME="HG002"
MODLE_PREFIX=cv_model-000072

OUTPUT_DIR=Illumina_HG001_training_results
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


