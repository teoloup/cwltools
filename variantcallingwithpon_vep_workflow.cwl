class: Workflow
cwlVersion: v1.0
id: variantcallingwithpon_vep_workflow
label: VariantCallingWithPON_VEP_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: vcf_name
    type: string
    'sbg:x': -464.39886474609375
    'sbg:y': -221.5
  - id: sample_name
    type: string
    'sbg:x': -544.3988647460938
    'sbg:y': -106.5
  - id: ref_fasta
    type: File
    'sbg:x': -599.3988647460938
    'sbg:y': 29.5
  - id: PoN_vcf
    type: File
    'sbg:x': -547.3988647460938
    'sbg:y': 184.5
  - id: gnomad_vcf
    type: File
    'sbg:x': -404.39886474609375
    'sbg:y': 271.5
  - id: BQSR2_bam
    type: File
    'sbg:x': -197.39886474609375
    'sbg:y': 317.5
  - id: bed_file
    type: File
    'sbg:x': 29.60113525390625
    'sbg:y': 272.5
  - id: VEP_cache_path
    type: Directory
    'sbg:x': 226.60113525390625
    'sbg:y': -329.5
  - id: string_of_filters
    type: string
    'sbg:x': -80.39886474609375
    'sbg:y': -292.5
  - id: plugins_path
    type: Directory?
    'sbg:x': -149.39886474609375
    'sbg:y': -162.5
  - id: plugin_name
    type: string?
    'sbg:x': -31.39886474609375
    'sbg:y': 62.5
  - id: filter_parameter
    type: string
    'sbg:x': 249.60113525390625
    'sbg:y': 275.5
  - id: filter_name
    type: string
    'sbg:x': 372.60113525390625
    'sbg:y': 149.5
  - id: output_type_1
    type: string
    'sbg:x': -10.3963623046875
    'sbg:y': 487.4938659667969
  - id: output_type
    type: string
    'sbg:x': 234.6036376953125
    'sbg:y': 464.4938659667969
outputs:
  - id: output_vcf
    outputSource:
      - _v_e_pannotation_plus_filters_workflow/output_vcf
    type: File
    'sbg:x': 430.60113525390625
    'sbg:y': 32.5
  - id: output_vcf_1
    outputSource:
      - _v_e_pannotation_plus_filters_workflow/output_vcf_1
    type: File
    'sbg:x': 395.60113525390625
    'sbg:y': -123.5
steps:
  - id: gatk_mutect2_tumoronly_with__po_n
    in:
      - id: ref_fasta
        source: ref_fasta
      - id: BQSR2_bam
        source: BQSR2_bam
      - id: vcf_name
        source: vcf_name
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
    run: ./gatk_mutect2_tumoronly_with_PoN.cwl
    label: gatk_Mutect2_tumorOnly_with_PoN
    'sbg:x': -339.3984375
    'sbg:y': -41.5
  - id: _v_e_pannotation_plus_filters_workflow
    in:
      - id: filter_name
        source: filter_name
      - id: filter_parameter
        source: filter_parameter
      - id: reference
        source: ref_fasta
      - id: vcf
        source: gatk_mutect2_tumoronly_with__po_n/vcf
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: plugins_path
        source: plugins_path
      - id: plugin_name
        source: plugin_name
      - id: string_of_filters
        source: string_of_filters
      - id: output_type
        source: output_type
      - id: output_type_1
        source: output_type_1
    out:
      - id: output_vcf
      - id: output_vcf_1
    run: ./VEPannotationPlusFilters_workflow.cwl
    label: VEPannotationPlusFilters_workflow
    'sbg:x': 237.60113525390625
    'sbg:y': -21.5
requirements:
  - class: SubworkflowFeatureRequirement
