clc;
close all;

switch (controller)
   case 1 % Modified Passivity
       str = 'Passivity';
       ce = pass_ce.data(1:9000);
   case 2 % Backstepping
       str = 'Backstepping';
       ce = back_ce.data;
   case 3 % Robustified Backstepping
       str = 'Robustified Backstepping';
       ce = rob_back_ce.data;
   case 4 % Decoupling Based
       str = 'Decoupling';
       ce = dec_ce.data(1:9000);
   otherwise
      str = 'ERROR'
end

t = time.time;
info = stepinfo(err.data, t, 0.0);
plot(t, err.data);
% xline(4);
title(strcat(str, ' Error Dynamics'), 'fontsize', 18)
grid on
% legend ( 'Error Dynamics' )

figure
plot(t, q_desired.data)
hold on
plot(t, q_disp.data)
hold on
plot(t, th_disp.data)
grid on
title(strcat(str, ' Tracking Performance'), 'fontsize', 18)
legend ( 'Desired Trajectory' , 'Link Trajectory', 'Motor Trajectory' )

figure
plot(t(1:9000), ce)
% plot(t(1:500), ce)
grid on
title(strcat(str, ' Control Effort'), 'fontsize', 18)