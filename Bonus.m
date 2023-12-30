SetPoint = input('Enter SetPoint: ');

% Get PID constants from the user
kp = input('Enter kp value: ');
ki = input('Enter ki value: ');
kd = input('Enter kd value: ');

% Create a serial port object
arduinoObj = serialport('COM4', 9600); 

% Set a timeout for readline
arduinoObj.Timeout = 10; % Set the timeout value in seconds
configureTerminator(arduinoObj, "CR/LF");

flush(arduinoObj);

% Initialize data storage
data = [];

% Set the maximum number of data points to collect
maxDataPoints = 1000;

% Continue reading data in a loop
while true
    % Read the ASCII data from the serial port object.
    receivedData = readline(arduinoObj);
    disp(receivedData);

    % Extract numerical value from the received data
    tokens = regexp(receivedData, 'Distance: (\d+\.\d+)', 'tokens');

    % Check if the tokens are not empty
    if ~isempty(tokens) && numel(tokens) == 1
        distance = str2double(tokens{1}{1});
    else
        disp('Invalid data received.');
        continue;
    end
    
    pause(1);
    % Write a set point and PID constants to the Arduino
    writeline(arduinoObj, ['SetPoint:' num2str(SetPoint)]);
    writeline(arduinoObj, ['kp:' num2str(kp)]);
    writeline(arduinoObj, ['ki:' num2str(ki)]);
    writeline(arduinoObj, ['kd:' num2str(kd)]);

    % Convert the string data to numeric type and save it
    data(end + 1) = 30 - distance;
    
    disp(length(data));
    % If the desired number of data points have been collected, break the loop
    if length(data) >= maxDataPoints
        break;
    end
end

% Plot the collected data
plot(data);
xlabel('Data Point');
ylabel('Value');
title('Collected Data');
grid on;

% Close the serial port
fclose(arduinoObj);
delete(arduinoObj);
clear arduinoObj;