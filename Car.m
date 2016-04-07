classdef Car
    %CAR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        v; %the velocity of the car
        v_max; %the max velocity of the car
        prob_slowdown = 0.3;
        prob_speeder = 0.1;
        prob_granny = 0.95;
        x; %the location of the car
        y; %the lane of the car
        t = 0; %the time the car has been travelling
        dist = 0; %the distance the car has travelled 
        p_slow = 0.3; %probability car slows down
    end
    
    methods
        function obj = Car(v_init,x_init,y_init)
           obj.v = v_init;
           obj.x = x_init;
           obj.y = y_init;
           %{
           p = rand;
           if (p < obj.prob_speeder)
               obj.v_max = 6;
           elseif (p < obj.prob_granny)
           %}
               obj.v_max = 5;
           %{
           else
               obj.v_max = 4;
           end
           %}
                   
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
        
        function obj = accel(obj)
        % acceleration of the car
            if (obj.v == obj.v_max)
                if(rand < 0.3)
                    obj.v = obj.v - 1;
                end
            elseif (obj.v < 2)
                obj.v = obj.v + 3;
            elseif (obj.v < 4)
                obj.v = obj.v + 2;
            else
                obj.v = obj.v + 1;
            end
            if (obj.v > obj.v_max)
                obj.v = obj.v_max;
            end 
        end
        
        function obj = drive2(obj,road)
        % check if there is a car ahead
            if (obj.checkOnRoad(road))
                
                % step 1 - accelerate to max per turn
                obj = obj.accel;
                
                % step 2 - make sure you don't hit a car
                if (any(obj.getAhead(road,0)))
                    % get the max speed in this lane
                    v_max_ahead = find(obj.getAhead(road,0),1) - 1;

                    %get the max speed in the right lane
                    if (any(obj.getAhead(road,-1)))
                        v_max_right = find(obj.getAhead(road,-1)) - 1;
                    else
                        v_max_right = obj.v;
                    end

                    %get the max speed in the left lane
                    if (any(obj.getAhead(road,1)))
                        v_max_left = find(obj.getAhead(road,1)) - 1;
                    else
                        v_max_left = obj.v;
                    end
                    
                    if (v_max_left > v_max_ahead)
                        if(v_max_right > v_max_left)
                            obj.v = v_max_right;
                            obj.y = obj.y - 1;
                        else
                            obj.v = v_max_left;
                            obj.y = obj.y + 1;
                        end
                    else
                        obj.v = v_max_ahead;
                    end
                end
                
                % step 3 - drive
                if (obj.x + obj.v > size(road,1))
                    obj.x = size(road,1) + 1;
                    obj.v = 0;
                else
                    obj.x = obj.x + obj.v; 
                end 
                obj.t = obj.t + 1;
            end    
            
        end      
    end
    
    methods 
       
        function out = avgSpeed(obj)
            out = obj.dist/obj.t;
        end 
        
        function out = checkOnRoad(obj,road)
        % check if the car distance is less than the length of the road
            if (obj.x > size(road,1))
               out = false;
            else
                out = true;
            end
        end
        
        function out = getAhead(obj,road,lane)
            if (lane == 0)
                out = road(obj.x+1:obj.maxDistTrav(road),obj.y); 
            elseif (lane < 0)
                % get the right lane
                if (obj.y - 1 > 0)
                    out = road(obj.x+1:obj.maxDistTrav(road),obj.y-1);
                else
                    out = 2;
                end
            elseif (lane > 0)
                % get the left lane
                if (obj.y + 1 <= size(road,2))
                    out = road(obj.x+1:obj.maxDistTrav(road),obj.y+1);
                else 
                    out = 2;
                end
            end
        end
        
        function out = maxDistTrav(obj,road)
        % prevent array bound issue
            out = obj.x + obj.v;
            if (out > size(road,1))
                out = size(road,1);
            end
        end
        
    end
        
    
end

