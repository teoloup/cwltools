class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: myfiltervcf
baseCommand:
  - perl
  - /opt/filter_vcf.pl
inputs:
  - id: vcf
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
  - id: Depth
    type: string
    inputBinding:
      position: 0
      prefix: '-D'
  - id: AF
    type: string
    inputBinding:
      position: 0
      prefix: '-A'
outputs:
  - id: vcf_applied_filters
    type: File?
    outputBinding:
      glob: $(inputs.vcf.nameroot)_finalVariants.vcf
label: myFilterVcf
arguments:
  - position: 0
    prefix: '-F'
    valueFrom: panel_of_normals
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.vcf.nameroot)_finalVariants.vcf
requirements:
  - class: DockerRequirement
    dockerPull: 'teoloup/myfiltervcf:latest'
  - class: InlineJavascriptRequirement
