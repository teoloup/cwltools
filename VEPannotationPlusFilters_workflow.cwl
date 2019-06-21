class: Workflow
cwlVersion: v1.0
id: _v_e_pannotation_plus_filters_workflow
label: VEPannotationPlusFilters_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: filter_name
    type: string
    'sbg:x': 0
    'sbg:y': 427.125
  - id: filter_parameter
    type: string
    'sbg:x': 0
    'sbg:y': 320.34375
  - id: reference
    type: File
    'sbg:x': 0
    'sbg:y': 213.5625
  - id: vcf
    type: File
    'sbg:x': 0
    'sbg:y': 106.78125
  - id: VEP_cache_path
    type: Directory
    'sbg:x': 0
    'sbg:y': 0
  - id: plugins_path
    type: Directory?
    'sbg:x': 447.77716064453125
    'sbg:y': 99.78125
  - id: plugin_name
    type: string?
    'sbg:x': 447.77716064453125
    'sbg:y': 206.5625
  - id: string_of_filters
    type: string
    'sbg:x': 715.1630249023438
    'sbg:y': 341.34375
  - id: output_type
    type: string
    'sbg:x': 507.6015625
    'sbg:y': 552.5
  - id: output_type_1
    type: string
    'sbg:x': 565.6015625
    'sbg:y': -125.49243927001953
outputs:
  - id: output_vcf
    outputSource:
      - vep_filter_1/output_vcf
    type: File
    'sbg:x': 1197.3076171875
    'sbg:y': 266.953125
  - id: output_vcf_1
    outputSource:
      - vep_filter/output_vcf
    type: File
    'sbg:x': 1197.3076171875
    'sbg:y': 160.171875
steps:
  - id: gatk_4_0_9_0_variantfiltration__i_n_f_o
    in:
      - id: reference
        source: reference
      - id: vcf
        source: vcf
      - id: filter_parameter
        source: filter_parameter
      - id: filter_name
        source: filter_name
    out:
      - id: filter_vcf
    run: ./gatk_4-0-9-0_variantfiltration_INFO.cwl
    label: gatk_4.0.9.0_VariantFiltration_INFO
    'sbg:x': 255.28054809570312
    'sbg:y': 172.32594299316406
  - id: gatk_4_0_9_0_selectvariants
    in:
      - id: ref_file
        source: reference
      - id: input_vcf_with_filters
        source: gatk_4_0_9_0_variantfiltration__i_n_f_o/filter_vcf
    out:
      - id: output_vcf
    run: ./gatk_4-0-9-0_selectvariants.cwl
    label: gatk_4.0.9.0_SelectVariants
    'sbg:x': 447.77716064453125
    'sbg:y': 320.34375
  - id: vep_annotation
    in:
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: vcf_file
        source: gatk_4_0_9_0_selectvariants/output_vcf
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
    'sbg:x': 715.1630249023438
    'sbg:y': 213.5625
  - id: vep_annotation_1
    in:
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: vcf_file
        source: gatk_4_0_9_0_selectvariants/output_vcf
      - id: plugin_name
        source: plugin_name
      - id: plugins_path
        source: plugins_path
      - id: output_type
        source: output_type_1
    out:
      - id: output
    run: ./vep_annotation.cwl
    label: VEP_annotation
    'sbg:x': 715.1630249023438
    'sbg:y': 64.78125
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
    'sbg:x': 959.1873168945312
    'sbg:y': 266.953125
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
    'sbg:x': 959.1873168945312
    'sbg:y': 145.953125
requirements: []
