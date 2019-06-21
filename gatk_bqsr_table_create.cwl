class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_bqsr_table_create
baseCommand:
  - gatk
  - BaseRecalibrator
inputs:
  - id: bam_dedup_RG
    type: File
    inputBinding:
      position: 1
      prefix: '-I'
  - id: ref_file
    type: File
    inputBinding:
      position: 3
      prefix: '-R'
  - id: dbSNP_vcf
    type: File
    inputBinding:
      position: 5
      prefix: '--known-sites'
  - id: bed_file
    type: File
    inputBinding:
      position: 11
      prefix: '-L'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.bam_dedup_RG.nameroot).rgb
label: gatk_BQSR_table_create
arguments:
  - position: 7
    prefix: '-O'
    valueFrom: $(inputs.bam_dedup_RG.nameroot).rgb
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
