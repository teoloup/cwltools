class: Workflow
cwlVersion: v1.0
id: full_workflow_bestpractises__filteringplusvep
label: Full_WorkFlow_BestPractises__filteringPlusVEP
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: sam_name
    type: string
    'sbg:x': 0
    'sbg:y': 106.578125
  - id: ref_seq
    type: File
    'sbg:x': 0
    'sbg:y': 213.15625
  - id: illumina_adapters_file
    type: File
    'sbg:x': 0
    'sbg:y': 746.515625
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 959.828125
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 1066.40625
  - id: Sample
    type: string
    'sbg:x': 223
    'sbg:y': 479.8984375
  - id: Platform
    type: string
    'sbg:x': 223
    'sbg:y': 586.4453125
  - id: Library
    type: string
    'sbg:x': 223
    'sbg:y': 693.0703125
  - id: Barcode
    type: string
    'sbg:x': 223
    'sbg:y': 799.6953125
  - id: PoN_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 319.734375
  - id: gnomad_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 853.171875
  - id: dbSNP_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 1172.984375
  - id: bed_file
    type: File
    'sbg:x': 548.59375
    'sbg:y': 746.359375
  - id: VEP_cache_path
    type: Directory
    'sbg:x': 0
    'sbg:y': 0
  - id: plugins_path
    type: Directory?
    'sbg:x': 0
    'sbg:y': 426.390625
  - id: plugin_name
    type: string?
    'sbg:x': 0
    'sbg:y': 533.125
  - id: output_type
    type: string
    'sbg:x': 0
    'sbg:y': 639.859375
  - id: Depth
    type: string
    'sbg:x': 830.371337890625
    'sbg:y': 437.9453125
  - id: AF
    type: string
    'sbg:x': 830.371337890625
    'sbg:y': 735.0703125
outputs:
  - id: r2_unpaired
    outputSource:
      - trimm_fastqc_bwa/r2_unpaired
    type: File
    'sbg:x': 548.59375
    'sbg:y': 533.203125
  - id: r1_unpaired
    outputSource:
      - trimm_fastqc_bwa/r1_unpaired
    type: File
    'sbg:x': 548.59375
    'sbg:y': 639.78125
  - id: plots_pdf
    outputSource:
      - bqsr_mutect2_filtermutectcalls/plots_pdf
    type: File
    'sbg:x': 1122.613525390625
    'sbg:y': 491.125
  - id: output
    outputSource:
      - myfilter_vepannotation/output
    type: File
    'sbg:x': 1400.129150390625
    'sbg:y': 586.4921875
steps:
  - id: trimm_fastqc_bwa
    in:
      - id: fastq2
        source: fastq2
      - id: fastq1
        source: fastq1
      - id: illumina_adapters_file
        source: illumina_adapters_file
      - id: sam_name
        source: sam_name
      - id: ref_seq
        source: ref_seq
    out:
      - id: r2_unpaired
      - id: r1_unpaired
      - id: output_sam
    run: ./trimm_fastqc_bwa.cwl
    label: Trimm_fastQC_BWA
    'sbg:x': 223
    'sbg:y': 345.3203125
  - id: samtools_picard
    in:
      - id: aligned_sam
        source: trimm_fastqc_bwa/output_sam
      - id: Sample
        source: Sample
      - id: Platform
        source: Platform
      - id: Library
        source: Library
      - id: Barcode
        source: Barcode
    out:
      - id: dedup_RG_bam
    run: ./samtools_picard.cwl
    label: samtools_picard
    'sbg:x': 548.59375
    'sbg:y': 398.625
  - id: bqsr_mutect2_filtermutectcalls
    in:
      - id: bam_dedup_RG
        source: samtools_picard/dedup_RG_bam
      - id: bed_file
        source: bed_file
      - id: dbSNP_vcf
        source: dbSNP_vcf
      - id: ref_file
        source: ref_seq
      - id: sample_name
        source: Sample
      - id: PoN_vcf
        source: PoN_vcf
      - id: gnomad_vcf
        source: gnomad_vcf
    out:
      - id: plots_pdf
      - id: filtered_vcf
    run: ./bqsr_mutect2_filtermutectcalls.cwl
    label: BQSR_Mutect2_filterMutectCalls
    'sbg:x': 830.371337890625
    'sbg:y': 586.5234375
  - id: myfilter_vepannotation
    in:
      - id: vcf
        source: bqsr_mutect2_filtermutectcalls/filtered_vcf
      - id: Depth
        source: Depth
      - id: AF
        source: AF
      - id: VEP_cache_path
        source: VEP_cache_path
      - id: plugins_path
        source: plugins_path
      - id: plugin_name
        source: plugin_name
      - id: output_type
        source: output_type
    out:
      - id: output
    run: ./myfilter_vepannotation.cwl
    label: MyFilter_VEPannotation
    'sbg:x': 1122.613525390625
    'sbg:y': 639.78125
requirements:
  - class: SubworkflowFeatureRequirement
