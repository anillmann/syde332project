close all; clear all; clc;

road_length = 100;
road_lanes = 3;
num_iterations = 100;

road = zeros(road_length,road_lanes);
road(:,1) = 2;
road(11:20,1) = 0;

cars_waiting = 0;
avg_waiting = zeros(num_iterations,1);
avg_speed = zeros(num_iterations,1);


%init first car
cars = Car(1,11,1);
road(11,1) = 1;

if (road_lanes > 1)
    for i = 2:road_lanes
        cars = [cars Car(1,1,i)];
        road(1,i) = 1;
    end
end



for n = 1:num_iterations
    % add cars normally driving
    
    for c = 2:road_lanes
        if (road(1,c)==0)
            if (rand < 0.33)
                cars = [cars Car(5,1,c)];
            end
        end
    end
    
    
    if (mod(n,3)==0)
        cars_waiting = cars_waiting + 1;
    end
    
    if (road(11,1)==0)
        if (cars_waiting > 0)
            road(11,1) = 1;
            cars = [cars Car(1,11,1)];
            cars_waiting = cars_waiting - 1;
        end
    end
        
    % drive the cars
    [road, cars] = timestep2(road,cars);
    
end

color(:,1) = [1 1 1];
color(:,2) = [1 0 0];
color(:,3) = [0 0 0];

road(:,4) = 2;

figure
pcolor(road.');
colormap(color.');


