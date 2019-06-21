class: Workflow
cwlVersion: v1.0
id: _variant_calling__mutect_with_p_o_n_workflow
label: VariantCalling_MutectWithPON_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: ref_seq
    type: File
    'sbg:x': 0
    'sbg:y': 213.1875
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 639.703125
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 746.296875
  - id: sam_name
    type: string
    'sbg:x': 0
    'sbg:y': 106.59375
  - id: Sample
    type: string
    'sbg:x': 0
    'sbg:y': 0
  - id: Platform
    type: string
    'sbg:x': 0
    'sbg:y': 426.375
  - id: Library
    type: string
    'sbg:x': 809.0867919921875
    'sbg:y': 373.1484375
  - id: Barcode
    type: string
    'sbg:x': 809.0867919921875
    'sbg:y': 479.8125
  - id: bed_file
    type: File
    'sbg:x': 1037.06640625
    'sbg:y': 533.0390625
  - id: PoN_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 319.78125
  - id: gnomad_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 533.0390625
  - id: dbSNP_vcf
    type: File
    'sbg:x': 1037.06640625
    'sbg:y': 426.4453125
outputs:
  - id: plots_pdf
    outputSource:
      - gatk_analyzecovariates/plots_pdf
    type: File
    'sbg:x': 1904.6453857421875
    'sbg:y': 203.4140625
  - id: vcf
    outputSource:
      - gatk_mutect2_tumoronly_with__po_n/vcf
    type: File
    'sbg:x': 2158.0673828125
    'sbg:y': 373.1484375
  - id: metrics
    outputSource:
      - picard_markduplicates/metrics
    type: File
    'sbg:x': 1037.06640625
    'sbg:y': 319.8515625
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
    'sbg:x': 148.140625
    'sbg:y': 426.4453125
  - id: fastqc
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out: []
    run: fastqc.cwl
    label: fastQc
    'sbg:x': 148.140625
    'sbg:y': 291.8515625
  - id: samtools_view
    in:
      - id: aligned_sam
        source: bwa_mem_0_7_15/output_sam
    out:
      - id: aligned_bam
    run: samtools_view.cwl
    label: samtools_view
    'sbg:x': 388.2430419921875
    'sbg:y': 373.1484375
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view/aligned_bam
    out:
      - id: sorted
    run: samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 615.5711669921875
    'sbg:y': 373.1484375
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups_1/dedup_RG_bam
    out: []
    run: samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1353.328369140625
    'sbg:y': 298.78125
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
    'sbg:x': 1592.7901611328125
    'sbg:y': 291.7109375
  - id: gatk_mutect2_tumoronly_with__po_n
    in:
      - id: ref_fasta
        source: ref_seq
      - id: BQSR2_bam
        source: gatk__apply_b_q_s_r/output_bqsr_bam
      - id: vcf_name
        source: Sample
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
    run: gatk_mutect2_tumoronly_with_PoN.cwl
    label: gatk_Mutect2_tumorOnly_with_PoN
    'sbg:x': 1904.6453857421875
    'sbg:y': 352.078125
  - id: picard_addorreplacereadgroups_1
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
    run: ./picard_addorreplacereadgroups.cwl
    label: picard_AddOrReplaceReadGroups
    'sbg:x': 1037.06640625
    'sbg:y': 185.2578125
  - id: picard_markduplicates
    in:
      - id: sorted_bam
        source: samtools_sort/sorted
    out:
      - id: dedup_bam
      - id: metrics
    run: ./picard_markduplicates.cwl
    label: picard_MarkDuplicates
    'sbg:x': 809.0867919921875
    'sbg:y': 259.484375
  - id: gatk_bqsr_table_create
    in:
      - id: bam_dedup_RG
        source: picard_addorreplacereadgroups_1/dedup_RG_bam
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
    'sbg:x': 1353.328369140625
    'sbg:y': 426.4453125
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
    'sbg:x': 1904.6453857421875
    'sbg:y': 521.8125
  - id: gatk__apply_b_q_s_r
    in:
      - id: bam_dedup_RG
        source: picard_addorreplacereadgroups_1/dedup_RG_bam
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
    'sbg:x': 1592.7901611328125
    'sbg:y': 426.4453125
requirements: []
