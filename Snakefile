# Find a way to convert IDs into samples (OG0006009.fa)

rule mafft_align:
    input:
        "Single_Copy_Orthologue_Sequences/{sample}.fa",
    output:
        "mafft_alignment/{sample}.alignment",
    threads: 10
    shell:
        "mafft --localpair --maxiterate 1000  --auto --quiet --thread {threads} {input} > {output}"
