load("Final_Project_1.mat")

%% Plot Root Locus Before and After adding PID in Z domain
figure;
rlocus(sys_z_c2d, '-b', sys_closed_loop, '-r');
title('Root Locus Before and After Adding PID Control (Z Domain)');
legend('Before PID', 'After PID');