% - Get Steady State Error before and after the PID Control in Z Domain. 
% Before PID
numerator_plant = [10.06];
denominator_plant = [1, 2.646, 6.462, 5.49];
sys = tf(numerator_plant, denominator_plant);

SP = 15; %input value, if you put 1 then is the same as step(sys)
[y,t] = step(SP*sys); %get the response of the system to a step with amplitude SP
sserror = abs(SP-y(end)); %get the steady state error
% Display the steady-state error value
disp(['Steady-State Error Before PID: ' num2str(sserror)]);

%----------------------------------PID in Z domain------------------------------

% Define PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Specify the sample time for discretization
Ts = 0.1;  % 0.1 seconds

% Create the discrete-time PID controller transfer function
z = tf('z', Ts);
G_controller_z = Kp + Ki * Ts/(1 - z^-1) + Kd * z / Ts;

% Display the PID transfer function in the Z domain
disp('PID Controller Transfer Function in Z Domain:')

%-------------------------------------------------------------------------------

% After PID
SP = 15; %input value, if you put 1 then is the same as step(sys)
[y,t] = step(SP*G_controller_z); %get the response of the system to a step with amplitude SP
sserror = abs(SP-y(end)); %get the steady state error
% Display the steady-state error value
disp(['Steady-State Error After PID: ' num2str(sserror)]);
