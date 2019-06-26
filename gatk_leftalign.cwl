class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_leftalign
baseCommand:
  - gatk
  - LeftAlignAndTrimVariants
inputs:
  - id: ref_file
    type: File
    inputBinding:
      position: 0
      prefix: '-R'
  - id: vcf_input
    type: File
    inputBinding:
      position: 0
      prefix: '-V'
outputs:
  - id: leftAligned_vcf
    type: File
    outputBinding:
      glob: $(inputs.vcf_input.nameroot)_leftAligned.vcf
label: gatk_LeftAlign
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.vcf_input.nameroot)_leftAligned.vcf
  - position: 0
    prefix: ''
    valueFrom: '--split-multi-allelics'
  - position: 0
    prefix: ''
    valueFrom: '--keep-original-ac'
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
