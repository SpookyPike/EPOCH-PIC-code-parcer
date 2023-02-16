clear
fclose all;
tic
addpath(genpath('SDF\Matlab'));
directory = '\\wsl.localhost\debian\home\pike\experiments\epoch\epoch2d\Data';

% Get a list of all .sdf files in the directory
files = dir(fullfile(directory, '*.sdf'));

% Extract the numeric part of each filename and store in a separate array
file_numbers = zeros(length(files), 1);
parfor i = 1:length(files)
    [~, name, ~] = fileparts(files(i).name);
    file_numbers(i) = sscanf(name, '%d');
end

% Sort the numeric values and get the sorted indices
[~, sorted_indices] = sort(file_numbers);

% Use the sorted indices to reorder the files array
files = files(sorted_indices);
clear sorted_indices sorted_numbers
%Define number of files
c = 1:length(files);

% Call the GetDataSDF function on the first file
filename = fullfile(directory, files(1).name);
output_1 = GetDataSDF(filename);

% Preallocate the matrix to store the 'time' variable

% Preallocate the matrices to store the variables
 Ey = zeros(length(files), size(output_1.Electric_Field.Ey.data, 1), size(output_1.Electric_Field.Ey.data, 2));
% n_e = zeros(length(files), size(output_1.Derived.Number_Density.data, 1), size(output_1.Derived.Number_Density.data, 2));
t = zeros(length(files), length(output_1.time));
% Pxr = zeros(length(files), size(output_1.Particles.Px.Right.data, 1), size(output_1.Particles.Px.Right.data, 2));
% ch = zeros(length(files), size(output_1.Derived.Temperature.electron.data, 1), size(output_1.Derived.Temperature.electron.data, 2));
% Pxl = zeros(length(files), size(output_1.Particles.Px.Left.data, 1), size(output_1.Particles.Px.Left.data, 2));

% Use a parfor loop to process the remaining files in parallel
parfor i = 1:length(files)
    filename = fullfile(directory, files(i).name);
    result = GetDataSDF(filename);

    t(i, :) = result.time;

     Ey(i, :, :) = result.Electric_Field.Ey.data;
%     n_e(i, :, :) = result.Derived.Number_Density.data;
%     ch(i, :, :) = result.Derived.Temperature.electron.data;
%     Pxr(i, :, :) = result.Particles.Px.Right.data;
%     Pxl(i, :, :) = result.Particles.Px.Left.data;

    disp(i)
end


toc
[x, y, z] = epoch_grid(output_1);

% figure()
% subplot(3,1,1);
% contourf(Pxl,  100 ,'LineColor','none');
imshow(Pxl/max(Pxr(:)))
title('n_e');
colorbar('Location', 'eastoutside');
% f
% subplot(3,1,2);
% contourf(Pxr,  100 ,'LineColor','none');
% title('Ey');
% colorbar('Location', 'eastoutside');
%
% subplot(3,1,3);
% contourf(Ey,  100 ,'LineColor','none');
% title('Mean charge');
% colorbar('Location', 'eastoutside');

% contourf(x, time, n_e,  100 ,'LineColor','none');
colormap(jet)
shading interp
squeeze
