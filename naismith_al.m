function [w, t, slope] = naismith_al(length, ascend, base_speed)
% NAISMITH_AL Naismith's rule with Aitken-Langmuir adjustments
% IN: 
%   length and ascend in [km]
% OUT:
%   w in [km/h]
%   t in [h]
%   slope in [km/km]

    if ~exist('base_speed', 'var')
        base_speed = 4; % [km/h]
    end

    slope = ascend/length;
    theta = atand(slope);
    
    t = length*(1/base_speed);
    if slope >= 0
        t = t + ascend*(1/0.6);
    elseif theta <= -5 && theta >= -12
        t = t - abs(ascend)*((10/60)/0.3);
    elseif theta < -12
        t = t + abs(ascend)*((10/60)/0.3);
    end
    
    w = length./t;
    
end