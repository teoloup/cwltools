class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: picard_markduplicates
baseCommand:
  - gatk
  - MarkDuplicates
inputs:
  - id: sorted_bam
    type: File
    inputBinding:
      position: 2
      prefix: '-I'
outputs:
  - id: dedup_bam
    type: File
    outputBinding:
      glob: $(inputs.sorted_bam.nameroot).dedup.bam
  - id: metrics
    type: File
    outputBinding:
      glob: $(inputs.sorted_bam.nameroot).dedup.bam.metrics
label: picard_MarkDuplicates
arguments:
  - position: 0
    prefix: '--REMOVE_DUPLICATES'
    valueFrom: 'true'
  - position: 1
    prefix: '--ASSUME_SORTED'
    valueFrom: 'true'
  - position: 3
    prefix: '-O'
    valueFrom: $(inputs.sorted_bam.nameroot).dedup.bam
  - position: 4
    prefix: '-M'
    valueFrom: $(inputs.sorted_bam.nameroot).dedup.bam.metrics
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
