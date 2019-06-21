class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk__apply_b_q_s_r
baseCommand:
  - gatk
  - ApplyBQSR
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
  - id: recal_data_table
    type: File
    inputBinding:
      position: 5
      prefix: '-bqsr'
  - id: bed_file
    type: File
    inputBinding:
      position: 11
      prefix: '-L'
outputs:
  - id: output_bqsr_bam
    type: File
    outputBinding:
      glob: $(inputs.bam_dedup_RG.nameroot).BQSR.bam
label: gatk_ApplyBQSR
arguments:
  - position: 7
    prefix: '-O'
    valueFrom: $(inputs.bam_dedup_RG.nameroot).BQSR.bam
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
