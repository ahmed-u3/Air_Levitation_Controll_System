% Create a serial port object
s = serialport('COM4', 9600); % Replace 'COM4' with your Arduino port

% Set a timeout for readline
configureTerminator(s, "LF");
s.Timeout = 10; % Set the timeout value in seconds

% Initialize figure for real-time response plot
figure;
hLine = plot(NaN, NaN);
xlabel('Time');
ylabel('Distance (cm)');
title('Real-time Distance Response');

% Set up a timer for updating the plot
updateTimer = timer('ExecutionMode', 'fixedRate', 'Period', 0.1, ...
    'TimerFcn', @(~,~) updatePlot(s, hLine));

% Start the timer
start(updateTimer);

% Wait for the user to close the figure
uiwait(gcf);

% Clean up when the figure is closed
stop(updateTimer);
delete(updateTimer);
fclose(s);
delete(s);
disp('Serial port and timer closed');

% Function to update the plot
function updatePlot(serialPort, plotHandle)
    try
        % Read data from Arduino
        data = readline(serialPort);

        % Extract numerical value from the received data
        tokens = regexp(data, 'Distance: (\d+\.\d+)', 'tokens');

        % Check if the tokens are not empty
        if ~isempty(tokens) && numel(tokens) == 1
            distance = str2double(tokens{1}{1});

            % Display the extracted distance value
            disp(['Distance: ' num2str(distance) ' cm']);

            % Update the plot
            xData = [plotHandle.XData, datetime('now')];
            yData = [plotHandle.YData, distance];
            set(plotHandle, 'XData', xData, 'YData', yData);
        else
            disp('Invalid data received.');
        end
    catch
        disp('Error occurred. Closing serial port and timer.');
        stop(updateTimer);
        delete(updateTimer);
        fclose(serialPort);
        delete(serialPort);
    end
end
