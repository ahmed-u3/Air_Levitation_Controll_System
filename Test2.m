% Create a serial port object
s = serialport('COM4', 9600); % Replace 'COMx' with your Arduino port

% Set a timeout for readline
configureTerminator(s, "LF");
s.Timeout = 10; % Set the timeout value in seconds
disp("sb7");
try
    while true
        % Read the data from the serial port
        data = readline(s);
        
        % Check if the received data is empty (indicating a timeout)
        if isempty(data)
            disp('Timeout occurred. Exiting the loop.');
            break;
        end

        % Split the received string into numerical values
        values = str2double(strsplit(strtrim(data)));
       
        % Check if values are not empty and contain three elements
        if ~isempty(values) && numel(values) == 3
            kp = values(1);
            ki = values(2);
            kd = values(3);

            % Process the received data as needed
            disp(['Received: kp=' num2str(kp) ', ki=' num2str(ki) ', kd=' num2str(kd)]);
        end
    end
catch
    % Close and delete the serial port object when an error occurs or when done
    delete(s);
    clear s;
    disp('Serial port closed');
end
