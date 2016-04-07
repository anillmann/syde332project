function [ road, cars ] = timestep2( road, cars )
%TIMESTEP2 Summary of this function goes here
%   Detailed explanation goes here

    for i = 1:size(cars,2)
        if (cars(i).checkOnRoad(road)) 
            road(cars(i).x,cars(i).y) = 0;
            cars(i) = cars(i).drive2(road);
            if (cars(i).checkOnRoad(road))
                road(cars(i).x,cars(i).y) = 1;
            end
        end
    end

end

