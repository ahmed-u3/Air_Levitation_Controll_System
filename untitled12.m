% Continuous-time system
numerator = [1];
denominator = [1, 2, 1];
sys_c = tf(numerator, denominator);

% Sampling time
Tsampling = 0.1;

% Method 1: Using bilinear function
[num_z_bilinear, den_z_bilinear] = bilinear(numerator, denominator, 1/Tsampling);

% Method 2: Using c2d function with 'tustin' method
[sys_d_tustin, Ts_tustin] = c2d(sys_c, Tsampling, 'tustin');

% Display the results
disp('Results using Bilinear function:');
disp('Numerator Coefficients:');
disp(num_z_bilinear);
disp('Denominator Coefficients:');
disp(den_z_bilinear);
disp(' ');

disp('Results using c2d function with Tustin method:');
disp('Discrete-time System:');
disp(sys_d_tustin);
disp('Sampling Time:');
disp(Ts_tustin);
