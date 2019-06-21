class: Workflow
cwlVersion: v1.0
id: bqsr_mutect2_filtermutectcalls
label: BQSR_Mutect2_filterMutectCalls
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: bam_dedup_RG
    type: File
    'sbg:x': 0
    'sbg:y': 639.78125
  - id: bed_file
    type: File
    'sbg:x': 0
    'sbg:y': 533.171875
  - id: dbSNP_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 426.5625
  - id: ref_file
    type: File
    'sbg:x': 0
    'sbg:y': 106.609375
  - id: sample_name
    type: string
    'sbg:x': 0
    'sbg:y': 0
  - id: PoN_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 213.21875
  - id: gnomad_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 319.890625
outputs:
  - id: plots_pdf
    outputSource:
      - gatk_analyzecovariates/plots_pdf
    type: File
    'sbg:x': 731.8327026367188
    'sbg:y': 157.15625
  - id: filtered_vcf
    outputSource:
      - gatk_filtermutectcalls/filtered_vcf
    type: File
    'sbg:x': 1243.234375
    'sbg:y': 319.890625
steps:
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
    'sbg:x': 419.9774169921875
    'sbg:y': 238.4609375
  - id: gatk_bqsr_table_create
    in:
      - id: bam_dedup_RG
        source: bam_dedup_RG
      - id: ref_file
        source: ref_file
      - id: dbSNP_vcf
        source: dbSNP_vcf
      - id: bed_file
        source: bed_file
    out:
      - id: output
    run: ./gatk_bqsr_table_create.cwl
    label: gatk_BQSR_table_create
    'sbg:x': 180.515625
    'sbg:y': 298.828125
  - id: gatk__apply_b_q_s_r
    in:
      - id: bam_dedup_RG
        source: bam_dedup_RG
      - id: ref_file
        source: ref_file
      - id: recal_data_table
        source: gatk_bqsr_table_create/output
      - id: bed_file
        source: bed_file
    out:
      - id: output_bqsr_bam
    run: ./gatk_ApplyBQSR.cwl
    label: gatk_ApplyBQSR
    'sbg:x': 419.9774169921875
    'sbg:y': 373.1953125
  - id: gatk_bqsr_table_create_1
    in:
      - id: bam_dedup_RG
        source: gatk__apply_b_q_s_r/output_bqsr_bam
      - id: ref_file
        source: ref_file
      - id: dbSNP_vcf
        source: dbSNP_vcf
      - id: bed_file
        source: bed_file
    out:
      - id: output
    run: ./gatk_bqsr_table_create.cwl
    label: gatk_BQSR_table_create
    'sbg:x': 731.8327026367188
    'sbg:y': 461.5625
  - id: gatk_mutect2_tumoronly_with__po_n
    in:
      - id: ref_fasta
        source: ref_file
      - id: BQSR2_bam
        source: gatk__apply_b_q_s_r/output_bqsr_bam
      - id: bed_file
        source: bed_file
      - id: sample_name
        source: sample_name
      - id: gnomad_vcf
        source: gnomad_vcf
      - id: PoN_vcf
        source: PoN_vcf
    out:
      - id: vcf
      - id: f1r2
    run: ./gatk_mutect2_tumoronly_with_PoN.cwl
    label: gatk_Mutect2_tumorOnly_with_PoN
    'sbg:x': 694.9702758789062
    'sbg:y': 319.166015625
  - id: gatk_learnreadorientationmodel
    in:
      - id: f1r2
        source: gatk_mutect2_tumoronly_with__po_n/f1r2
    out:
      - id: orientation_model
    run: ./gatk_learnreadorientationmodel.cwl
    label: gatk_LearnReadOrientationModel
    'sbg:x': 980.4888305664062
    'sbg:y': 252.4609375
  - id: gatk_filtermutectcalls
    in:
      - id: ref_file
        source: ref_file
      - id: vcf_file
        source: gatk_mutect2_tumoronly_with__po_n/vcf
      - id: orientation_model
        source: gatk_learnreadorientationmodel/orientation_model
    out:
      - id: filtered_vcf
    run: ./gatk_filtermutectcalls.cwl
    label: gatk_FilterMutectCalls
    'sbg:x': 980.4888305664062
    'sbg:y': 373.1953125
requirements: []
