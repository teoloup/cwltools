class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bwa_index
baseCommand:
  - bwa
  - index
inputs:
  - id: hg19_fasta
    type: File
    inputBinding:
      position: 0
outputs: []
label: bwa_index
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 0
  - class: DockerRequirement
    dockerPull: 'biocontainers/bwa:0.7.15'
stdout: STDOUT
