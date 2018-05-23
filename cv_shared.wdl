
task trueset_vcf_processing {
  File vcf_file
  File vcf_index
  File bed_file

  command <<<

    gzip -dc ${vcf_file} | /opt/vcflib/bin/vcfbreakmulti | /opt/vcflib/bin/bgziptabix baseline.breakmulti.vcf.gz

    /opt/rtg-tools/rtg-tools-3.9-eda9a71/rtg vcffilter --include-bed=${bed_file}  -i baseline.breakmulti.vcf.gz -o baseline.breakmulti.inbed.vcf.gz

    gzip -dc baseline.breakmulti.inbed.vcf.gz | perl -ane 'if(/^#/){print}else{if(length($F[3])==1 && length($F[4])==1){print}elsif(length($F[3])==1 && length($F[4])<=5){print}elsif(length($F[3])<=5 && length($F[4])==1){print}}' | /opt/vcflib/bin/bgziptabix baseline.breakmulti.inbed.withOutSV.vcf.gz

    gzip -dc baseline.breakmulti.inbed.withOutSV.vcf.gz | perl -ane 'BEGIN{%a=();}{if(/^#/){print}elsif(not defined $a{"$F[0]-$F[1]"}){print;$a{"$F[0]-$F[1]"}=1;}}' | /opt/vcflib/bin/bgziptabix baseline.breakmulti.inbed.withOutSV.uniq.vcf.gz

    pigz -dc baseline.breakmulti.inbed.withOutSV.uniq.vcf.gz | perl -ane 'if(/^#/){print}else{@a=split ":",$F[-1];$a[0]=~s/\./0/;$a[0]=~s/\|/\//;@b=split "/",$a[0];if($b[0]>$b[1]){$a[0]="$b[1]/$b[0]"}else{$a[0]="$b[0]/$b[1]"};$F[-1]=join ":",@a; print join "\t", @F;print "\n";}' | /opt/vcflib/bin/bgziptabix baseline.breakmulti.inbed.withOutSV.uniq.normalizeGT.vcf.gz

  >>> 

  runtime {
    docker: "cschin/cv-worker"
  }

  output {
    File vcf_trimmed = "baseline.breakmulti.inbed.withOutSV.uniq.normalizeGT.vcf.gz"
    File vcf_trimmed_idx = "baseline.breakmulti.inbed.withOutSV.uniq.normalizeGT.vcf.gz.tbi"
  }
}



