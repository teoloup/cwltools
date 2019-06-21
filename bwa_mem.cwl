class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bwa_mem_0_7_15
baseCommand:
  - bwa
  - mem
inputs:
  - id: fastq1
    type: File
    inputBinding:
      position: 2
    doc: fastq
  - id: fastq2
    type: File
    inputBinding:
      position: 3
    doc: optional second fastq file
  - id: ref_seq
    type: File
    inputBinding:
      position: 1
    doc: reference seq
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  - id: sam_name
    type: string
outputs:
  - id: output_sam
    doc: Alignments in SAM format
    type: File
    outputBinding:
      glob: $(inputs.sam_name)
doc: BwaMem
label: bwa mem v0.7.5
arguments:
  - position: 0
    prefix: ''
    valueFrom: '-M'
  - position: 0
    prefix: ''
    valueFrom: '-a'
  - position: 0
    prefix: '-v'
    valueFrom: '3'
  - position: 0
    prefix: '-t'
    valueFrom: '20'
  - position: 0
    prefix: '-k'
    valueFrom: '20'
  - position: 0
    prefix: '-r'
    valueFrom: '0.02'
  - position: 0
    prefix: '-w'
    valueFrom: '200'
requirements:
  - class: ResourceRequirement
    ramMin: 10000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'biocontainers/bwa:0.7.15'
  - class: InlineJavascriptRequirement
stdout: $(inputs.sam_name)
