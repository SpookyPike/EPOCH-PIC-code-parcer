clear
fclose all;

tic

addpath(genpath('SDF\Matlab'));
directory = '\\wsl.localhost\debian\home\pike\experiments\epoch\epoch1d\Data';

% Get a list of all .sdf files in the directory
files = dir(fullfile(directory, '*.sdf'));

% Extract the numeric part of each filename and store in a separate array
file_numbers = zeros(length(files), 1);
for i = 1:length(files)
    [~, name, ext] = fileparts(files(i).name);
    file_numbers(i) = sscanf(name, '%d');
end

% Sort the numeric values and get the sorted indices
[sorted_numbers, sorted_indices] = sort(file_numbers);

% Use the sorted indices to reorder the files array
files = files(sorted_indices);

%Define number of files
c = 1:length(files);

% Call the GetDataSDF function on the first file
filename = fullfile(directory, files(1).name);
output_1 = GetDataSDF(filename);

% Preallocate the matrix to store the 'time' variable
Ey = zeros(length(files), length(output_1.Electric_Field.Ey.data));
n_e = zeros(length(files), length(output_1.Derived.Number_Density.data));
time = zeros(length(files), length(output_1.time));
ch = zeros(length(files), length(output_1.Derived.Temperature.electron.data));

% Ey(1, :) = output_1.Electric_Field.Ey.data;
% n_e(1, :) = output_1.Derived.Number_Density.data;
% time(1, :) = output_1.time;

% Use a parfor loop to process the remaining files in parallel

 for i = 1:length(files)
    filename = fullfile(directory, files(i).name);
    result = GetDataSDF(filename);

    time(i, :) = result.time;

    Ey(i , :) = result.Electric_Field.Ey.data;
    n_e(i, :) = result.Derived.Number_Density.data;
    ch(i, :) = result.Derived.Temperature.electron.data;

    disp(i)
 end

toc
[x, y, z] = epoch_grid(output_1);

figure()
subplot(3,1,1);
contourf(n_e,  100 ,'LineColor','none');
title('n_e');
colorbar('Location', 'eastoutside');

subplot(3,1,2);
contourf(Ey,  100 ,'LineColor','none');
title('Ey');
colorbar('Location', 'eastoutside');

subplot(3,1,3);
contourf(ch,  100 ,'LineColor','none');
title('Mean charge');
colorbar('Location', 'eastoutside');

% contourf(x, time, n_e,  100 ,'LineColor','none');
colormap(jet)
shading interp
colorbar on 