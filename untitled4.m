%% TF of ServoMotor
    Gc = tf ([-0.8054,4204,1.444e06],[1, 469.1, 3.676e04,1.356e06]);
%% PID Tuner
    [K,info] = pidtune(Gc,'pid'); 
%% Applying PID tuner on ServoMotor TF    
    s = tf("s");
    Gc2 = Gc*K;
    T1 = feedback(Gc,1);
    T2 = feedback(Gc2,1);