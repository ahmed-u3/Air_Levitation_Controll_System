% Method 1
% Define the continuous-time transfer function in the S domain
numerator = [10.06];   % Coefficients of the numerator
denominator = [1, 2.646, 6.462, 5.49];   % Coefficients of the denominator

% Create a transfer function object in the S domain
sys_continuous = tf(numerator, denominator);

% Specify the sample time (Ts) for discretization
Ts = 0.1;  % Set your desired sample time

% Convert the transfer function to discrete-time using c2d
sys_discrete = c2d(sys_continuous, Ts, 'zoh');

% Display the results
disp('Continuous-time transfer function:')
disp(sys_continuous)
%step(sys_continuous)

disp('Discrete-time transfer function:')
disp(sys_discrete)
%step(sys_discrete)

% Method 2
%syms s;
%G = 10.06*s/(s^3 + (2.646)*s^2 + (6.462)*s + 5.49);
%inv_s = ilaplace(G);