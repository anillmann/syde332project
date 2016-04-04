classdef Car
    %CAR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        v; %the velocity of the car
        v_max; %the max velocity of the car
        x; %the location of the car
        t = 0; %the time the car has been travelling
        dist = 0; %the distance the car has travelled 
        p_slow = 0.3; %probability car slows down
    end
    
    methods
        function obj = Car(v_init,v_max,x_init)
           obj.v = v_init;
           obj.v_max = v_max;
           obj.x = x_init;
        end
        
        function obj = drive(obj,road) 
            % check if there is a car ahead
            if ( obj.x > size(road,1) )
                % do nothing
            elseif ( obj.x+obj.v > size(road,1) )
                obj.x = size(road,1) + 1;
                obj.v = 0;
                obj.dist = size(road,1);
                obj.t = obj.t + 1;
            else
                % increment the speed
                if ( obj.v < obj.v_max)
                    if(obj.v == 0)
                        obj.v = 3;
                    elseif(obj.v == 1 || obj.v == 2)
                        obj.v = 4;
                    elseif(obj.v == 3 || obj.v == 4)
                        obj.v = 5;
                    end
                else
                    % if at max speed, randomly slow down
                    if (rand < obj.p_slow)
                       obj.v = obj.v - 1; 
                    end
                end
                if (obj.x + obj.v <= size(road,1))
                    if ( any( road(obj.x:(obj.x+obj.v)) ) )
                       % find the first location, set the speed to before that
                       obj.v = find( road(obj.x:(obj.x+obj.v)),1,'first' ) - obj.x - 1;
                       % cannot set speed negative
                       if (obj.v < 0)
                           obj.v = 0;
                       end
                    end
                else
                    if ( any( road(obj.x:size(road,1)) ) )
                       % find the first location, set the speed to before that
                       obj.v = find( road(obj.x:size(road,1)),1,'first' ) - obj.x - 1;
                       % cannot set speed negative
                       if (obj.v < 0)
                           obj.v = 0;
                       end
                    end
                end
                % drive
                obj.x = obj.x + obj.v;
                obj.dist = obj.dist + obj.v;
                obj.t = obj.t + 1;
            end
        end
    end
    
    methods 
       
        function out = avgSpeed(obj)
            out = obj.dist/obj.t;
        end 
        
    end
        
    
end

