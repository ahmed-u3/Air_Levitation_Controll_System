%% TF of ServoMotor
    numerator_plant = [10.06];
    denominator_plant = [1, 2.646, 6.462, 5.49];
    Gc = tf(numerator_plant, denominator_plant);
%% PID Tuner
    K = pidtune(Gc,'pid');
%% Applying PID tuner on ServoMotor TF    
    s = tf("s");
    Gc2 = Gc*K;
    T1 = feedback(Gc,1);
    T2 = feedback(Gc2,1);
%% Finding The Steady State Error

    SP = 15;
    [y,t]=step(T1*SP); 
    sserror=abs(SP-y(end));
    disp("Steady State Error Before PID:");
    disp(sserror);
    
    [y1,t1] = step(T2*SP); 
    sserror1=abs(SP-y1(end));
    disp("Steady State Error After PID:");
    disp(sserror1);

%% Transient Response Parameters 
    disp("Transient Response Before PID:");
    disp(stepinfo(T1));
    disp("Transient Response After PID:");
    disp(stepinfo(T2));

    %step(T1,'b'); hold on
    %step(T2, 'r');
    %legend("Before PID", "After PID");

    % Zero-Order Hold (ZOH)
    Ts = 0.1; % Sample time for ZOH
    Gc_discrete = c2d(Gc, Ts, 'zoh');

    % PID Tuning
    [K, info] = pidtune(Gc_discrete, 'pid');

    % Applying PID tuner on ServoMotor TF
    Gc2_discrete = Gc_discrete * K;

%% Checking The System Stability
   disp("System Stability Before PID:");
   disp(isstable(T1));

   poles_T1 = pole(T1);
   % Use Z domain plot if necessary
   %zplane([], poles_T1);
   %title('Pole-Zero Plot Before PID');

   disp("System Stability After PID:");
   disp(isstable(T2));

   poles_T2 = pole(T2);
   % Use Z domain plot if necessary
   %zplane([], poles_T2);
   %title('Pole-Zero Plot After PID');

   % Plot root locus before PID
   figure;
   rlocus(T1);
   title('Root Locus Before PID');
    
   % Plot root locus after PID
   figure;
   rlocus(T2);
   title('Root Locus After PID');