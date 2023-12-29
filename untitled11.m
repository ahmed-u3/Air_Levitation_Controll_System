% Create a serial port object
s = serialport('COM4', 9600); % Replace 'COM4' with your Arduino port

% Set a timeout for readline
configureTerminator(s, "LF");
s.Timeout = 10; % Set the timeout value in seconds

try
    while true
        % Read data from Arduino
        data = readline(s);

        % Extract numerical value from the received data
        tokens = regexp(data, 'Distance: (\d+\.\d+)', 'tokens');
        
        % Check if the tokens are not empty
        if ~isempty(tokens) && numel(tokens) == 1
            distance = str2double(tokens{1}{1});

            % Display the extracted distance value
            disp(['Distance: ' num2str(distance) ' cm']);
        else
            disp('Invalid data received.');
        end
    end
catch
    % Close and delete the serial port object when done
    fclose(s);
    delete(s);
    disp('Serial port closed');
end
