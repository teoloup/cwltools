class: Workflow
cwlVersion: v1.0
id: variantcalling_mutectnopon_workflow
label: VariantCalling_MutectNoPON_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: ref_seq
    type: File
    'sbg:x': 0
    'sbg:y': 319.734375
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 532.734375
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 639.3125
  - id: sam_name
    type: string
    'sbg:x': 0
    'sbg:y': 213.15625
  - id: Sample
    type: string
    'sbg:x': 0
    'sbg:y': 106.578125
  - id: Platform
    type: string
    'sbg:x': 0
    'sbg:y': 426.234375
  - id: Library
    type: string
    'sbg:x': 802.8211669921875
    'sbg:y': 319.734375
  - id: Barcode
    type: string
    'sbg:x': 802.8211669921875
    'sbg:y': 426.3125
  - id: bed_file
    type: File
    'sbg:x': 1030.80078125
    'sbg:y': 479.4453125
  - id: dbSNP_vcf
    type: File
    'sbg:x': 1030.80078125
    'sbg:y': 372.8671875
  - id: vcf_name
    type: string
    'sbg:x': 0
    'sbg:y': 0
outputs:
  - id: plots_pdf
    outputSource:
      - gatk_analyzecovariates/plots_pdf
    type: File
    'sbg:x': 1898.379638671875
    'sbg:y': 372.9453125
  - id: metrics
    outputSource:
      - picard_markduplicates/metrics
    type: File
    'sbg:x': 1030.80078125
    'sbg:y': 266.3671875
  - id: vcf
    outputSource:
      - gatk_mutect2_tumoronly/vcf
    type: File
    'sbg:x': 1898.379638671875
    'sbg:y': 266.4453125
steps:
  - id: bwa_mem_0_7_15
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
      - id: ref_seq
        source: ref_seq
      - id: sam_name
        source: sam_name
    out:
      - id: output_sam
    run: bwa_mem.cwl
    label: bwa mem v0.7.5
    'sbg:x': 141.875
    'sbg:y': 372.9453125
  - id: fastqc
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out: []
    run: fastqc.cwl
    label: fastQc
    'sbg:x': 141.875
    'sbg:y': 238.5234375
  - id: samtools_view
    in:
      - id: aligned_sam
        source: bwa_mem_0_7_15/output_sam
    out:
      - id: aligned_bam
    run: samtools_view.cwl
    label: samtools_view
    'sbg:x': 408.2074279785156
    'sbg:y': 549.356201171875
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view/aligned_bam
    out:
      - id: sorted
    run: samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 585.4202270507812
    'sbg:y': 587.4465942382812
  - id: picard_addorreplacereadgroups
    in:
      - id: sorted_dedup_bam
        source: picard_markduplicates/dedup_bam
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
    run: picard_addorreplacereadgroups.cwl
    label: picard_AddOrReplaceReadGroups
    'sbg:x': 988.2819213867188
    'sbg:y': -81.21793365478516
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups/dedup_RG_bam
    out: []
    run: samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1347.062744140625
    'sbg:y': 170.921875
  - id: gatk_analyzecovariates
    in:
      - id: recal_table
        source: gatk_bqsr_table_create/output
      - id: post_recal_table
        source: gatk_bqsr_table_create_1/output
    out:
      - id: plots_pdf
    run: gatk_analyzecovariates.cwl
    label: gatk_AnalyzeCovariates
    'sbg:x': 1658.91796875
    'sbg:y': 447.3125
  - id: picard_markduplicates
    in:
      - id: sorted_bam
        source: samtools_sort/sorted
    out:
      - id: dedup_bam
      - id: metrics
    run: ./picard_markduplicates.cwl
    label: picard_MarkDuplicates
    'sbg:x': 802.8211669921875
    'sbg:y': 206.078125
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
    'sbg:x': 1347.062744140625
    'sbg:y': 298.578125
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
    'sbg:x': 1347.062744140625
    'sbg:y': 447.3125
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
    'sbg:x': 1658.91796875
    'sbg:y': 312.578125
  - id: gatk_mutect2_tumoronly
    in:
      - id: ref_fasta
        source: ref_seq
      - id: BQSR2_bam
        source: gatk__apply_b_q_s_r/output_bqsr_bam
      - id: vcf_name
        source: vcf_name
      - id: bed_file
        source: bed_file
      - id: sample_name
        source: Sample
    out:
      - id: vcf
    run: ./gatk_mutect2_tumoronly.cwl
    label: gatk_Mutect2_tumorOnly
    'sbg:x': 1658.91796875
    'sbg:y': 156.84375
requirements: []
