# autodock-gpu

## For Ligands
```
mk_prepare_ligand.py -i etomidate.sdf --charge_model gasteiger --merge_these_atom_types  -o etom_test.pdbqt
for i in *.sdf; do mk_prepare_ligand.py -i $i --charge_model gasteiger --merge_these_atom_types  -o $i.pdbqt
```
If SDF has no hydrogens then 
```
prepare_ligand.py -l your_ligand.pdb -A hydrogens -C -o your_ligand.pdbqt
```

## Receptor
```
obabel -i cif alpha-1_alpha-1_model.cif -o pdb -O alpha1-alpha1.pdb
prepare_receptor -r alpha1-alpha1.pdb -A hydrogens -U waters -o receptor.pdbqt
```



## Autodock-gpu
```
autodock_gpu_128wi -lfile ../../reference_ligands/KSEB-01-S2.pdbqt -ffile rigidReceptor.maps.fld -nrun 100 -heuristics 1 --heurmax 12000000 --nev 2500000 -p 150
```
