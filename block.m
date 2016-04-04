function [ road ] = block( road, pos )
    if(road(pos)==0)
        road(pos) = 2;
    else
        pos = pos+1;
        while(road(pos)~=0)
            pos = pos+1;
        end
        road(pos) = 2;
    end
end

