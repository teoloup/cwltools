class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_mutect2_tumoronly_with__po_n
baseCommand:
  - gatk
  - Mutect2
inputs:
  - id: ref_fasta
    type: File
    inputBinding:
      position: 1
      prefix: '-R'
  - id: BQSR2_bam
    type: File
    inputBinding:
      position: 3
      prefix: '-I'
  - id: bed_file
    type: File
    inputBinding:
      position: 11
      prefix: '-L'
  - id: sample_name
    type: string
    inputBinding:
      position: 5
      prefix: '-tumor'
  - id: gnomad_vcf
    type: File
    inputBinding:
      position: 7
      prefix: '--germline-resource'
  - id: PoN_vcf
    type: File
    inputBinding:
      position: 9
      prefix: '--panel-of-normals'
outputs:
  - id: vcf
    type: File
    outputBinding:
      glob: $(inputs.sample_name).vcf
  - id: f1r2
    type: File
    outputBinding:
      glob: $(inputs.sample_name).f1r2.tar.gz
label: gatk_Mutect2_tumorOnly_with_PoN
arguments:
  - position: 0
    prefix: '--af-of-alleles-not-in-resource'
    valueFrom: '0.00003125'
  - position: 0
    prefix: '--f1r2-tar-gz'
    valueFrom: $(inputs.sample_name).f1r2.tar.gz
  - position: 0
    prefix: '-max-reads-per-alignment-start'
    valueFrom: '0'
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.sample_name).vcf
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 1
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
