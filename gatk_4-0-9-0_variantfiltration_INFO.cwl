class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_4_0_9_0_variantfiltration__i_n_f_o
baseCommand:
  - gatk
  - VariantFiltration
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '-R'
  - id: vcf
    type: File
    inputBinding:
      position: 0
      prefix: '-V'
  - id: filter_parameter
    type: string
    inputBinding:
      position: 0
      prefix: '--filter-expression'
  - id: filter_name
    type: string
    inputBinding:
      position: 0
      prefix: '--filter-name'
outputs:
  - id: filter_vcf
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot)_filtered.vcf
label: gatk_4.0.9.0_VariantFiltration_INFO
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.vcf.nameroot)_filtered.vcf
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.0.9.0'
  - class: InlineJavascriptRequirement
