clear
fclose all;
tic
addpath(genpath('SDF\Matlab'));
% addpath(genpath('epoch1d\Data'))

% Define the directory where the .sdf files are stored
directory = '\\wsl.localhost\debian\home\pike\experiments\epoch\epoch2d\Data';

% Get a list of all .sdf files in the directory
files = dir(fullfile(directory, '*.sdf'));

%Define number of files
%c = 2:length(files);
c = 1:100;

% Call the GetDataSDF function on the first file
filename = fullfile(directory, files(1).name);
output = GetDataSDF(filename);

% Preallocate the structure array with the correct set of fields
output(length(c)) = output;
b = output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the desired field names
desired_field_names = {'time'};

% Get all the field names in the structure
all_field_names = fieldnames(output);

% Determine the logical indices of the desired field names
desired_field_indices = ismember(all_field_names, desired_field_names);

% Remove all the fields except the desired fields
output = rmfield(output, all_field_names(~desired_field_indices));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use a parfor loop to process the remaining files in parallel


parfor i = c
    % Read the current file
    filename = fullfile(directory, files(i).name);
    % Call the GetDataSDF function on the current file
    result = GetDataSDF(filename);
    result = rmfield(result, all_field_names(~desired_field_indices));
    % Store the result in the structure array
    output(i) = result;
    disp(i)
end

toc