% - Tune the Z Domain transfer function using MATLAB PID Tuner GUI and mention the tunning results as P, I, D. 

% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1;

% Create the Z-domain transfer function
sys_s = tf(numerator, denominator);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); % 'zoh' stands for zero-order hold
                                   % By default 'zoh'
%% PID Tuner GUI
pidTuner(sys_z_c2d,'pid');