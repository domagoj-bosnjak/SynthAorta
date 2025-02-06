# SynthAorta
The main code repo for the paper [SynthAorta: A 3D Mesh Dataset of Parametrized Physiological Healthy Aortas](https://arxiv.org/abs/2409.08635).

This repository contains 100 examples from the dataset; with 4 nested meshes of varying spatial refinement level per case. The Examples folder contains the 4 .msh files related to the first mesh case.

# Dataset link
The full dataset in the identical format as the present one may be found at: [TBD, very soon!].

# Requirements
For a unified format, and easier visualization, it is recommended to install the open source 3D finite element mesh generator [Gmsh](https://gmsh.info/).

# Usage
Everything is written for MATLAB/Octave. The following two steps are necessary to use the code.

1. To make sure all the paths are properly added, define a variable that says where you saved the SynthAorta folder and add it to MATLAB paths, e.g.,  
```
InputPath = "C:/Users/YourUsername/Documents/github/SynthAorta/"
addpath(InputPath);
```
2. To initialize the necessary paths to the code use:
```
SynthAortaInitialize(InputPath);
```
Now you are ready to use the code! Each future function will require the InputPath variable.

## Loading a mesh:
To load a mesh use the following function, assuming you are in the folder of the dataset: (otherwise, modify the filepaths in the loading function)
```
Mesh = SynthAortaLoadLinMesh(Index, RefLevel, InputPath);
```
where you choose the example number you want(Index, can be 1 to 100 for the test dataset provided here) and the refinement level(RefLevel). The possible options for the refinement level are 1, 2, 4 and 8; the meshes are nested.

To visualize the mesh, first convert it to the .msh format using
```
OutputFilename = "YourFilename.msh";
SynthAortaMeshLinHexaToMSH(Mesh, OutputFilename, [], []);
```
and then open the .msh file using Gmsh. Note that if you do not add ".msh" it will be added automatically. The meshes are also equipped with their extracted surface; you can verify this in Gmsh using Tools -> Visibility -> (Select surface or volume) -> Apply.

To load and visualize the skeleton(centerline) with the radius information use:
```
Skeleton = SynthAortaLoadSkeleton(Index, InputPath);
```
The visualization can be toggled off with a flag at the beginning of the function.

Additional functionality should be added along the way, however it has to be done here since the data published at the repository of the Graz University of Technology cannot be modified.

# Paper
If you are using this work, consider citing the original paper, currently available only as a preprint:
[SynthAorta: A 3D Mesh Dataset of Parametrized Physiological Healthy Aortas](https://arxiv.org/abs/2409.08635)

# Authors
[Domagoj Bošnjak](https://scholar.google.com/citations?user=cTvCvggAAAAJ&hl=en)

[Gian Marco Melito](https://scholar.google.at/citations?user=M_ktJ8QAAAAJ&hl=it)
