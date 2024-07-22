#!/usr/bin/env cwl-runner

class: CommandLineTool

cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: "4dndcic/4dn-mcoolqc:v1"

- class: "InlineJavascriptRequirement"

inputs:
  mcoolfile:
   type: File
   inputBinding:
    position: 1

  outdir:
   type: string
   inputBinding:
    position: 2
   default: "."

outputs:
  mcool_qc:
   type: File
   outputBinding:
    glob: "$(inputs.outdir + '/' + '*.json')"

baseCommand: ["run-mcoolQC.sh"]
