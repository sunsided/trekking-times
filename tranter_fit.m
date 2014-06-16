function tranter_fit
% TRANTER_FIT Fitting of functions into Tranter's correction table

    close all;
    
    % fetch Tranter's correction table
    [table, hours, fitness] = tranter_table();

    test_only = length(fitness);
    
    %{
    figure;
    colorset = get(gcf,'DefaultAxesColorOrder'); % fetch color set
    for i=1:length(fitness)       
        subplot(2,1,1);
        plot(hours, table(i,:), '-', 'Color', colorset(i,:)); hold on;
        
        subplot(2,1,2);
        loglog(hours, table(i,:), '-', 'Color', colorset(i,:)); hold on;
    end
    %}
    
    % define function under test
    %fn = @(t, fitness, a, b, c, d, e) a * exp((b*fitness + c)*log(t) + d*fitness + e);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5));
    
    %fn = @(t, fitness, a, b, c, d, e) a * exp((b*fitness + c)*log(t) + d*log(fitness) + e);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5));
    
    fn = @(t, fitness, a, b, c, d) a * exp(b*log(t) + c*log(fitness) + d);
    fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4));
    best = [0.3138       1.2097      0.81328      -1.7307];
    
    %fn = @(t, fitness, a, b, c, d) a * exp(b*log(t) + c*sqrt(fitness) + d);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4));
    
    %fn = @(t, fitness, a, b, c, d) a * exp(b*log(t) + c*log(fitness^2) + d);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4));
    
    %fn = @(t, fitness, a, b, c, d) a * exp(b*log(t.^2) + c*log(fitness^2) + d);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4));
        
    %fn = @(t, fitness, a, b, c, d, e, f, g) a * exp(b*log(c*fitness*t) + d*log(e*t) + f*log(fitness) + g);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5), args(6), args(7));
    
    %fn = @(t, fitness, a, b, c, d, e, f) (a*fitness + b) * exp((c*fitness + d)*log(t) + e*fitness + f);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5), args(6));
    
    %fn = @(t, fitness, a, b, c, d, e, f) a * exp((b*fitness + c)*log(t) + d*log(fitness) + e*fitness + f);
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5), args(6));
    
    %fn = @(t, fitness, a, b, c, d) (a*fitness + b)./(1+exp((c*fitness + d).*-log(t)));
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4));
    
    %fn = @(t, fitness, a, b, c, d, e, f, g ) (a*fitness+b).*t./sqrt(1+(e*fitness+f)+(c*fitness+d).*t.^2) + g;
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5), args(6), args(7));
    
    %fn = @(t, fitness, a, b, c, d, e, f, g, h) (a*fitness + b).*t.^3 + (c*fitness + d).*t.^2 + (e*fitness + f).*t + (g*fitness + h).*t;
    %fn_map = @(t, fitness, args) fn(t, fitness, args(1), args(2), args(3), args(4), args(5), args(6), args(7), args(8));
    
    % Select function under test
    function_under_test = fn_map;
    function_under_test_nargs = nargin(fn)-2;
    
    % minimize function under test
    
    minimum = Inf;
    best_it = 0;
    
    if ~exist('best', 'var')
        best = rand(1, function_under_test_nargs);
    end
    iterations = 1000;
    
    % Plot solution
    figure;
    colorset = get(gcf,'DefaultAxesColorOrder'); % fetch color set
    for i=1:test_only
        h_vector = 1:24;
        values = function_under_test(h_vector, fitness(i), best);
        
        subplot(2,1,1);
        plot(h_vector, values, '-', 'Color', colorset(i,:)); hold on;
        plot(hours, table(i,:), ':', 'Color', colorset(i,:));
        
        subplot(2,1,2);
        loglog(h_vector, values, '-', 'Color', colorset(i,:)); hold on;
        loglog(hours, table(i,:), ':', 'Color', colorset(i,:));
    end
    drawnow
    
    for i=1:iterations;
        disp(['Iteration ' num2str(i) ' of ' num2str(iterations) ' (best at ' num2str(best_it) ')']);
        %[x, fval] = ga(@determine_fitness, function_under_test_nargs);
        %[x, fval, exitflag] = patternsearch(@determine_fitness, rand(1, function_under_test_nargs));
        [x, fval, exitflag] = patternsearch(@determine_fitness, best);
        if fval < minimum
            disp(['Found new best case for f = ' num2str(fval)]);
            
            best_it = i;
            minimum = fval;
            best = x
            
            % plot new results
            
            subplot(2,1,1);
            hold off;
            
            subplot(2,1,2);
            hold off;
            
            for j=1:test_only
                h_vector = 1:24;
                values = function_under_test(h_vector, fitness(j), x);

                subplot(2,1,1);
                plot(h_vector, values, '-', 'Color', colorset(j,:)); hold on;
                plot(hours, table(j,:), ':', 'Color', colorset(j,:));

                subplot(2,1,2);
                loglog(h_vector, values, '-', 'Color', colorset(j,:)); hold on;
                loglog(hours, table(j,:), ':', 'Color', colorset(j,:));
            end
            
            drawnow;
        end
    end
    x = best;
       
    %[x, fval, exitflag] = patternsearch(@determine_fitness, zeros(1, function_under_test_nargs))
    
    hold off;
    colorset = get(gcf,'DefaultAxesColorOrder'); % fetch color set
    for i=1:test_only
        h_vector = 1:24;
        values = function_under_test(h_vector, fitness(i), best);
        
        subplot(2,1,1);
        plot(h_vector, values, '-', 'Color', colorset(i,:)); hold on;
        plot(hours, table(i,:), ':', 'Color', colorset(i,:));
        
        subplot(2,1,2);
        loglog(h_vector, values, '-', 'Color', colorset(i,:)); hold on;
        loglog(hours, table(i,:), ':', 'Color', colorset(i,:));
    end
    
    function [sum_of_squared_errors] = determine_fitness(arguments)
        % DETERMINE_FITNESS Determines the fitness of the global
        % function function_under_test by building the sum of squared
        % errors over all fitness series.
        
        sum_of_squared_errors = 0;
        for f_idx = 1:test_only; %length(fitness)
            expected_hours = table(f_idx, :);
            for h_idx = 1:length(hours)
                h_input = hours(h_idx);
                h_expected = expected_hours(h_idx);
                f = fitness(f_idx);
                
                % skip NaN values
                if isnan(h_expected)
                    continue;
                end
                
                % evaluate function
                h_calculated = function_under_test(h_input, f, arguments);
                
                % calculate error
                error = (h_expected - h_calculated)^2;
                sum_of_squared_errors = sum_of_squared_errors + error;
            end
        end
    end
    
end
