# AAFC Phylogenetic Tree Project

This is a Snakemake workflow designed to create a phylogenetic tree. It relies on Mambaforge. If you haven't installed Mambaforge yet, you can follow the installation instructions found here: <https://snakemake.readthedocs.io/en/stable/tutorial/setup.html>

Once you've successfully installed Mambaforge, proceed to create a new conda environment using the provided ```environment.yaml``` file.

## Creating the Environment

To ensure that all necessary tools for this analysis are available within a single conda environment. I recommend using Mamba/micromamba to create it. Please follow these commands to set up the environment and activate it for the duration of your analysis:

```bash
micromamba create -n AAFC_snakemake_env --file environment.yaml
micromamba activate AAFC_snakemake_env
```

## Creating the Configuration File

To guide the workflow to your orthologous gene locations, you'll need to create a configuration file and modify the Python script in ```scripts/configmaker.py``` as shown below:

```python
# Write the formatted output to the new file, changing 'Single_Copy_Orthologue_Sequences/' to match your sequence directory.
output_f.write(f'    {id_without_extension}: Single_Copy_Orthologue_Sequences/{line}')
```

If you used the docker version of OrthoFinder, you will likely find this folder at ```WorkingDirectory/Single_Copy_Orthologue_Sequences/```. After modifying the python script, you can run it to generate the ```config.yaml``` file:

```python
python3 configmaker.py
```

## Running the pipeline

This pipeline enables the creation of a Glomeromycota phylogenetic tree from single-copy orthologue sequences generated by OrthoFinder. Here is an overview of the steps involved:

1. Align the single copy orthologue sequences using MAFFT.
2. Concatanate the alignments and convert them into a .phy file.
3. Trim the alignments using TrimAL.
4. Determine the best substitution model and construct the phylogenetic tree with IQtree.

After creating the conda environment using the ```environment.yaml``` file and generating the ```config.yaml``` file by customizing and running the ```scripts/configmaker.py``` script, the actual Snakemake pipeline can be run.

- First, run the workflow in dry mode:

```bash
snakemake -np > dry_run.out
```

- Then, create a Directed Acyclic Graph (DAG) visualization and review it:

```bash
snakemake --dag | dot -Tsvg > dag.svg
```

- If dry run completes without a problem and everything looks as expected in the DAG, you can proceed to run the pipeline:

```bash
snakemake --cores
```

## Next steps

Once your ```all_amf.iqtree``` file is generated, you can analyze it to identify the best substitution model for your proteins. For easier phylogenetic tree analysis, it is recommended to open ```all_amf.treefile``` with FigTree and make the necessary modifications using that tool.

## Citations

This section will soon be updated with relevant citations!
