import "cv_shared.wdl" as share
import "process_variant_call_tar_ball.wdl" as pvc 

workflow cv_happy_evaluate {

  File target_vcf_tar_ball
  File bed_file
  File ref_file
  File source_vcf_file
  File source_vcf_index

  call share.trueset_vcf_processing as trueset_vcf_processing {
    input: vcf_file = source_vcf_file, 
           vcf_index = source_vcf_index, 
           bed_file = bed_file
  }

  call pvc.process_variant_call_tar_ball as process_variant_call_tar_ball {
    input: target_vcf_tar_ball = target_vcf_tar_ball
  }

  call run_happy_vcfeval {
    input: bed_file = bed_file,
           ref_file = ref_file,
           trueset_vcf = trueset_vcf_processing.vcf_trimmed,
           trueset_vcf_idx = trueset_vcf_processing.vcf_trimmed_idx,
           target_vcf = process_variant_call_tar_ball.variant_vcf,
           target_vcf_idx = process_variant_call_tar_ball.variant_vcf_idx
  }
  
  output {
    File trueset_vcf = trueset_vcf_processing.vcf_trimmed
    File trueset_vcf_idx = trueset_vcf_processing.vcf_trimmed_idx
    File target_vcf = process_variant_call_tar_ball.variant_vcf
    File target_vcf_idx = process_variant_call_tar_ball.variant_vcf_idx
    File benchmarking_results_tgz = run_happy_vcfeval.benchmarking_results_tgz
  }
}

task run_happy_vcfeval {

  File bed_file
  File ref_file
  File trueset_vcf
  File trueset_vcf_idx
  File target_vcf
  File target_vcf_idx

  command <<<
     gunzip -dc ${ref_file} > ref.fa 
     RESULTS=hap_py_results
     mkdir -p $RESULTS/
     /opt/hap.py/bin/hap.py ${trueset_vcf} \
                            ${target_vcf} \
                            -f ${bed_file} \
                            -r ref.fa \
                            -o $RESULTS/ \
                            --engine=vcfeval
    tart czvf happy_benchmarking_results.tgz $RESULTS/

  >>> 

  runtime {
    docker: "pkrusche/hap.py"
	  dx_instance_type: "mem1_ssd1_x16"
  }

  output {
    File benchmarking_results_tgz = "happy_benchmarking_results.tgz"
  }
}
