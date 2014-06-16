function [series] = tranter_ts(interpolate)
% TRANTER_TS Generates timeseries objects from tranter_table()
% OUT:
%   Array of timeseries objects

    % set default value
    if ~exist('interpolate', 'var')
        interpolate = false;
    end

    % fetch Tranter's correction table
    [table, hours, fitness] = tranter_table();

    % get number of series and preallocate timeseries array
    num_series = size(table, 1);
    series = repmat(timeseries(), num_series, 1);

    % generate timeseries from data table
    for i = 1:num_series

        % cache data
        t_row = table(i, :);
        h = hours; % convert to seconds
        f = fitness(i);

        % build timeseries
        ts = timeseries(t_row, h, ...
                    'name', ['Corrected time (hours) for fitness = ' num2str(f)]);
        ts.UserData = f;
        ts.TimeInfo.Units = 'hours';
        ts.TreatNaNasMissing = true;
        
        % resample timeseries if requested
        if interpolate
            ts = resample(ts, hours(1):1:hours(end));
        end
        
        % register series with array
        series(i) = ts;
    end
    
    plot(series(3));
end
