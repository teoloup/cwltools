class: Workflow
cwlVersion: v1.0
id: samtools_picard
label: samtools_picard
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: aligned_sam
    type: File
    'sbg:x': 0
    'sbg:y': 213.90625
  - id: Sample
    type: string
    'sbg:x': 0
    'sbg:y': 0
  - id: Platform
    type: string
    'sbg:x': 0
    'sbg:y': 106.953125
  - id: Library
    type: string
    'sbg:x': 377.65625
    'sbg:y': 106.953125
  - id: Barcode
    type: string
    'sbg:x': 377.65625
    'sbg:y': 213.90625
outputs:
  - id: dedup_RG_bam
    outputSource:
      - picard_addorreplacereadgroups/dedup_RG_bam
    type: File
    'sbg:x': 887.433837890625
    'sbg:y': 160.4296875
steps:
  - id: samtools_view
    in:
      - id: aligned_sam
        source: aligned_sam
    out:
      - id: aligned_bam
    run: ./samtools_view.cwl
    label: samtools_view
    'sbg:x': 150.328125
    'sbg:y': 106.953125
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view/aligned_bam
    out:
      - id: sorted
    run: ./samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 377.65625
    'sbg:y': 0
  - id: picard_addorreplacereadgroups
    in:
      - id: sorted_dedup_bam
        source: samtools_sort/sorted
      - id: Library
        source: Library
      - id: Platform
        source: Platform
      - id: Barcode
        source: Barcode
      - id: Sample
        source: Sample
    out:
      - id: dedup_RG_bam
    run: ./picard_addorreplacereadgroups.cwl
    label: picard_AddOrReplaceReadGroups
    'sbg:x': 571.171875
    'sbg:y': 78.953125
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: picard_addorreplacereadgroups/dedup_RG_bam
    out: []
    run: ./samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 887.433837890625
    'sbg:y': 53.4765625
requirements: []
