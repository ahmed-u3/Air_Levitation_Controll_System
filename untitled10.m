clear;

arduinoObj = serialport('COM4', 9600);

configureTerminator(arduinoObj,"CR/LF");

flush(arduinoObj);

arduinoObj.UserData = struct("Data",[],"Count",1);

configureCallback(arduinoObj,"terminator",@readSineWaveData);

function readSineWaveData(src, ~)

% Read the ASCII data from the serialport object.
data = readline(src);

% Extract numerical value from the received data
tokens = regexp(data, 'Distance: (\d+\.\d+)', 'tokens');

% Convert the string data to numeric type and save it in the UserData
% property of the serialport object.
src.UserData.Data(end+1) = 30 - str2double(tokens{1}{1});

% Update the Count value of the serialport object.
src.UserData.Count = src.UserData.Count + 1;
disp(src.UserData.Count);
% If 1001 data points have been collected from the Arduino, switch off the
% callbacks and plot the data.
if src.UserData.Count > 1001
    configureCallback(src, "off");
    plot(src.UserData.Data(2:end));
end
end




