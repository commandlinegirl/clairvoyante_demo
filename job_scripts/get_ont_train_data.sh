
VPREFIX=/data_from_the_preprint/hg001_hg37_variants
PREFIX=/data_from_the_preprint/ONT_HG001_training_data
VCF_FILE=$VPREFIX/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz
VCF_IDX=$VPREFIX/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz.tbi
BED_FILE=$VPREFIX/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_nosomaticdel.bed
REF_FILE=/data_from_the_preprint/references/hs37d5.fa.gz
BAM_FILE=$PREFIX/na12878_ont_rel5_rel3and4_ngmlr-0.2.6_mapped.bam
BAM_IDX=$PREFIX/na12878_ont_rel5_rel3and4_ngmlr-0.2.6_mapped.bam.bai
CTG_LIST=/data_from_the_preprint/references/hs37d5_ctg_list

OUTPUT_DIR=ONT_HG001_training_results
# dx mkdir $OUTPUT_DIR 
dx run applets/build_training_dataset -i stage-0.vcf_file=$VCF_FILE\
	                              -i stage-0.vcf_index=$VCF_IDX\
		     	              -i stage-0.bed_file=$BED_FILE\
			              -i stage-0.bam_file=$BAM_FILE\
			              -i stage-0.bam_idx=$BAM_IDX\
			              -i stage-0.ctg_list=$CTG_LIST\
			              -i stage-0.ref_file=$REF_FILE\
			              --destination $OUTPUT_DIR 
