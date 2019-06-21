class: Workflow
cwlVersion: v1.0
id: variantcalling_trimmed_mutectwithpon_workflow
label: VariantCalling_trimmed_MutectWithPON_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: Sample
    type: string
    'sbg:x': 0
    'sbg:y': 0
  - id: sam_name
    type: string
    'sbg:x': 0
    'sbg:y': 107
  - id: ref_seq
    type: File
    'sbg:x': 0
    'sbg:y': 214
  - id: PoN_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 321
  - id: Platform
    type: string
    'sbg:x': 0
    'sbg:y': 428
  - id: Library
    type: string
    'sbg:x': 0
    'sbg:y': 535
  - id: gnomad_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 749
  - id: fastq1
    type: File
    'sbg:x': 0
    'sbg:y': 963
  - id: fastq2
    type: File
    'sbg:x': 0
    'sbg:y': 856
  - id: illumina_adapters_file
    type: File
    'sbg:x': 0
    'sbg:y': 642
  - id: dbSNP_vcf
    type: File
    'sbg:x': 0
    'sbg:y': 1070
  - id: bed_file
    type: File
    'sbg:x': 0
    'sbg:y': 1177
  - id: Barcode
    type: string
    'sbg:x': 0
    'sbg:y': 1284
outputs:
  - id: r2_unpaired
    outputSource:
      - trimmomatic_nugen/r2_unpaired
    type: File
    'sbg:x': 522.3973388671875
    'sbg:y': 458
  - id: r1_unpaired
    outputSource:
      - trimmomatic_nugen/r1_unpaired
    type: File
    'sbg:x': 522.3973388671875
    'sbg:y': 565
  - id: metrics
    outputSource:
      - _variant_calling__mutect_with_p_o_n_workflow/metrics
    type: File
    'sbg:x': 881.519287109375
    'sbg:y': 749
  - id: plots_pdf
    outputSource:
      - _variant_calling__mutect_with_p_o_n_workflow/plots_pdf
    type: File
    'sbg:x': 881.519287109375
    'sbg:y': 642
  - id: vcf
    outputSource:
      - _variant_calling__mutect_with_p_o_n_workflow/vcf
    type: File
    'sbg:x': 881.519287109375
    'sbg:y': 535
steps:
  - id: _variant_calling__mutect_with_p_o_n_workflow
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
      - id: PoN_vcf
        source: PoN_vcf
      - id: gnomad_vcf
        source: gnomad_vcf
      - id: dbSNP_vcf
        source: dbSNP_vcf
    out:
      - id: plots_pdf
      - id: vcf
      - id: metrics
    run: ./VariantCalling_MutectWithPON_workflow.cwl
    label: VariantCalling_MutectWithPON_workflow
    'sbg:x': 522.3973388671875
    'sbg:y': 749
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
    'sbg:x': 223.015625
    'sbg:y': 621
requirements:
  - class: SubworkflowFeatureRequirement
