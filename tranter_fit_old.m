clear all; close all;
[table, hours, fitness] = tranter_table();
       
figure;
surf(hours, fitness, table);
title('Tranter''s corrections to Naismith''s rule');
xlabel('hours [h]');
ylabel('fitness [min]');
zlabel('corrected hours [h]');
       
%coeffs = polyfit(hours, tranter(1,:), 3)
%t      = 2:24;
%tstar  = polyval(coeffs, t);

count = length(hours);
approx = nan(size(table, 1), count);
for i=1:size(table,1)
    times = table(i,:);
    hour_vector = hours;

    % trim times that are not available
    no_time_idx = find(isnan(times), 1, 'first');
    if ~isempty(no_time_idx)
        hour_vector = hour_vector(1:no_time_idx-1);
        times = times(1:no_time_idx-1);
    end
    
    coeffs(i,:)        = polyfit(log(hour_vector), log(times), 1)
    approximated_hours = exp(polyval(coeffs(i,:), log(hour_vector)));
    
    if ~isempty(no_time_idx)
        append = count - no_time_idx + 1;
        approximated_hours = [approximated_hours nan(1, append)];
    end
    
    approx(i, :) = approximated_hours;
end

mean_slope = mean(coeffs(1:6,1))
std_slope  = std(coeffs(1:6,1))
coeffs(:,1) = mean_slope;

%figure;
%semilogy(coeffs(:,2))
%return

%for i=1:6
%    coeffs(i,2) = coeffs(1,2) + mean(diff(coeffs(:,2)))*(i-1)
%end

% build legend strings
egend_titles= {};
for i=1:size(table,1)
    legend_titles{i} = sprintf('e^{(%.2f*ln(t)%+.2f)}', coeffs(i,1), coeffs(i,2));
end

close all;
ax(1) = subplot(2,1,1);
loglog(hours, table(1,:), ...
       hours, table(2,:), ...
       hours, table(3,:), ...
       hours, table(4,:), ...
       hours, table(5,:), ...
       hours, table(6,:));

title('Tranter''s corrections to Naismith''s rule');
legend('15 min (fit)', '20 min', '25 min', '30 min', '40 min', '50 min (unfit)');
xlabel('hours [h]');
ylabel('adjusted hours [h]');

ax(2) = subplot(2,1,2);
loglog(hours, approx(1,:), ...
       hours, approx(2,:), ...
       hours, approx(3,:), ...
       hours, approx(4,:), ...
       hours, approx(5,:), ...
       hours, approx(6,:));

title('linearized Tranter''s corrections');
legend(legend_titles);
xlabel('hours [h]');
ylabel('adjusted hours [h]');
linkaxes(ax, 'xy');

patched_hours = [0 1 hours];

% re-approximate over full time
approx = [];
for i=1:size(table,1)
    approx(i,:) = exp(polyval(coeffs(i,:), log(patched_hours)));
end 
 
figure;
ax(1) = subplot(2,1,1);
plot(hours, table(1,:), ...
     hours, table(2,:), ...
     hours, table(3,:), ...
     hours, table(4,:), ...
     hours, table(5,:), ...
     hours, table(6,:));
title('Tranter''s corrections to Naismith''s rule');
xlabel('hours [h]');
ylabel('adjusted hours [h]');
grid on;

ax(2) = subplot(2,1,2);
plot(patched_hours, approx(1,:), ...
     patched_hours, approx(2,:), ...
     patched_hours, approx(3,:), ...
     patched_hours, approx(4,:), ...
     patched_hours, approx(5,:), ...
     patched_hours, approx(6,:));
title('linearized Tranter''s corrections');
xlabel('hours [h]');
ylabel('adjusted hours [h]');
grid on;

 linkaxes(ax, 'xy');
 
%{ 
figure;
for i=1:size(tranter,1)
    e = tranter(i,:) - approx(i,:);
    %errorbar(log(hours), log(approx(i,:)), e);
    plot(hours, e);
    hold on;
end

figure;
for i=1:size(tranter,1)
    approxf = exp(mean_slope*log(hours) + coeffs(i,2));
    loglog(hours, approx(i,:), 'b'); hold on;
    loglog(hours, approxf, 'r');
end
%}