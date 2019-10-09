m = 0.03;
d = 0.06;
Im = 0.0075;
I = 0.004;
k = 4.0;
g0 = -9.81;

% q_init = 1 - deg2rad(10);
q_init = 1.5;
th_init = 1.5;

controller = 1;

switch (controller)
   case 1 % Modified Passivity
       disp('Passivity')
       if (k == 4.0)
            kp = 19;
            kd = 20;
       elseif (k == 400.0)
            kp = 290;
            kd = 500;
       end
   case 2 % Backstepping
       disp('Backstepping')
       if (k == 4.0)
            kp = 0.8;
            kd = 0.08;
       elseif (k == 400.0)
            kp = 100;
            kd = 20;
       end
   case 3 % Robustified Backstepping
       disp('Robustified Backstepping')
       if (k == 4.0)
            kp = 43.0;
            kd = 49.0;
       elseif (k == 400.0)
            kp = 100;
            kd = 20;
       end
   case 4 % Decoupling Based
       disp('Decoupling')
       if (k == 4.0)
            kp = 18;
            kd = 20;
       elseif (k == 400.0)
            kp = 0.8;
            kd = 0.2;
       end
   otherwise
      kp = 0;
      kd = 0;
end

G1 = kp;
G2 = kd;

A1 = kp/kd;
B1 = kd;
B2 = kd;
