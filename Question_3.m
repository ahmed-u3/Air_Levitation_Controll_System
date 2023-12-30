% - Get the S and Z Domain PID transfer functions. 

% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1;

% PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

disp("------------------------------------------------");

%% S Domain PID transfer function
% Create the continuous-time PID transfer function
num_pid_s = [Kd, Kp, Ki];   % Coefficients of the derivative, proportional, and integral terms
den_pid_s = [1, 0];         % Denominator coefficients for a simple unity feedback system
sys_pid_s = tf(num_pid_s, den_pid_s);

% Display the transfer functions
disp('Continuous-time PID transfer function (S-domain):');
disp('S-domain PID numerator coefficients:');
disp(sys_pid_s.Numerator);
disp('S-domain PID denominator coefficients:');
disp(sys_pid_s.Denominator);

disp("------------------------------------------------");

%% Z Domain PID transfer function
% Discretize the continuous-time PID transfer function using the 'tustin' method
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin'); % We used tustin which handle the improper system and proper systems too 
                                          % Why ? because our system is unstable in which the degree of the numerator is greater than the degree of the denomenator
                                          % and the poles is equal 0 which make the system unstable                                                                                   

disp('Discrete-time PID transfer function (Z-domain):');
disp('Z-domain PID numerator coefficients:');
disp(sys_pid_z.Numerator);
disp('Z-domain PID denominator coefficients:');
disp(sys_pid_z.Denominator);

disp("------------------------------------------------");

%% Reason for using tustin

% Check causality
isCausal = isproper(sys_pid_s, 'Causal', true);

% Check properness
isProper = isproper(sys_pid_s, 'Strict', true);

% Check stability
isStable = all(pole(sys_pid_s) < 0);

% Display the results
disp(['Is causal: ' num2str(isCausal)]);
disp(['Is proper: ' num2str(isProper)]);
disp(['Is stable: ' num2str(isStable)]);

% Only proceed with discretization if the system is causal, proper, and stable
if isCausal && isProper && isStable
    % Sample time (adjust as needed)
    Ts = 0.1;

    % Convert the continuous-time PID controller to a discrete-time PID controller
    sys_pid_z = c2d(sys_pid_s, Ts, 'zoh');

    % Display the transfer function in the Z domain
    disp('Transfer Function in the Z domain:')
    disp(sys_pid_z);
else
    disp('System is not suitable for discretization.');
end