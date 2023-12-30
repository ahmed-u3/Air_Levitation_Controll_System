load("Final_Project_1.mat")

%% Determine the system stability before the PID tunning

% Check stability before PID control
isStable_before = isstable(sys_z_c2d);

% Display Stability Results Before PID Control
disp(['System Stability Before PID Control: ' num2str(isStable_before)]);

disp("--------------------------------------------------------");

%% Determine the system stability after the PID tunning

% Check stability after PID control
isStable_after = isstable(sys_closed_loop);

% Display Stability Results After PID Control
disp(['System Stability After PID Control: ' num2str(isStable_after)]);

disp("--------------------------------------------------------");

%% Why we didn't use zoh ?
isStable_sys_pid_s = isstable(sys_pid_s);
disp(['Checking if the S Domain is stable to use ZOH: ' num2str(isStable_sys_pid_s)]);

% isstable = 1 then The system sys is stable.
% isstable = 2 then The system sys is stable.

disp("--------------------------------------------------------");

%% Reason for using tustin

% Check causality
isCausal = isproper(sys_pid_s, 'Causal', true);

% Check properness
isProper = isproper(sys_pid_s, 'Strict', true);

% Display the results
disp(['Is causal: ' num2str(isCausal)]);
disp(['Is proper: ' num2str(isProper)]);

% Only proceed with discretization if the system is causal, proper, and stable
if isCausal && isProper 
    disp('System is suitable for discretization.');
else
    disp('System is not suitable for discretization.');
end