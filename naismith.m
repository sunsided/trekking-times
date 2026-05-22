function [w, t, slope] = naismith(distance, ascend)
% NAISMITH Naismith's rule for hiking time estimation.
%   [w, t, slope] = NAISMITH(distance, ascend) returns the average walking
%   speed w, total time t and slope for a track of the given horizontal
%   distance and vertical ascent.
%
% IN:
%   distance and ascend in [km]
% OUT:
%   w in [km/h]
%   t in [h]
%   slope in [km/km]

    slope = ascend ./ distance;
    t = distance * (1/5) + ascend * (1/0.6);
    w = distance ./ t;

end
