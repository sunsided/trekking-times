function [w] = tobler(slope, scale)
% TOBLER Calculates walking speed according to Tobler's rule
% IN:
%   slope Slope in [tan(degree)]
%   scale Path scale factor (i.e. 1 for footpaths, 0.6 for off-path)
% OUT:
%   (optional) Walking speed in [km/h]
%              If no output argument is given, a curve plot will be shown
% EXAMPLE:
%   slope_degree = 10; 
%   v = tobler(tand(slope_degree))
    
    % If output arguments are given, return the speed
    if nargout > 0
        
        if ~exist('slope', 'var')
            slope = 0;
        end    
    
        if ~exist('scale', 'var')
            scale = 1;
        end    
        
        w = f(slope, scale);
        
    else % If not output arguments are given, plot the curve
        s_labels = -70: 1 : 70;
        s_axis = tan(deg2rad(s_labels));
        v_footpath = f(s_axis, 1);
        v_offpath  = 0.6*v_footpath;

        figure('name', 'Tobler''s hiking function');
        
        % set line styles
        style_1 = '-';
        style_06 = '-';
        if nargin == 2
            if scale == 1 
                style_06 = ':';
            elseif scale == 0.6
                style_1 = ':';
            else
                style_1 = ':';
                style_06 = ':';
            end
        end
        
        % plot base lines
        plot(s_labels, v_footpath, style_1, s_labels, v_offpath, style_06);
        
        % plot user line
        if nargin == 2 && scale ~= 1 && scale ~= 0.6
            s_labels = -70: 1 : 70;
            s_axis = tan(deg2rad(s_labels));
            v_user = f(s_axis, scale);

            hold on;
            plot(s_labels, v_user, 'm');
            legend('footpaths (s=1)', 'off-path (s=0.6)', sprintf('s=%.2f', scale));
        else
            legend('footpaths (s=1)', 'off-path (s=0.6)');
        end

        % plot labels
        title('Tobler''s hiking function');
        xlabel('slope [\circ]');
        ylabel('walking speed [km/h]');
        grid on;
            
        % plot user points
        if nargin == 2
            v_user = f(slope, scale);
            hold on;
            hu = plot(rad2deg(atan(slope)), v_user, 'or');
            
            % append to legend
            [~,~,OUTH,OUTM] = legend;
            legend([OUTH;hu],OUTM{:}, ...
                sprintf('v(%.2f\\circ, %.2f) = %.2f km/h', atand(slope), scale, v_user));
            
            t = sprintf('Tobler walking speed at %.2f\\circ = %.2f km/h', ...
                        rad2deg(atan(slope)), v_user);
            title(t);
        elseif nargin == 1
            v_user_footpath = f(slope, 1);
            v_user_offpath = 0.6 * v_user_footpath;
            hold on;
            hu(1) = plot(rad2deg(atan(slope)), v_user_footpath, 'or'); hold on;
            hu(2) = plot(rad2deg(atan(slope)), v_user_offpath, 'om');
            
            % append to legend
            [~,~,OUTH,OUTM] = legend;
            legend([OUTH;hu(1);hu(2)],OUTM{:}, ...
                sprintf('v(%.2f\\circ, %.1f) = %.2f km/h', atand(slope), 1, v_user_footpath), ...
                sprintf('v(%.2f\\circ, %.1f) = %.2f km/h', atand(slope), 0.6, v_user_offpath));
            
            t = sprintf('Tobler walking speed at %.2f\\circ = %.2f .. %.2f km/h', ...
                        rad2deg(atan(slope)), v_user_offpath, v_user_footpath);
            title(t);
        end
        
        clear v;
    end
    
    % Internal calculation function
    function [w] = f(slope, scale)
        w = scale*6*exp(-3.5 * abs(slope+0.05));
    end
    
end