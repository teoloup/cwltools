class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: trimmomatic_nugen
baseCommand:
  - /usr/bin/java
  - '-jar'
  - /software/applications/Trimmomatic/0.36/trimmomatic-0.36.jar
  - PE
inputs:
  - id: fastq1
    type: File
    inputBinding:
      position: 1
  - id: illumina_adapters_file
    type: File
    inputBinding:
      position: 7
      prefix: 'ILLUMINACLIP:'
      separate: false
      valueFrom: '$(inputs.illumina_adapters_file.path):1:30:10'
  - id: fastq2
    type: File
    inputBinding:
      position: 2
outputs:
  - id: r1_paired
    type: File
    outputBinding:
      glob: $(inputs.fastq1.nameroot)_paired_trimmed.fastq.gz
  - id: r1_unpaired
    type: File
    outputBinding:
      glob: $(inputs.fastq1.nameroot)_unpaired_trimmed.fastq.gz
  - id: r2_paired
    type: File
    outputBinding:
      glob: $(inputs.fastq2.nameroot)_paired_trimmed.fastq.gz
  - id: r2_unpaired
    type: File
    outputBinding:
      glob: $(inputs.fastq2.nameroot)_unpaired_trimmed.fastq.gz
label: trimmomatic_NuGen
arguments:
  - position: 0
    prefix: '-threads'
    valueFrom: '24'
  - position: 0
    prefix: '-trimlog'
    valueFrom: trimlog_file.txt
  - position: 3
    prefix: ''
    valueFrom: $(inputs.fastq1.nameroot)_paired_trimmed.fastq.gz
  - position: 10
    prefix: 'MINLEN:'
    separate: false
    valueFrom: '70'
  - position: 8
    prefix: 'LEADING:'
    separate: false
    valueFrom: '20'
  - position: 9
    prefix: 'TRAILING:'
    separate: false
    valueFrom: '20'
  - position: 4
    prefix: ''
    valueFrom: $(inputs.fastq1.nameroot)_unpaired_trimmed.fastq.gz
  - position: 5
    prefix: ''
    valueFrom: $(inputs.fastq2.nameroot)_paired_trimmed.fastq.gz
  - position: 6
    prefix: ''
    valueFrom: $(inputs.fastq2.nameroot)_unpaired_trimmed.fastq.gz
requirements:
  - class: DockerRequirement
    dockerPull: 'comics/trimmomatic:latest'
  - class: InlineJavascriptRequirement
