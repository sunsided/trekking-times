
% load original data
[table, hours, fitness] = tranter_table();

smooth_hours = hours(1):0.5:hours(end);
smooth_fitness = fitness(1):5:fitness(end);

% use derived function
fittable = zeros(length(smooth_fitness), length(smooth_hours));
for f=1:length(smooth_fitness)
    fittable(f, :) = tranter(smooth_hours, smooth_fitness(f));
end

close all;
figure('Name', 'Table vs. Synthetic Table');
subplot(2,1,1);
surf(hours, fitness, table);
zlim([0 50]);
title('Tranter''s table');
xlabel('Time [h]');
ylabel('Fitness [min]');
zlabel('Time'' [h]');

subplot(2,1,2);
surf(smooth_hours, smooth_fitness, fittable);
zlim([0 50]);
title('Synthetic table');
xlabel('Time [h]');
ylabel('Fitness [min]');
zlabel('Time'' [h]');

% use derived function
fittable = zeros(size(table));
for f=1:length(fitness)
    fittable(f, :) = tranter(hours, fitness(f));
end
fittable(isnan(table)) = NaN;

figure('Name', 'Error Plane');
surf(hours, fitness, table - fittable);
title('Error surface');
xlabel('Time [h]');
ylabel('Fitness [min]');
zlabel('Time'' Error [h]');


round(fittable*4)/4