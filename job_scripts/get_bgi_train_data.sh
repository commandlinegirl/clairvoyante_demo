VPREFIX=/data_from_the_preprint/hg001_hg37_variants
PREFIX=BGI_SEQ_NA12878_DATA

VCF_FILE=$VPREFIX/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer_chrs.vcf.gz
VCF_IDX=$VPREFIX/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer_chrs.vcf.gz.tbi
BED_FILE=$VPREFIX/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_nosomaticdel_chr.bed
REF_FILE=$PREFIX/ucsc_hg19_upper.fa.gz
BAM_FILE=$PREFIX/BGISEQ_PE100_NA12878.sorted.bam
BAM_IDX=$PREFIX/BGISEQ_PE100_NA12878.sorted.bam.bai
CTG_LIST=$PREFIX/ctg_ucsc_hg19_list

OUTPUT_DIR=BGI_SEQ_NA12878_training_results
# dx mkdir $OUTPUT_DIR 
dx run applets/build_training_dataset -i stage-0.vcf_file=$VCF_FILE\
	                              -i stage-0.vcf_index=$VCF_IDX\
		      	      -i stage-0.bed_file=$BED_FILE\
			      -i stage-0.bam_file=$BAM_FILE\
			      -i stage-0.bam_idx=$BAM_IDX\
			      -i stage-0.ctg_list=$CTG_LIST\
			      -i stage-0.ref_file=$REF_FILE\
			      --destination $OUTPUT_DIR 
