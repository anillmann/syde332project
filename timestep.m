function [ road, cars ] = timestep( road, cars )
%TIMESTEP Summary of this function goes here
%   Detailed explanation goes here
    for j = 1:size(cars,2)
        if (cars(j).x < size(road,1))
            road(cars(j).x) = 0; % car drive away from current spot
        end
        cars(j) = cars(j).drive(road); % car drives
        % cannot increment the road
        if (cars(j).x < size(road,1))
            road(cars(j).x) = 1; % car is now in new spot
        end
    end
    if (road(1) == 0)
        cars = [cars Car(0,5,1)];
        road(1) = 1;
    end
end

