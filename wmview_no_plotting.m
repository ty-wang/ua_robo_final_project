function [total_step, total_dist] = wmview_no_plotting(y,slope_angle,tci)
%WMVIEW  Animate passive dynamic walking data
%   WMVIEW(Y, GAM, TCI) animates the passive dynamic data in Y for slope angle
%   GAM and collision indices TCI.
%   
%   See also: SIMPWM, FULLWM, ACTUWM.

%   Andrew D. Horchler, horchler @ gmail . com, Created 7-7-04
%   Revision: 1.1, 5-1-16


% Leg length
leg_length = 1.5;

% Position of stance foot
stance_foot_x = 0;
stance_foot_y = 0;

% Position of hip
hip_position_x = stance_foot_x - leg_length * sin(y(1,1) - slope_angle);
hip_position_y = stance_foot_y + leg_length * cos(y(1,1) - slope_angle);

% Position of swing foot
swing_foot_position_x = hip_position_x - leg_length * sin(y(1,3) - y(1,1) + slope_angle);
swing_foot_position_y = hip_position_y - leg_length * cos(y(1,3) - y(1,1) + slope_angle);








flipStride = 1;     % Flag for swing-stance flip




% !!!! Add in !!!!
total_step = 0;
total_dist = 0;


% Animate each stride
for j=1:length(tci)-1  % tci is the collision index vector
    
    % On collision switch stance and swing legs
    if j>1
        stance_foot_x = swing_foot_position_x;
        stance_foot_y = swing_foot_position_y;
        
        flipStride = -flipStride;
        
        
        
    end
    
    t1 = tci(j)+1;
    t2 = tci(j+1);
    for i=t1:t2
        if mod(i,20)==0 || i==t1 || i==t2           % When to draw
            
            hip_position_x = stance_foot_x-leg_length*sin(y(i,1)-slope_angle);          	% Position of hip
            hip_position_y = stance_foot_y+leg_length*cos(y(i,1)-slope_angle);
            
            
            
            
            
            swing_foot_position_x = hip_position_x - leg_length * sin(y(i,3) - y(i,1)+slope_angle);    	% Position of swing leg
            swing_foot_position_y = hip_position_y - leg_length * cos(y(i,3) - y(i,1)+slope_angle);
           
            

            
            
            
            
        end
    end
    
    
    % !!!! added features !!!!
    if hip_position_y <= 0
%         disp('walking failed')
        break;
    else
        total_step = total_step + 1;
        total_dist = total_dist + hip_position_x;
    end
    
    
    
end