class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_4_0_9_0_selectvariants
baseCommand:
  - gatk
  - SelectVariants
inputs:
  - id: ref_file
    type: File
    inputBinding:
      position: 0
      prefix: '-R'
  - id: input_vcf_with_filters
    type: File
    inputBinding:
      position: 0
      prefix: '-V'
outputs:
  - id: output_vcf
    type: File
    outputBinding:
      glob: $(inputs.input_vcf_with_filters.nameroot)_PassOnly.vcf
doc: selects only PASS variants
label: gatk_4.0.9.0_SelectVariants
arguments:
  - position: 0
    prefix: '-'
    separate: false
    valueFrom: '-exclude-filtered'
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.input_vcf_with_filters.nameroot)_PassOnly.vcf
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.0.9.0'
  - class: InlineJavascriptRequirement
