class: Workflow
cwlVersion: v1.0
id: full_workflow_notcompact
label: full_workflow_notcompact
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 856.125
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 963.140625
  - id: illumina_adapters_file
    type: File
    'sbg:x': 0
    'sbg:y': 642.09375
  - id: ref_seq
    type: File
    'sbg:x': 0
    'sbg:y': 321.046875
  - id: sam_name
    type: string
    'sbg:x': 0
    'sbg:y': 214.03125
  - id: Sample
    type: string
    'sbg:x': 0
    'sbg:y': 107.015625
  - id: Platform
    type: string
    'sbg:x': 0
    'sbg:y': 535.078125
  - id: Library
    type: string
    'sbg:x': 989.827880859375
    'sbg:y': 481.5703125
  - id: Barcode
    type: string
    'sbg:x': 989.827880859375
    'sbg:y': 588.5859375
  - id: bed_file
    type: File
    'sbg:x': 1183.343505859375
    'sbg:y': 588.5859375
  - id: dbSNP_vcf
    type: File
    'sbg:x': 1183.343505859375
    'sbg:y': 481.5703125
  - id: PoN_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 428.0625
  - id: gnomad_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 749.109375
  - id: Depth
    type: string
    'sbg:x': 2060.148193359375
    'sbg:y': 602.5859375
  - id: AF
    type: string
    'sbg:x': 2060.148193359375
    'sbg:y': 709.6015625
  - id: VEP_cache_path
    type: Directory
    'sbg:x': 0
    'sbg:y': 0
  - id: plugins_path
    type: Directory?
    'sbg:x': 2322.893798828125
    'sbg:y': 307.046875
  - id: plugin_name
    type: string?
    'sbg:x': 2322.893798828125
    'sbg:y': 414.0625
  - id: output_type
    type: string
    'sbg:x': 2322.893798828125
    'sbg:y': 521.078125
outputs:
  - id: r1_unpaired
    outputSource:
      - trimmomatic_nugen/r1_unpaired
    type: File
    'sbg:x': 522.3973388671875
    'sbg:y': 400.0625
  - id: r2_unpaired
    outputSource:
      - trimmomatic_nugen/r2_unpaired
    type: File
    'sbg:x': 522.3973388671875
    'sbg:y': 293.046875
  - id: plots_pdf
    outputSource:
      - gatk_analyzecovariates/plots_pdf
    type: File
    'sbg:x': 2060.148193359375
    'sbg:y': 253.5390625
  - id: output
    outputSource:
      - vep_annotation/output
    type: File
    'sbg:x': 2822.28076171875
    'sbg:y': 481.5703125
steps:
  - id: fastqc
    in:
      - id: fastq1
        source: trimmomatic_nugen/r1_paired
      - id: fastq2
        source: trimmomatic_nugen/r2_paired
    out: []
    run: ./fastqc.cwl
    label: fastQc
    'sbg:x': 522.3973388671875
    'sbg:y': 514.078125
  - id: bwa_mem_0_7_15
    in:
      - id: fastq1
        source: trimmomatic_nugen/r1_paired
      - id: fastq2
        source: trimmomatic_nugen/r2_paired
      - id: ref_seq
        source: ref_seq
      - id: sam_name
        source: sam_name
    out:
      - id: output_sam
    run: ./bwa_mem.cwl
    label: bwa mem v0.7.5
    'sbg:x': 522.3973388671875
    'sbg:y': 649.09375
  - id: trimmomatic_nugen
    in:
      - id: fastq1
        source: fastq1
      - id: illumina_adapters_file
        source: illumina_adapters_file
      - id: fastq2
        source: fastq2
    out:
      - id: r1_paired
      - id: r1_unpaired
      - id: r2_paired
      - id: r2_unpaired
    run: ./trimmomatic_nugen.cwl
    label: trimmomatic_NuGen
    'sbg:x': 223.015625
    'sbg:y': 400.0625
  - id: fastqc_1
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out: []
    run: ./fastqc.cwl
    label: fastQc
    'sbg:x': 223.015625
    'sbg:y': 535.078125
  - id: samtools_view
    in:
      - id: aligned_sam
        source: bwa_mem_0_7_15/output_sam
    out:
      - id: aligned_bam
    run: ./samtools_view.cwl
    label: samtools_view
    'sbg:x': 762.499755859375
    'sbg:y': 481.5703125
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view/aligned_bam
    out:
      - id: sorted
    run: ./samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 989.827880859375
    'sbg:y': 374.5546875
  - id: picard_addorreplacereadgroups
    in:
      - id: sorted_dedup_bam
        source: samtools_sort/sorted
      - id: Library
        source: Library
      - id: Platform
        source: Platform
      - id: Barcode
        source: Barcode
      - id: Sample
        source: Sample
    out:
      - id: dedup_RG_bam
    run: ./picard_addorreplacereadgroups.cwl
    label: picard_AddOrReplaceReadGroups
    'sbg:x': 1183.343505859375
    'sbg:y': 346.5546875
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups/dedup_RG_bam
    out: []
    run: ./samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1499.60546875
    'sbg:y': 332.5546875
  - id: gatk_bqsr_table_create
    in:
      - id: bam_dedup_RG
        source: picard_addorreplacereadgroups/dedup_RG_bam
      - id: ref_file
        source: ref_seq
      - id: dbSNP_vcf
        source: dbSNP_vcf
      - id: bed_file
        source: bed_file
    out:
      - id: output
    run: ./gatk_bqsr_table_create.cwl
    label: gatk_BQSR_table_create
    'sbg:x': 1499.60546875
    'sbg:y': 460.5703125
  - id: gatk__apply_b_q_s_r
    in:
      - id: bam_dedup_RG
        source: picard_addorreplacereadgroups/dedup_RG_bam
      - id: ref_file
        source: ref_seq
      - id: recal_data_table
        source: gatk_bqsr_table_create/output
      - id: bed_file
        source: bed_file
    out:
      - id: output_bqsr_bam
    run: ./gatk_ApplyBQSR.cwl
    label: gatk_ApplyBQSR
    'sbg:x': 1499.60546875
    'sbg:y': 609.5859375
  - id: gatk_bqsr_table_create_1
    in:
      - id: bam_dedup_RG
        source: gatk__apply_b_q_s_r/output_bqsr_bam
      - id: ref_file
        source: ref_seq
      - id: dbSNP_vcf
        source: dbSNP_vcf
      - id: bed_file
        source: bed_file
    out:
      - id: output
    run: ./gatk_bqsr_table_create.cwl
    label: gatk_BQSR_table_create
    'sbg:x': 1811.460693359375
    'sbg:y': 474.5703125
  - id: gatk_analyzecovariates
    in:
      - id: recal_table
        source: gatk_bqsr_table_create/output
      - id: post_recal_table
        source: gatk_bqsr_table_create_1/output
    out:
      - id: plots_pdf
    run: ./gatk_analyzecovariates.cwl
    label: gatk_AnalyzeCovariates
    'sbg:x': 1811.460693359375
    'sbg:y': 609.5859375
  - id: gatk_mutect2_tumoronly_with__po_n
    in:
      - id: ref_fasta
        source: ref_seq
      - id: BQSR2_bam
        source: gatk__apply_b_q_s_r/output_bqsr_bam
      - id: bed_file
        source: bed_file
      - id: sample_name
        source: Sample
      - id: gnomad_vcf
        source: gnomad_vcf
      - id: PoN_vcf
        source: PoN_vcf
    out:
      - id: vcf
      - id: f1r2
    run: ./gatk_mutect2_tumoronly_with_PoN.cwl
    label: gatk_Mutect2_tumorOnly_with_PoN
    'sbg:x': 1811.460693359375
    'sbg:y': 311.5546875
  - id: gatk_learnreadorientationmodel
    in:
      - id: f1r2
        source: gatk_mutect2_tumoronly_with__po_n/f1r2
    out:
      - id: orientation_model
    run: ./gatk_learnreadorientationmodel.cwl
    label: gatk_LearnReadOrientationModel
    'sbg:x': 2060.148193359375
    'sbg:y': 360.5546875
  - id: gatk_filtermutectcalls
    in:
      - id: ref_file
        source: ref_seq
      - id: vcf_file
        source: gatk_mutect2_tumoronly_with__po_n/vcf
      - id: orientation_model
        source: gatk_learnreadorientationmodel/orientation_model
    out:
      - id: filtered_vcf
    run: ./gatk_filtermutectcalls.cwl
    label: gatk_FilterMutectCalls
    'sbg:x': 2060.148193359375
    'sbg:y': 481.5703125
  - id: myfiltervcf
    in:
      - id: vcf
        source: gatk_leftalign/leftAligned_vcf
      - id: Depth
        source: Depth
      - id: AF
        source: AF
    out:
      - id: vcf_applied_filters
    run: ./myfiltervcf.cwl
    label: myFilterVcf
    'sbg:x': 2484.614013671875
    'sbg:y': 772.09130859375
  - id: vep_annotation
    in:
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: vcf_file
        source: myfiltervcf/vcf_applied_filters
      - id: plugin_name
        source: plugin_name
      - id: plugins_path
        source: plugins_path
      - id: output_type
        source: output_type
    out:
      - id: output
    run: ./vep_annotation.cwl
    label: VEP_annotation
    'sbg:x': 2569.753173828125
    'sbg:y': 453.5703125
  - id: gatk_leftalign
    in:
      - id: ref_file
        source: ref_seq
      - id: vcf_input
        source: gatk_filtermutectcalls/filtered_vcf
    out:
      - id: leftAligned_vcf
    run: ./gatk_leftalign.cwl
    label: gatk_LeftAlign
    'sbg:x': 2335.848388671875
    'sbg:y': 658.6332397460938
requirements: []
