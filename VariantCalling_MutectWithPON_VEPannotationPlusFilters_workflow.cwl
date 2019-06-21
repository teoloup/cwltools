class: Workflow
cwlVersion: v1.0
id: _variant_calling__mutect_with_p_o_n__v_e_pannotation_plus_filters_workflow
label: VariantCalling_MutectWithPON_VEPannotationPlusFilters_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: ref_seq
    type: File
    'sbg:x': 0
    'sbg:y': 320.203125
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 747.140625
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 853.875
  - id: sam_name
    type: string
    'sbg:x': 0
    'sbg:y': 213.46875
  - id: Sample
    type: string
    'sbg:x': 0
    'sbg:y': 106.734375
  - id: Platform
    type: string
    'sbg:x': 0
    'sbg:y': 533.671875
  - id: Library
    type: string
    'sbg:x': 848.5399169921875
    'sbg:y': 426.9375
  - id: Barcode
    type: string
    'sbg:x': 848.5399169921875
    'sbg:y': 533.671875
  - id: bed_file
    type: File
    'sbg:x': 1076.51953125
    'sbg:y': 587.0390625
  - id: PoN_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 426.9375
  - id: gnomad_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 640.40625
  - id: dbSNP_vcf
    type: File
    'sbg:x': 1076.51953125
    'sbg:y': 480.3046875
  - id: filter_parameter
    type: string
    'sbg:x': 988.4285278320312
    'sbg:y': 993.9906005859375
  - id: filter_name
    type: string
    'sbg:x': 1109.7763671875
    'sbg:y': 1149.7940673828125
  - id: VEP_cache_path
    type: Directory
    'sbg:x': 2399.658935546875
    'sbg:y': 583.5046997070312
  - id: plugins_path
    type: Directory?
    'sbg:x': 2300.782958984375
    'sbg:y': 159.53648376464844
  - id: plugin_name
    type: string?
    'sbg:x': 2491.044189453125
    'sbg:y': 809.720947265625
  - id: string_of_filters
    type: string
    'sbg:x': 2768.196533203125
    'sbg:y': 501.1080322265625
outputs:
  - id: plots_pdf
    outputSource:
      - gatk_analyzecovariates/plots_pdf
    type: File
    'sbg:x': 1944.0985107421875
    'sbg:y': 150.46875
  - id: metrics
    outputSource:
      - picard_markduplicates/metrics
    type: File
    'sbg:x': 1076.51953125
    'sbg:y': 373.5703125
  - id: output_vcf
    outputSource:
      - vep_filter/output_vcf
    type: File
    'sbg:x': 3085.798095703125
    'sbg:y': 361.7828063964844
  - id: output_vcf_1
    outputSource:
      - vep_filter_1/output_vcf
    type: File
    'sbg:x': 3102.277587890625
    'sbg:y': 608.9727172851562
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
    'sbg:x': 187.59375
    'sbg:y': 480.3046875
  - id: fastqc
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out: []
    run: fastqc.cwl
    label: fastQc
    'sbg:x': 187.59375
    'sbg:y': 345.5703125
  - id: samtools_view
    in:
      - id: aligned_sam
        source: bwa_mem_0_7_15/output_sam
    out:
      - id: aligned_bam
    run: samtools_view.cwl
    label: samtools_view
    'sbg:x': 427.6961669921875
    'sbg:y': 426.9375
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view/aligned_bam
    out:
      - id: sorted
    run: samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 655.0242919921875
    'sbg:y': 426.9375
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
    'sbg:x': 1076.51953125
    'sbg:y': 238.8359375
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups/dedup_RG_bam
    out: []
    run: samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1392.781494140625
    'sbg:y': 352.5703125
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
    'sbg:x': 1632.2432861328125
    'sbg:y': 345.5703125
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
    'sbg:x': 1944.0985107421875
    'sbg:y': 299.203125
  - id: picard_markduplicates
    in:
      - id: sorted_bam
        source: samtools_sort/sorted
    out:
      - id: dedup_bam
      - id: metrics
    run: ./picard_markduplicates.cwl
    label: picard_MarkDuplicates
    'sbg:x': 848.5399169921875
    'sbg:y': 313.203125
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
    'sbg:x': 1392.781494140625
    'sbg:y': 480.3046875
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
    'sbg:x': 1944.0985107421875
    'sbg:y': 468.9375
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
    'sbg:x': 1632.2432861328125
    'sbg:y': 480.3046875
  - id: gatk_4_0_9_0_variantfiltration__i_n_f_o
    in:
      - id: reference
        source: ref_seq
      - id: vcf
        source: gatk_mutect2_tumoronly_with__po_n/vcf
      - id: filter_parameter
        source: filter_parameter
      - id: filter_name
        source: filter_name
    out:
      - id: filter_vcf
    run: ./gatk_4-0-9-0_variantfiltration_INFO.cwl
    label: gatk_4.0.9.0_VariantFiltration_INFO
    'sbg:x': 2199.16015625
    'sbg:y': 486.5825500488281
  - id: gatk_4_0_9_0_selectvariants_1
    in:
      - id: ref_file
        source: ref_seq
      - id: input_vcf_with_filters
        source: gatk_4_0_9_0_variantfiltration__i_n_f_o/filter_vcf
    out:
      - id: output_vcf
    run: ./gatk_4-0-9-0_selectvariants.cwl
    label: gatk_4.0.9.0_SelectVariants
    'sbg:x': 2364.154052734375
    'sbg:y': 297.9002685546875
  - id: vep_annotation
    in:
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: vcf_file
        source: gatk_4_0_9_0_selectvariants_1/output_vcf
      - id: plugin_name
        source: plugin_name
      - id: plugins_path
        source: plugins_path
      - id: output_type
        default: tab
    out:
      - id: output
    run: ./vep_annotation.cwl
    label: VEP_annotation
    'sbg:x': 2564.45166015625
    'sbg:y': 167.02684020996094
  - id: vep_annotation_1
    in:
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: vcf_file
        source: gatk_4_0_9_0_selectvariants_1/output_vcf
      - id: plugin_name
        source: plugin_name
      - id: plugins_path
        source: plugins_path
      - id: output_type
        default: vcf
    out:
      - id: output
    run: ./vep_annotation.cwl
    label: VEP_annotation
    'sbg:x': 2577.935302734375
    'sbg:y': 405.2283020019531
  - id: vep_filter
    in:
      - id: input_vcf
        source: vep_annotation/output
      - id: string_of_filters
        source: string_of_filters
    out:
      - id: output_vcf
    run: ./vep_filter.cwl
    label: VEP_filter
    'sbg:x': 2868.57080078125
    'sbg:y': 342.3072204589844
  - id: vep_filter_1
    in:
      - id: input_vcf
        source: vep_annotation_1/output
      - id: string_of_filters
        source: string_of_filters
    out:
      - id: output_vcf
    run: ./vep_filter.cwl
    label: VEP_filter
    'sbg:x': 2895.536865234375
    'sbg:y': 626.9501953125
requirements: []
