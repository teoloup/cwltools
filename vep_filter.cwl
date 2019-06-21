class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: vep_filter
baseCommand:
  - filter_vep
inputs:
  - id: input_vcf
    type: File
    inputBinding:
      position: 0
      prefix: '--input_file'
  - id: string_of_filters
    type: string
    inputBinding:
      position: 2
      prefix: '--filter'
outputs:
  - id: output_vcf
    type: File
    outputBinding:
      glob: $(inputs.input_vcf.nameroot)_filtered.vcf
label: VEP_filter
arguments:
  - position: 1
    prefix: '--output_file'
    valueFrom: $(inputs.input_vcf.nameroot)_filtered.vcf
requirements:
  - class: DockerRequirement
    dockerPull: 'ensemblorg/ensembl-vep:latest'
  - class: InlineJavascriptRequirement
