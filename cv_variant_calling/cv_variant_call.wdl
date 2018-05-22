task cv_variant_call {

  File model_tar_ball

  File ref_file
  File bam_file
  File bam_idx
  String sample_name
  String model_prefix
  Float threshold

  command <<<
    sudo apt-update
    sudo apt-get install -qqy parallel
    gunzip -dc ${ref_file} > ref.fa
    samtools faidx ref.fa

    tar zxvf ${model_tar_ball}
    mkdir -p out_vcf
    python /opt/Clairvoyante/clairvoyante/callVarBamParallel.py \
       	   --chkpnt_fn models/${model_prefix} \
	   --ref_fn ref.fa \
	   --bam_fn ${bam_file} \
	   --sampleName ${sample_name} \
	   --output_prefix out_vcf/cv_out \
	   --tensorflowThreads 4 \
	   --threshold ${threshold} \
           --minCoverage 4 \
	   --refChunkSize 10000000  > run_all.sh
    cat run_all.sh | parallel -j 24
    # export PATH=/opt/vcflib/bin:$PATH
    # vcfcat out_vcf/cv_out*.vcf | vcfstreamsort | bgziptabix cv_call_output_${sample_name}.vcf.gz # some out of order making bgziptabix failing
    tar czvf cv_all_output_${sample_name}.tar.gz out_vcf/cv_out*.vcf
  >>> 

  runtime {
    docker: "cschin/cv-worker"
    dx_instance_type: "mem3_ssd1_x32"
  }

  output {
    # File vcf_files = "cv_call_output_${sample_name}.vcf.gz"
    File vcf_files = "cv_all_output_${sample_name}.tar.gz"
  }
}
