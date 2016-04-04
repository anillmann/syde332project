function [ road ] = unblock( road )
    road(road==2) = 0;
end

