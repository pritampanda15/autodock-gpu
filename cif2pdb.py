import os
import pymol2

# Directory containing CIF files
input_directory = './'  # Change this to the directory where your files are located
output_directory = './converted_pdb/'  # Directory to save the PDB files

# Create the output directory if it doesn't exist
os.makedirs(output_directory, exist_ok=True)

with pymol2.PyMOL() as pymol:
    for filename in os.listdir(input_directory):
        if filename.endswith('.cif'):
            infile = os.path.join(input_directory, filename)
            outfile = os.path.join(output_directory, filename.replace('.cif', '.pdb'))
            
            print(f"Processing: {filename}")
            pymol.cmd.load(infile, 'myprotein')
            pymol.cmd.save(outfile, selection='myprotein')
            pymol.cmd.delete('myprotein')  # Clean up for the next file
            
            print(f"Saved: {outfile}")

print("All files have been converted!")
