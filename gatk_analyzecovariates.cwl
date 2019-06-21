class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_analyzecovariates
baseCommand:
  - gatk
  - AnalyzeCovariates
inputs:
  - id: recal_table
    type: File
    inputBinding:
      position: 3
      prefix: '-before'
  - id: post_recal_table
    type: File
    inputBinding:
      position: 5
      prefix: '-after'
outputs:
  - id: plots_pdf
    type: File
    outputBinding:
      glob: $*.pdf
label: gatk_AnalyzeCovariates
arguments:
  - position: 6
    prefix: '-plots'
    valueFrom: $(inputs.recal_table.nameroot).plots.pdf
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
