function [x, y, z] = epoch_grid(output_1)
if isfield(output_1, 'Grid') && isfield(output_1.Grid, 'Grid') && isfield(output_1.Grid.Grid, 'x')
    x = output_1.Grid.Grid.x(1:end-1);
else
    x = [];
end

if isfield(output_1, 'Grid') && isfield(output_1.Grid, 'Grid') && isfield(output_1.Grid.Grid, 'y')
    y = output_1.Grid.Grid.y(1:end-1);
else
    y = [];
end

if isfield(output_1, 'Grid') && isfield(output_1.Grid, 'Grid') && isfield(output_1.Grid.Grid, 'z')
    z = output_1.Grid.Grid.z(1:end-1);
else
    z = [];
end

end