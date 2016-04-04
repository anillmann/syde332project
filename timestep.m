function [ road, cars, backup, merge_backup ] = timestep( road, cars, backup, merge_backup )
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
    if (road(1) == 0) %add a car if the first spot is open
        cars = [cars Car(0,5,1)];
        %road(1) = 1; 
        %don't do above because it will not be staying at postion 1
        cars(size(cars,2)) = cars(size(cars,2)).drive(road);
        if (cars(size(cars,2)).x < size(road,1))
            road(cars(size(cars,2)).x) = 1; % car is now in new spot
        end
        if(backup>=1 && road(1) == 0) %add a new car if the new car moved
            cars = [cars Car(0,5,1)];
            road(1) = 1;
            backup = backup - 1;
        end
    else
        backup = backup + 1;
    end
    if(rand < 0.4)
        if(road(1) == 0)
            cars = [cars Car(0,5,1)];
            road(1) = 1;
        else
            merge_backup = merge_backup +1;
        end
    elseif(merge_backup > 0 && road(1) == 0)
        cars = [cars Car(0,5,1)];
        road(1) = 0;
        merge_backup = merge_backup - 1;
    end
        
end

