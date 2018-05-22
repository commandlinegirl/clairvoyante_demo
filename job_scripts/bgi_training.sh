WORKDIR=/BGI_SEQ_NA12878_training_results
dx run applets/cv_training -i tensor_combine_bin=$WORKDIR/tensor_combined.bin --instance-type mem3_ssd1_gpu_x8 --destination $WORKDIR/
