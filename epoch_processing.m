clear
desired_field_names = {'Derived'};
directory = '\\wsl.localhost\debian\home\pike\experiments\epoch\epoch2d\Data';
% c = 2:length(files);
c = 1:10;
[first_out, output] = parser(directory, desired_field_names, c);
