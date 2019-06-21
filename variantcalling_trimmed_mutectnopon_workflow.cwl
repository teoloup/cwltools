class: Workflow
cwlVersion: v1.0
id: variantcalling_trimmed_mutectnopon_workflow
label: VariantCalling_Trimmed_MutectNoPON_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: illumina_adapters_file
    type: File
    'sbg:x': 0
    'sbg:y': 395.5
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 502.5
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 609.5
  - id: ref_seq
    type: File
    'sbg:x': 223.015625
    'sbg:y': 342
  - id: dbSNP_vcf
    type: File
    'sbg:x': 223.015625
    'sbg:y': 663
  - id: bed_file
    type: File
    'sbg:x': 223.015625
    'sbg:y': 770
  - id: vcf_name
    type: string
    'sbg:x': 0
    'sbg:y': 288.5
  - id: Sample
    type: string
    'sbg:x': 223.015625
    'sbg:y': 128
  - id: sam_name
    type: string
    'sbg:x': 223.015625
    'sbg:y': 235
  - id: Platform
    type: string
    'sbg:x': 223.015625
    'sbg:y': 449
  - id: Library
    type: string
    'sbg:x': 223.015625
    'sbg:y': 556
  - id: Barcode
    type: string
    'sbg:x': 223.015625
    'sbg:y': 877
outputs:
  - id: r2_unpaired
    outputSource:
      - trimmomatic_nugen/r2_unpaired
    type: File
    'sbg:x': 522.3973388671875
    'sbg:y': 449
  - id: vcf
    outputSource:
      - variantcalling_mutectnopon_workflow/vcf
    type: File
    'sbg:x': 845.624267578125
    'sbg:y': 342
  - id: plots_pdf
    outputSource:
      - variantcalling_mutectnopon_workflow/plots_pdf
    type: File
    'sbg:x': 845.624267578125
    'sbg:y': 449
  - id: metrics
    outputSource:
      - variantcalling_mutectnopon_workflow/metrics
    type: File
    'sbg:x': 845.624267578125
    'sbg:y': 556
  - id: r1_unpaired
    outputSource:
      - trimmomatic_nugen/r1_unpaired
    type: File
    'sbg:x': 140.3948974609375
    'sbg:y': -42.157920837402344
steps:
  - id: variantcalling_mutectnopon_workflow
    in:
      - id: ref_seq
        source: ref_seq
      - id: fastq2
        source: trimmomatic_nugen/r2_paired
      - id: fastq1
        source: trimmomatic_nugen/r1_paired
      - id: sam_name
        source: sam_name
      - id: Sample
        source: Sample
      - id: Platform
        source: Platform
      - id: Library
        source: Library
      - id: Barcode
        source: Barcode
      - id: bed_file
        source: bed_file
      - id: dbSNP_vcf
        source: dbSNP_vcf
      - id: vcf_name
        source: vcf_name
    out:
      - id: plots_pdf
      - id: metrics
      - id: vcf
    run: ./variantcalling_mutectnopon_workflow.cwl
    label: VariantCalling_MutectNoPON_workflow
    'sbg:x': 522.3973388671875
    'sbg:y': 272
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
    'sbg:x': -55.09351348876953
    'sbg:y': 170.40354919433594
requirements:
  - class: SubworkflowFeatureRequirement
