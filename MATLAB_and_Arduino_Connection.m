% Connect to Arduino
%clear arduinoObj;
%arduinoObj = arduino('COM4', 'Uno', 'Libraries', 'I2C');

% Create a figure for real-time plotting
figure;
h = animatedline;

% Setpoint value sent to Arduino
setpoint = 15;

% Initialize PID parameters
kp = 0.897;
ki = 0.1;
kd = 0.01;

% Open a serial connection to Arduino
clear serialConnection;
serialConnection = serialport('COM4', 9600);

% Send PID parameters to Arduino

% Create a formatted string
commandString = sprintf('%f %f %f\n', kp, ki, kd);

% Send the formatted string to Arduino
fprintf(serialConnection, commandString);


% Run the loop for a specific duration (e.g., 30 seconds)
tStart = tic;
while toc(tStart) < 30
    % Send setpoint to Arduino
    write(serialConnection, setpoint, "double");
    pause(0.1);
    
    % Read distance and speed from Arduino
    data = read(serialConnection, 3, "double");
    
    % Check if data is not empty before accessing its elements
    if ~isempty(data)
        distance = data(1);
        speed = data(2);
        
        % Plot real-time data
        addpoints(h, toc(tStart), distance);
        drawnow;

        % Display the received data
        disp(['Distance: ', num2str(distance), ' cm, Speed: ', num2str(speed), ' PWM']);
    else
        disp('No data received within the timeout period.');
    end
    
    pause(0.1);  % Adjust the pause duration as needed
end



% Close the serial connection
clear serialConnection arduinoObj;
