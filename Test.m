clear;

arduinoObj = serialport('COM4', 9600);

configureTerminator(arduinoObj,"CR/LF");

flush(arduinoObj);



data = readline(arduinoObj)

clear;


%arduinoObj.UserData = struct("Data",[])