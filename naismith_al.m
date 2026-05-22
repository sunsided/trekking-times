function [w, t, slope] = naismith_al(distance, ascend, base_speed)
% NAISMITH_AL Naismith's rule with Aitken-Langmuir adjustments.
%   [w, t, slope] = NAISMITH_AL(distance, ascend) uses the default base
%   speed of 4 km/h.
%   [w, t, slope] = NAISMITH_AL(distance, ascend, base_speed) uses the
%   given base speed.
%
% IN:
%   distance and ascend in [km]
%   base_speed in [km/h] (optional, default 4)
% OUT:
%   w in [km/h]
%   t in [h]
%   slope in [km/km]

    if ~exist('base_speed', 'var')
        base_speed = 4; % [km/h]
    end

    slope = ascend / distance;
    theta = atand(slope);

    t = distance * (1/base_speed);
    if slope >= 0
        t = t + ascend * (1/0.6);
    elseif theta <= -5 && theta >= -12
        t = t - abs(ascend) * ((10/60)/0.3);
    elseif theta < -12
        t = t + abs(ascend) * ((10/60)/0.3);
    end

    w = distance ./ t;

end
