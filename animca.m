% Load the data
% load('Ey.mat');

% Create a new figure
fig = figure();

% Define the colormap
cmap = jet(256);

% Set the figure size and position
set(fig, 'Units', 'pixels');
set(fig, 'Position', [100, 100, 800, 600]);

% Set the colormap and colorbar
colormap(jet);
c = colorbar('Location', 'eastoutside');

% Set the frame rate (in frames per second)
frame_rate = 60;

% Loop over the time steps and create a frame for each one
for i = 1:length(t)
    % Plot the Ey data
%     contourf(x, y, squeeze(Ey(i,:,:)), 100, 'LineColor','none');
 imagesc(x, y, squeeze(Ey(i,:,:)));
    set(gca, 'YDir', 'normal');
    
    % Set the axis labels and title
    title(sprintf('Electric field (t = %d fs)', t(i)*1e15));
    xlabel('X');
    ylabel('Y');
    
    % Set the colormap and colorbar
    colormap(jet);
    clim([0, max(Ey(:))]);
    colorbar('Location', 'eastoutside');
    
    % Set the figure size and position
    set(fig, 'Units', 'pixels');
    set(fig, 'Position', [100, 100, 800, 600]);
    
    % Set the frame rate (in frames per second)
    frame_rate = 60;
    
    % Wait for a short period of time to control the frame rate
    pause(1/frame_rate);
    
    % Capture the current frame
    frame = getframe(fig);
    
    % Write the frame to a video file
    if i == 1
        % Create a new video file
        writer = VideoWriter('Ey_7.mp4', 'MPEG-4');
        writer.FrameRate = frame_rate;
        open(writer);
    end
    writeVideo(writer, frame);
end

% Close the video file
close(writer);