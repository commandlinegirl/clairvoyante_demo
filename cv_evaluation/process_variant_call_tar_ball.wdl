task process_variant_call_tar_ball {

  File target_vcf_tar_ball

  command <<<
    export PATH=/opt/vcflib/bin/:$PATH
    export PATH=/opt/rtg-tools/rtg-tools-3.9-eda9a71/:$PATH
 
    tar zxvf ${target_vcf_tar_ball}
     
    vcfcat out_vcf/cv_out.* | vcfstreamsort > tmp.vcf
    vcfsort tmp.vcf  > cv_variant_calls.vcf
    bgzip cv_variant_calls.vcf
    tabix -p vcf cv_variant_calls.vcf.gz 
    >>>

  runtime {
    docker: "cschin/cv-worker"
  }

  output {
    File variant_vcf = "cv_variant_calls.vcf.gz"
    File variant_vcf_idx = "cv_variant_calls.vcf.gz.tbi"
  }
}

