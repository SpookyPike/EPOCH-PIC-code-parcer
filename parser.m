function [first_out, output] = parser(directory, desired_field_names, c)


% Get a list of all .sdf files in the directory
files = dir(fullfile(directory, '*.sdf'));

%Define number of files
% c = 2:length(files);
%  c = 1:10;

% Call the GetDataSDF function on the first file
filename = fullfile(directory, files(1).name);
output = GetDataSDF(filename);

first_out = output;

% Preallocate the structure array with the correct set of fields
output(length(c)) = output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the desired field names


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
clearvars -except first_out output

end