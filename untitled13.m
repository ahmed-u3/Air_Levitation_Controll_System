% Plant transfer function
numerator_plant = [10.06];
denominator_plant = [1, 2.646, 6.462, 5.49];
sys_plant = tf(numerator_plant, denominator_plant);

% Controller transfer function (proportional control)
Kp = 1;
sys_controller = tf(Kp, 1);

% Open-loop system
sys_open_loop = series(sys_plant, sys_controller);

% Plot root locus in s domain
figure;
rlocus(sys_open_loop);
title('Root Locus in s Domain');
grid on;