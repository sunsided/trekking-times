function [tcorrected] = tranter(t, fitness)
% TRANTER Implementation of the best-fit candidate from tranter_fit()
    
    a = 0.31381;
    b = 1.2097;
    c = 0.81328;
    d = -1.7307;

    tcorrected = a * exp(b*log(t) + c*log(fitness) + d);

end