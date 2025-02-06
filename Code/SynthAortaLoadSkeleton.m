function Skeleton = SynthAortaLoadSkeleton(Index, InputPath)

%% Load and visualize a skeleton with radius information at the 
%% given index

%% Example call
% SynthAortaLoadSkeleton(1);

PlotFlag = 1; % do you want to plot? 

if endsWith(InputPath, "/")
    InputPath = strip(InputPath, 'right', '/');
end
%% Filenames and basic verification
%% the paths assume SynthAortaDataset is a first-level subfolder
SkeletonXYZInputFilename = InputPath + ...
    "/SynthAortaDataset/SkeletonData/SkeletonNodes_" + ...
    num2str(Index) + ".bin";
FilenameSkeletonConnMat = InputPath + ...
    "/SynthAortaDataset/ConnectivityMatrices/" + ...
    "Skeleton_ConnMat.bin";
SkeletonRadiiInputFilename = InputPath + ...
    "/SynthAortaDataset/SkeletonData/SkeletonRadii_" + ...
    num2str(Index) + ".bin";
%% Skeleton loading
fileID = fopen(SkeletonXYZInputFilename, 'r');
SkeletonXYZ = fread(fileID, 'single');
fclose(fileID);

% Reshape
SkeletonXYZ = reshape(SkeletonXYZ, [3, length(SkeletonXYZ)/3]);
SkeletonXYZ = SkeletonXYZ';

NodeNumPerElem = 2;
fileID = fopen(FilenameSkeletonConnMat, 'r');
ConnMat = fread(fileID, 'uint32');
ConnMat = reshape(ConnMat, [NodeNumPerElem, length(ConnMat)/NodeNumPerElem]);
ConnMat = ConnMat';
fclose(fileID);

% Radii loading
fileID = fopen(SkeletonRadiiInputFilename,'r');
RadVec = fread(fileID, 'single');
fclose(fileID);

%% Assemble the skeleton
Skeleton.xx = SkeletonXYZ(:,1);
Skeleton.yy = SkeletonXYZ(:,2);
Skeleton.zz = SkeletonXYZ(:,3);
Skeleton.NodeNumPerElem = 2;
Skeleton.NodeNum = length(Skeleton.xx);
Skeleton.ElemNum = size(ConnMat, 1);
Skeleton.ConnMat = ConnMat;

%% Plot the skeleton
if PlotFlag 
    fprintf("Plotting skeleton!\n")
    figure
    view(3)
    hold on
    for i = 1 : Skeleton.ElemNum
        xx = Skeleton.xx(Skeleton.ConnMat(i,:));
        yy = Skeleton.yy(Skeleton.ConnMat(i,:));
        zz = Skeleton.zz(Skeleton.ConnMat(i,:));

        plot3(xx, yy, zz, 'k-', 'Marker', 'o', 'MarkerSize', 10,...
            'MarkerFaceColor', 'm', 'MarkerEdgeColor', 'm', 'LineWidth', 5);
        hold on
    end
    axis equal
    hold off
    figure
    view(3)
    hold on
    for i = 1 : Skeleton.ElemNum
        xx = Skeleton.xx(Skeleton.ConnMat(i,:));
        yy = Skeleton.yy(Skeleton.ConnMat(i,:));
        zz = Skeleton.zz(Skeleton.ConnMat(i,:));

        plot3(xx, yy, zz, 'k-', 'Marker', 'o', 'MarkerSize', 10,...
            'MarkerFaceColor', 'm', 'MarkerEdgeColor', 'm', 'LineWidth', 5);
        hold on
    end
    for i = 1 : Skeleton.NodeNum
        [x,y,z] = sphere;
        x = x*RadVec(i);
        y = y*RadVec(i);
        z = z*RadVec(i);
        surf(x+Skeleton.xx(i),y+Skeleton.yy(i),z+Skeleton.zz(i))
        hold on
    end
    axis equal
    hold off
    fprintf("Plotting skeleton radii!\n")
end