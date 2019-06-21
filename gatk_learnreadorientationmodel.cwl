class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_learnreadorientationmodel
baseCommand:
  - gatk
  - LearnReadOrientationModel
inputs:
  - id: f1r2
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
outputs:
  - id: orientation_model
    type: File
    outputBinding:
      glob: $(inputs.f1r2.nameroot).read-orientation-model.tar.gz
label: gatk_LearnReadOrientationModel
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.f1r2.nameroot).read-orientation-model.tar.gz
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
