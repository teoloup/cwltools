class: Workflow
cwlVersion: v1.0
id: myfilter_vepannotation
label: MyFilter_VEPannotation
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: vcf
    type: File
    'sbg:x': 0
    'sbg:y': 121.125
  - id: Depth
    type: string
    'sbg:x': 0
    'sbg:y': 228.25
  - id: AF
    type: string
    'sbg:x': 0
    'sbg:y': 335.375
  - id: VEP_cache_path
    type: Directory
    'sbg:x': 0
    'sbg:y': 14
  - id: plugins_path
    type: Directory?
    'sbg:x': 187.625
    'sbg:y': 0
  - id: plugin_name
    type: string?
    'sbg:x': 187.625
    'sbg:y': 107.125
  - id: output_type
    type: string
    'sbg:x': 187.625
    'sbg:y': 214.25
outputs:
  - id: output
    outputSource:
      - vep_annotation/output
    type: File
    'sbg:x': 663.9738159179688
    'sbg:y': 122.02884674072266
steps:
  - id: myfiltervcf
    in:
      - id: vcf
        source: vcf
      - id: Depth
        source: Depth
      - id: AF
        source: AF
    out:
      - id: vcf_applied_filters
    run: ./myfiltervcf.cwl
    label: myFilterVcf
    'sbg:x': 187.625
    'sbg:y': 335.375
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
    'sbg:x': 434.484375
    'sbg:y': 146.6875
requirements: []
