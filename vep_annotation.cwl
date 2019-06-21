class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: vep_annotation
baseCommand:
  - vep
inputs:
  - id: VEP_cache_path
    type: Directory
    inputBinding:
      position: 0
      prefix: '--dir'
  - id: vcf_file
    type: File
    inputBinding:
      position: 1
      prefix: '--input_file'
  - id: plugin_name
    type: string?
    inputBinding:
      position: 5
      prefix: '--plugin'
  - id: plugins_path
    type: Directory?
    inputBinding:
      position: 0
      prefix: '--dir_plugins'
  - id: output_type
    type: string
    inputBinding:
      position: 0
      prefix: '--'
      separate: false
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.vcf_file.nameroot)_VEPann.vcf
label: VEP_annotation
arguments:
  - position: 0
    prefix: '-'
    separate: false
    valueFrom: '-offline'
  - position: 0
    prefix: '-'
    separate: false
    valueFrom: '-symbol'
  - position: 0
    prefix: '-'
    separate: false
    valueFrom: '-pick'
  - position: 0
    prefix: '-'
    separate: false
    valueFrom: '-canonical'
  - position: 0
    prefix: '-'
    separate: false
    valueFrom: '-everything'
  - position: 0
    prefix: '--format'
    valueFrom: vcf
  - position: 2
    prefix: '--output_file'
    valueFrom: $(inputs.vcf_file.nameroot)_VEPann.vcf
requirements:
  - class: DockerRequirement
    dockerPull: 'ensemblorg/ensembl-vep:latest'
  - class: InlineJavascriptRequirement
