clear;

% Get PID constants from the user
kp = input('Enter kp value: ');
ki = input('Enter ki value: ');
kd = input('Enter kd value: ');

arduinoObj = serialport('COM4', 9600);

configureTerminator(arduinoObj,"CR/LF");

flush(arduinoObj);

arduinoObj.UserData = struct("Data",[],"Count",1);

% Send PID constants to Arduino
pidString = sprintf('kp=%.3f,ki=%.3f,kd=%.3f\n', kp, ki, kd);
%write(arduinoObj, pidString, "char");

configureCallback(arduinoObj,"terminator",@readSineWaveData);

function readSineWaveData(src, ~)

writeline(arduinoObj, pidString);
% Read the ASCII data from the serialport object.
data = readline(src);
disp(data);
% Extract numerical value from the received data
%tokens = regexp(data, 'Distance: (\d+\.\d+)', 'tokens');

% Convert the string data to numeric type and save it in the UserData
% property of the serialport object.
%src.UserData.Data(end+1) = 30 - str2double(tokens{1}{1});

% Update the Count value of the serialport object.
%src.UserData.Count = src.UserData.Count + 1;
%disp(src.UserData.Count);
% If 1001 data points have been collected from the Arduino, switch off the
% callbacks and plot the data.
%if src.UserData.Count > 300
    %configureCallback(src, "off");
    %plot(src.UserData.Data(2:end));
%end
end
