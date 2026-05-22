function [tcorrected] = tranter(t, fitness)
% TRANTER Best-fit Tranter correction for Naismith times.
%   tcorrected = TRANTER(t, fitness) returns the Tranter-corrected hiking
%   time for a Naismith base time t and Tranter fitness level. The
%   underlying function is the best-fit candidate obtained from
%   tranter_fit().
%
% IN:
%   t       Naismith base time [h]
%   fitness Tranter fitness level [min]
% OUT:
%   tcorrected Corrected hiking time [h]

    a = 0.31381;
    b = 1.2097;
    c = 0.81328;
    d = -1.7307;

    tcorrected = a * exp(b*log(t) + c*log(fitness) + d);

end
