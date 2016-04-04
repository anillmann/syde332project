close all; clear all; clc;

% model parameters
road_length = 100;
num_iterations = 25;

% define the road
road = zeros(road_length,1);

% initialize my car
cars = Car(0,5,1);
road(1) = 1;
filename = 'test_332.gif';

for i = 1:num_iterations
   [road,cars] = timestep(road, cars);
   bar(road);
   drawnow
   
   frame = getframe(1);
   im = frame2im(frame);
   [imind,cm] = rgb2ind(im,256);
   if i == 1;
      imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
   else
      imwrite(imind,cm,filename,'gif','WriteMode','append');
   end
end

%{
for i = 1:num_iterations
    % add new car to the road
    if (road(1) == 0)
        cars = [cars Car(0,5,1)];
    end
    
    for j = 1:size(cars,2)
        if (cars(j).x < road_length)
            road(cars(j).x) = 0; % car drive away from current spot
        end
        cars(j) = cars(j).drive(road); % car drives
        % cannot increment the road
        if (cars(j).x < road_length)
            road(cars(j).x) = 1; % car is now in new spot
        end
    end
        
end
%}
