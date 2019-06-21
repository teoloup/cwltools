class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: fastqc
baseCommand:
  - fastqc
inputs:
  - id: fastq1
    type: File
    inputBinding:
      position: 0
  - id: fastq2
    type: File
    inputBinding:
      position: 0
outputs: []
label: fastQc
requirements:
  - class: DockerRequirement
    dockerPull: 'maxulysse/fastqc:latest'
