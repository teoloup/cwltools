class: Workflow
cwlVersion: v1.0
id: full_workflow_notcompact
label: full_workflow_notcompact

inputs:
  - id: fastq2
    type: File

  - id: fastq1
    type: File

  - id: illumina_adapters_file
    type: File

  - id: ref_seq
    type: File

  - id: sam_name
    type: string

  - id: Sample
    type: string

  - id: Platform
    type: string

  - id: Library
    type: string

  - id: Barcode
    type: string

  - id: bed_file
    type: File

  - id: dbSNP_vcf
    type: File

  - id: PoN_vcf
    type: File

  - id: gnomad_vcf
    type: File

  - id: Depth
    type: string

  - id: AF
    type: string

  - id: VEP_cache_path
    type: Directory

  - id: plugins_path
    type: Directory?

  - id: plugin_name
    type: string?

  - id: output_type
    type: string

outputs:
  - id: r1_unpaired
    outputSource:
      - trimmomatic_nugen/r1_unpaired
    type: File

  - id: r2_unpaired
    outputSource:
      - trimmomatic_nugen/r2_unpaired
    type: File

  - id: plots_pdf
    outputSource:
      - gatk_analyzecovariates/plots_pdf
    type: File

  - id: output
    outputSource:
      - vep_annotation/output
    type: File

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

  - id: fastqc_1
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out: []
    run: ./fastqc.cwl
    label: fastQc

  - id: samtools_view
    in:
      - id: aligned_sam
        source: bwa_mem_0_7_15/output_sam
    out:
      - id: aligned_bam
    run: ./samtools_view.cwl
    label: samtools_view

  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view/aligned_bam
    out:
      - id: sorted
    run: ./samtools_sort.cwl
    label: samtools_sort

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

  - id: samtools_index_bam
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups/dedup_RG_bam
    out: []
    run: ./samtools_index_bam.cwl
    label: samtools_index_bam

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

  - id: gatk_learnreadorientationmodel
    in:
      - id: f1r2
        source: gatk_mutect2_tumoronly_with__po_n/f1r2
    out:
      - id: orientation_model
    run: ./gatk_learnreadorientationmodel.cwl
    label: gatk_LearnReadOrientationModel

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

  - id: myfiltervcf
    in:
      - id: vcf
        source: gatk_filtermutectcalls/filtered_vcf
      - id: Depth
        source: Depth
      - id: AF
        source: AF
    out:
      - id: vcf_applied_filters
    run: ./myfiltervcf.cwl
    label: myFilterVcf

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
  
requirements: []
