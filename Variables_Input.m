% Create a serial port object
arduinoObj = serialport('COM4', 9600); 

% Set a timeout for readline
configureTerminator(arduinoObj, "LF");
arduinoObj.Timeout = 10; % Set the timeout value in seconds

SetPoint = input('Enter SetPoint: ');

% Get PID constants from the user
kp = input('Enter kp value: ');
ki = input('Enter ki value: ');
kd = input('Enter kd value: ');

try
    while true
        % Read data from Arduino
        data = readline(arduinoObj);
        disp(data);
        % Extract numerical value from the received data
        tokens = regexp(data, 'Distance: (\d+\.\d+)', 'tokens');
        
        % Check if the tokens are not empty
        if ~isempty(tokens) && numel(tokens) == 1
            distance = str2double(tokens{1}{1});

            % Display the extracted distance value
            %disp(['Distance: ' num2str(distance) ' cm']);

            % Write a set point to the Arduino
            writeline(arduinoObj, ['SetPoint:' num2str(SetPoint)]);
            writeline(arduinoObj, ['kp:' num2str(kp)]);
            writeline(arduinoObj, ['ki:' num2str(ki)]);
            writeline(arduinoObj, ['kd:' num2str(kd)]);
        else
            disp('Invalid data received.');
        end
    end
catch
    % Close and delete the serial port object when done
    fclose(arduinoObj);
    delete(arduinoObj);
    disp('Serial port closed');
end
