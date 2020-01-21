function [total_step, total_dist] = wmview(y,slope_angle,tci)
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

% Initialize figure for animation
figure('Color','w','Renderer','zbuffer')
axis([swing_foot_position_x 10.55 -1 1.5*leg_length])
axis off
strobePlot = 0;   % Draw stroboscopic plot: 1
tracePlot = 0;    % Trace path of hip and swing foot: 1 or 2

% Draw first position
% -----------------------
% slope
slope = line([swing_foot_position_x 10.25],[swing_foot_position_y (swing_foot_position_x-10.25)*tan(slope_angle)]);
set(slope,'Color','k','LineWidth',0.1);

% stance leg
stance_leg = line([stance_foot_x hip_position_x],[stance_foot_y hip_position_y]);
set(stance_leg,'Color','k','LineStyle','-');

% swing leg
swing_leg = line([swing_foot_position_x hip_position_x],[swing_foot_position_y hip_position_y]);
set(swing_leg,'Color','b','LineWidth',2);

if tracePlot==1
    % Plot position of hip and swing foot
    line([hip_position_x swing_foot_position_x],[hip_position_y swing_foot_position_y],...
         'Color','k','LineStyle','none','Marker','.','MarkerSize',1);
end

drawnow             % Force Matlab to draw

flipStride = 1;     % Flag for swing-stance flip

% record the old swing foot positions
xsw_old = swing_foot_position_x;
ysw_old = swing_foot_position_y;


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
        
        if strobePlot==1
            set([stance_leg swing_leg],'Visible','off');
        end
        
    end
    
    t1 = tci(j)+1;
    t2 = tci(j+1);
    for i=t1:t2
        if mod(i,20)==0 || i==t1 || i==t2           % When to draw
            xm_old = hip_position_x;
            ym_old = hip_position_y;
            hip_position_x = stance_foot_x-leg_length*sin(y(i,1)-slope_angle);          	% Position of hip
            hip_position_y = stance_foot_y+leg_length*cos(y(i,1)-slope_angle);
            
            if tracePlot>1
                line([xm_old hip_position_x],[ym_old hip_position_y],'Color',[0.5 0.5 0.5]);
            end
            
            if flipStride==1 && i>t1
                xsw_old = swing_foot_position_x;
                ysw_old = swing_foot_position_y;
            end
            
            swing_foot_position_x = hip_position_x - leg_length * sin(y(i,3) - y(i,1)+slope_angle);    	% Position of swing leg
            swing_foot_position_y = hip_position_y - leg_length * cos(y(i,3) - y(i,1)+slope_angle);
           
            if flipStride==1 && tracePlot==2
                % Trace path of blue leg
                line([xsw_old, swing_foot_position_x],[ysw_old, swing_foot_position_y],'Color',[0.5 0.5 1]);
            end

            if strobePlot~=1
                set([stance_leg swing_leg],'Visible','off'); % Clear previous position of legs
            else
                cc = 1-(i-t1)/(t2-t1);           	% Scale leg colors for stroboscopic plot
                set([stance_leg swing_leg],'Color',[cc cc cc]);
            end
            
            stance_leg = line([stance_foot_x hip_position_x],[stance_foot_y hip_position_y]);     	% Draw new position of stance leg
            swing_leg = line([swing_foot_position_x hip_position_x],[swing_foot_position_y hip_position_y]);      	% Draw new position of swing leg
            
            if flipStride==-1
                set(stance_leg,'Color','b','LineWidth',2);
                set(swing_leg,'Color','k','LineStyle','-');
            else
                set(stance_leg,'Color','k','LineStyle','-');
                set(swing_leg,'Color','b','LineWidth',2);
            end
            
            if tracePlot==1
                % Trace path of hip and swing foot
                line([hip_position_x swing_foot_position_x],[hip_position_y swing_foot_position_y],...
                     'Color','k','LineStyle','none','Marker','.','MarkerSize',1);
            end
            
            drawnow                                	% Force Matlab to draw
            
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


