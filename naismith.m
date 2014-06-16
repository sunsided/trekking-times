function [w, t, slope] = naismith(length, ascend)
% NAISMITH_AL Naismith's rule
% IN: 
%   length and ascend in [km]
% OUT:
%   w in [km/h]
%   t in [h]
%   slope in [km/km]

    slope = ascend/length;
    t = length*(1/5) + ascend*(1/0.6);
    w = length./t;

end