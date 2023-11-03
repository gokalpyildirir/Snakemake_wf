configfile: "config.yaml"


rule all:
    input:
        "all_amf.iqtree"


def get_ortho_dirs(wildcards):
    return config["samples"][wildcards.sample]


rule mafft_align:
    input:
        get_ortho_dirs,
    output:
        "mafft_aligned/{sample}.alignment",
    threads: 10
    shell:
        "mafft --localpair --maxiterate 1000  --auto --quiet --thread {threads} {input} > {output}"


rule catfasta2phyml_run:
    input:
        # "mafft_aligned/{sample}.alignment"
        expand("mafft_aligned/{sample}.alignment", sample=config["samples"])
    output:
        "mafft_aligned/all_alignment.phy"
    shell:
        "catfasta2phyml -c mafft_aligned/*.alignment > {output}"

rule trimal_run:
    input:
        "mafft_aligned/all_alignment.phy"
    output:
        "singlescp_trimal.out"
    shell:
        "trimal -in {input} -phylip -out {output} -gt 0.9"

rule iqtree_run:
    input:
        "singlescp_trimal.out"
    output:
        "all_amf.iqtree"
    shell:
        "iqtree -s {input} -nt AUTO -B 1000 --prefix all_amf"