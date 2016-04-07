close all; clear all; clc;

% model parameters
road_length = 100;
road_lanes = 2;
num_iterations = 100;

% define the road
road = zeros(road_length,road_lanes);

% init first car
cars = Car(0,1,1);
road(1) = 1;
filename = 'test_332.gif';
backup = 0;
merge_backup = 0;
backup_history = zeros(num_iterations,1);
merge_backup_history = zeros(num_iterations,1);

for i = 1:num_iterations
   [road,cars,backup,merge_backup] = timestep(road, cars, backup, merge_backup);
   backup_history(i) = backup;
   merge_backup_history(i) = merge_backup;
   backup;
   i;
   bar(road);
   drawnow
   %w = waitforbuttonpress;
   
   frame = getframe(1);
   im = frame2im(frame);
   [imind,cm] = rgb2ind(im,256);
   if i == 1;
      imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
   else
      imwrite(imind,cm,filename,'gif','WriteMode','append');
   end
   if(i == 45)
       road = block(road,50);
   end
   if(i == 57)
       road = unblock(road);
   end
end
figure
plot(backup_history);
figure
plot(merge_backup_history);
