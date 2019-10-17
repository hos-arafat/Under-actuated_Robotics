clc;
close all;

switch (controller)
   case 1 % Modified Passivity
       str = 'Passivity';
%        ce = pass_ce.data(1:9000);
       ce = pass_ce.data;
   case 2 % Backstepping
       str = 'Backstepping';
       ce = back_ce.data;
   case 3 % Robustified Backstepping
       str = 'Robustified Backstepping';
       ce = rob_back_ce.data;
   case 4 % Decoupling Based
       str = 'Decoupling';
       ce = dec_ce.data;
   otherwise
      str = 'ERROR'
end

t = time.time;
info = stepinfo(err.data, t, 0.0) %, 'SettlingTimeThreshold', 0.055)
setl = info.SettlingTime;
rise = info.RiseTime;

setl_index_list = find(t<=setl);
if(~isnan(setl))
    setl_index = setl_index_list(end);
    setl_T = t(setl_index);
    setl_Y = err.data(setl_index);
else
    setl_Y = 0;
end


rise_index_list = find(t<=rise);
rise_index = rise_index_list(end);
rise_Y = err.data(rise_index);
if(~isnan(setl))
    plot(t, err.data, setl_T, setl_Y, 'ro', t(rise_index),rise_Y,'go');
else
    plot(t, err.data, t(rise_index),rise_Y,'go');
end
% hold on
% plot(t(rise_index),rise_Y, 'color', 'g', 'o');

% xline(4);
title(strcat(strcat(str, ' Error Dynamics '), '  (K = ', num2str(k), ')'), 'fontsize', 18)
grid on
yL = get(gca,'YLim');
yL(2) = setl_Y;
line([setl setl],yL,'Color','r','LineStyle','--');

yL = get(gca,'YLim');
yL(2) = rise_Y;
line([rise rise],yL,'Color','g','LineStyle','--');

% legend ( 'Error Dynamics' )

figure
plot(t, q_desired.data)
hold on
plot(t, q_disp.data)
hold on
plot(t, th_disp.data)
grid on
box on
title(strcat(strcat(str, ' Tracking Performance'), '  (K = ', num2str(k), ')'), 'fontsize', 18)
legend ( 'Desired Trajectory' , 'Link Trajectory', 'Motor Trajectory' )

figure
plot(t, ce)
% plot(t(1:500), ce)
grid on
box on
title(strcat(strcat(str, ' Control Effort '), '  (K = ', num2str(k), ')'), 'fontsize', 18)
axes('position',[.65 .175 .25 .25])
box on % put box around new pair of axes
indexOfInterest = (t < 2.7) & (t > 0.02); % range of t near perturbation
plot(t(indexOfInterest),ce(indexOfInterest)) % plot on new axes
axis tight
