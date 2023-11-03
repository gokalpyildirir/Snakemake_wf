# Input file name
input_file = 'singlecopy_ids.txt'

# Output file name
output_file = '../config.yaml'

# Open the input and output files
with open(input_file, 'r') as input_f, open(output_file, 'w') as output_f:
    output_f.write('samples:\n')
    for line in input_f:
        # Remove the trailing newline character and ".fa" extension
        id_without_extension = line.strip().replace('.fa', '')

        # Write the formatted output to the new file, changing 'Single_Copy_Orthologue_Sequences/' to match your sequence directory.
        output_f.write(f'    {id_without_extension}: Single_Copy_Orthologue_Sequences/{line}')

print(f'Processed {input_file} and saved the results in {output_file}')
