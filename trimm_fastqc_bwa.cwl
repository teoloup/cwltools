class: Workflow
cwlVersion: v1.0
id: trimm_fastqc_bwa
label: Trimm_fastQC_BWA
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq2
    type: File
    'sbg:x': -548.3988647460938
    'sbg:y': -239.5
  - id: fastq1
    type: File
    'sbg:x': -540.3988647460938
    'sbg:y': -95.5
  - id: illumina_adapters_file
    type: File
    'sbg:x': -493.39886474609375
    'sbg:y': -384.5
  - id: sam_name
    type: string
    'sbg:x': -10.39886474609375
    'sbg:y': -437.4985656738281
  - id: ref_seq
    type: File
    'sbg:x': -319.39886474609375
    'sbg:y': 340.49676513671875
outputs:
  - id: r2_unpaired
    outputSource:
      - trimmomatic_nugen/r2_unpaired
    type: File
    'sbg:x': -366.39886474609375
    'sbg:y': -292.5
  - id: r1_unpaired
    outputSource:
      - trimmomatic_nugen/r1_unpaired
    type: File
    'sbg:x': -270.39886474609375
    'sbg:y': -30.49675941467285
  - id: output_sam
    outputSource:
      - bwa_mem_0_7_15/output_sam
    type: File
    'sbg:x': 177.60113525390625
    'sbg:y': -133.49676513671875
steps:
  - id: trimmomatic_nugen
    in:
      - id: fastq1
        source: fastq1
      - id: illumina_adapters_file
        source: illumina_adapters_file
      - id: fastq2
        source: fastq2
    out:
      - id: r1_paired
      - id: r1_unpaired
      - id: r2_paired
      - id: r2_unpaired
    run: ./trimmomatic_nugen.cwl
    label: trimmomatic_NuGen
    'sbg:x': -350
    'sbg:y': -163
  - id: fastqc
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out: []
    run: ./fastqc.cwl
    label: fastQc
    'sbg:x': -336
    'sbg:y': 63
  - id: fastqc_1
    in:
      - id: fastq1
        source: trimmomatic_nugen/r1_paired
      - id: fastq2
        source: trimmomatic_nugen/r2_paired
    out: []
    run: ./fastqc.cwl
    label: fastQc
    'sbg:x': -195.39886474609375
    'sbg:y': -361.5
  - id: bwa_mem_0_7_15
    in:
      - id: fastq1
        source: trimmomatic_nugen/r1_paired
      - id: fastq2
        source: trimmomatic_nugen/r2_paired
      - id: ref_seq
        source: ref_seq
      - id: sam_name
        source: sam_name
    out:
      - id: output_sam
    run: ./bwa_mem.cwl
    label: bwa mem v0.7.5
    'sbg:x': -34.39886474609375
    'sbg:y': -140.5
requirements: []
