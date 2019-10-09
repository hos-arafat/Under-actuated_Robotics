%%
clc;
close all;

% x_pos = x_disp.data;
x_pos = q_disp.data;
% x_pos = x_disp.signals.values(1: 7: end);
% time = x_disp.time(1: 5: end);
a_time = time.time;
% x_des = x_desired.data;
x_des = q_desired.data;
% x_des = x_desired.signals.values(1: 7: end);

% % % Animation

f = figure('visible','on');
F = struct('cdata', cell(1,length(a_time)), 'colormap', cell(1,length(a_time)));

for i = 1:length(a_time)
    
    Xpend(1) = 0;
    Ypend(1) = 0;
    Xpend(2) = Xpend(1) + d*sin(x_pos(i));
    Ypend(2) = Ypend(1) + d*cos(x_pos(i));
    
    hold on
    plot(d*sin(x_des(i)),d*cos(x_des(i)),'r.','Markersize',10);
    hold off
    grid on
    axis equal
    axis([-2*d 2*d -2*d 2*d]);
    drawnow
%   pause(0.1);
    F(i) = getframe(f);
    drawnow
    fprintf ( '% d \n' , (i / length(a_time) * 100) );
%     clc;
% %     fprintf ( '\b\b\b\b\b' ); % this is not working well
%     pause(.05); % allows time for display to update
end
%% create the video writer with 1 fps
writerObj = VideoWriter('new_backstepping.avi');
writerObj.FrameRate = 100;
% set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(F)
    % convert the image to a frame
    frame = F(i) ;
    writeVideo(writerObj, frame);
%     disp(i / length(F));
    fprintf ( 'b' );
    fprintf ( '% d' , (i / length(F)) * 100);
end
% close the writer object
close(writerObj);
