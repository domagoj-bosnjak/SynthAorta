# SynthAorta
The main code repo for the paper [SynthAorta: A 3D Mesh Dataset of Parametrized Physiological Healthy Aortas](https://arxiv.org/abs/2409.08635).

# Dataset link
The full dataset in the identical format as the present one may be found at: [TBD, very soon!].

# Requirements
For a unified format, and easier visualization, it is recommended to install the open source 3D finite element mesh generator [Gmsh](https://gmsh.info/).

# Usage
This repository contains 100 examples from the dataset.

## Loading a mesh:
To load a mesh use the following:
```
Mesh = SynthAortaLoadLinMesh(Index, RefLevel)
```
where you choose the example number you want(Index) and the refinement level(RefLevel). The possible options for the refinement levels are 1, 2, 4 and 8; the meshes are nested.

To visualize the mesh, first convert it to the .msh format using
```
SynthAortaMeshLinHexaToMSH(Mesh, OutputFilename, [], []);
```
and then open the .msh file using Gmsh.

To load and visualize the skeleton(centerline) with the radius information use: (you can also toggle the visualization on/off with the flag at the beginning of the function)
Skeleton = SynthAortaLoadSkeleton(Index);

Additional functionality should be added along the way, however it has to be done here since the data published at the repository of the Graz University of Technology cannot be modified.

# Paper
If you are using this work, consider citing the original paper, currently available only as a preprint:
[SynthAorta: A 3D Mesh Dataset of Parametrized Physiological Healthy Aortas](https://arxiv.org/abs/2409.08635)

# Authors
[Domagoj Bošnjak](https://scholar.google.com/citations?user=cTvCvggAAAAJ&hl=en)

[Gian Marco Melito](https://scholar.google.at/citations?user=M_ktJ8QAAAAJ&hl=it)
