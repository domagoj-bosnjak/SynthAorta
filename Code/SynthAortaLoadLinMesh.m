function Mesh = SynthAortaLoadLinMesh(Index, RefLevel, InputPath)

%% Input function for loading a mesh

%% All possible calls:
% Mesh = SynthAortaLoadMesh(1, 8);
% Mesh = SynthAortaLoadMesh(1, 4);
% Mesh = SynthAortaLoadMesh(1, 2);
% Mesh = SynthAortaLoadMesh(1, 1);

if endsWith(InputPath, "/")
    InputPath = strip(InputPath, 'right', '/');
end
%% Filenames and basic verification
%% the paths assume SynthAortaDataset is a first-level subfolder
FilenameXYZ = InputPath + ...
    "/SynthAortaDataset/MeshNodes/MeshNodes_" + num2str(Index) + ".bin";
FilenameConnMat = InputPath + ...
    "/SynthAortaDataset/ConnectivityMatrices/ConnMat_Ord_1_Ref_" + ...
    num2str(RefLevel) + ".bin";
FilenameConnMatBdry = InputPath + ...
    "/SynthAortaDataset/ConnectivityMatrices/ConnMatBdry_Ord_1_Ref_" + ...
    num2str(RefLevel) + ".bin";
FilenameGlobalInds = InputPath + ...
    "/SynthAortaDataset/ConnectivityMatrices/GlobalInds_Ord_1_Ref_" + ...
    num2str(RefLevel) + ".bin";
% Check that files exist
if ~isfile(FilenameXYZ) || ~isfile(FilenameConnMat)
    error("File does not exist. Are you sure the ref level is in {1,2,4,8}," + ...
        " and that the following path to the dataset is correct: " + ...
        InputPath+"/SynthAortaDataset/");
end
% GlobalInds is not needed for the most refined mesh
if ~isfile(FilenameGlobalInds) && RefLevel ~= 8
    error("File does not exist. Are you sure the ref level is in {1,2,4,8}," + ...
        " and that the following path to the dataset is correct: " + ...
        InputPath+"/SynthAortaDataset/");
end

%% Load the nodes and connectivity
% General formula needed for reshaping
NodeNumPerElem = 8;
NodeNumPerElemSurf = 4;

% Load xyz nodes
fileID = fopen(FilenameXYZ, "r");
MeshNodes = fread(fileID, "single");
fclose(fileID);
% Reshape from a vector to xyz; 3 because there are 3 coordinates: x,y,z
MeshNodes = reshape(MeshNodes, [3, length(MeshNodes)/3]);
MeshNodes = MeshNodes';

% If the desired mesh is coarser, indices need to be selected out
if RefLevel < 8
    fileID = fopen(FilenameGlobalInds, "r");
    GlobalInds = fread(fileID, "uint32");
    fclose(fileID);

    % Select only those mesh nodes
    MeshNodes = MeshNodes(GlobalInds, :);
end

% Load connectivity matrix
fileID = fopen(FilenameConnMat, "r");
ConnMat = fread(fileID, "uint32");
ConnMat = reshape(ConnMat, [NodeNumPerElem, length(ConnMat)/NodeNumPerElem]);
ConnMat = ConnMat';
fclose(fileID);

% Load connectivity matrix of the boundary
fileID = fopen(FilenameConnMatBdry, "r");
ConnMatBdry = fread(fileID, "uint32");
ConnMatBdry = reshape(ConnMatBdry, [NodeNumPerElemSurf, length(ConnMatBdry)/NodeNumPerElemSurf]);
ConnMatBdry = ConnMatBdry';
fclose(fileID);

%% Set up the mesh structure
Mesh.xx = MeshNodes(:, 1);
Mesh.yy = MeshNodes(:, 2);
Mesh.zz = MeshNodes(:, 3);
Mesh.NodeNum = length(Mesh.xx);

Mesh.ConnMat = ConnMat;
Mesh.ConnMatBdry = ConnMatBdry;
Mesh.ElemNum = size(ConnMat, 1);
Mesh.NodeNumPerElem = NodeNumPerElem;
