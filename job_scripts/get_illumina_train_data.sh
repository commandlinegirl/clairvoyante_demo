
VPREFIX=/data_from_the_preprint/hg001_hg38_variants
PREFIX=/data_from_the_preprint/Illumina_HG001_training_data_set
VCF_FILE=$VPREFIX/HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz
VCF_IDX=$VPREFIX/HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz.tbi
BED_FILE=$VPREFIX/HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_nosomaticdel_noCENorHET7.bed
REF_FILE=/data_from_the_preprint/references/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna.gz
BAM_FILE=$PREFIX/HG001.GRCh38_full_plus_hs38d1_analysis_set_minus_alt.50x.rg.bam
BAM_IDX=$PREFIX/HG001.GRCh38_full_plus_hs38d1_analysis_set_minus_alt.50x.rg.bam.bai
CTG_LIST=/data_from_the_preprint/references/hs38d1_ctg_list

OUTPUT_DIR=Illumina_HG001_training_results
# dx mkdir $OUTPUT_DIR 
dx run applets/cv_build_training_dataset -i stage-0.vcf_file=$VCF_FILE\
	                                 -i stage-0.vcf_index=$VCF_IDX\
                                         -i stage-0.bed_file=$BED_FILE\
                                         -i stage-0.bam_file=$BAM_FILE\
                                         -i stage-0.bam_idx=$BAM_IDX\
                                         -i stage-0.ctg_list=$CTG_LIST\
                                         -i stage-0.ref_file=$REF_FILE\
                                         --destination $OUTPUT_DIR 
