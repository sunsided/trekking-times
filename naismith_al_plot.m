clear all;
actual_track_length  = 10;
actual_ascend_length = (-10:.001:10);

i = 1;
for a=actual_ascend_length
    [speed(i), duration(i), slope(i)] = naismith_al(actual_track_length, a, 4);
    i = i+1;
end

speed(abs(diff(speed)) > 0.1) = NaN;

close all;
plot(rad2deg(atan(slope)), speed, 'b', 'MarkerSize', 1); hold on;

i = 1;
for a=actual_ascend_length
    [speed(i), duration(i), slope(i)] = naismith_al(actual_track_length, a, 5);
    i = i+1;
end

speed(abs(diff(speed)) > 0.1) = NaN;

plot(rad2deg(atan(slope)), speed, 'r', 'MarkerSize', 1); hold on;

title('Naismith''s rule with Aitken-Langmuir corrections');
ylim([0 13]);
xlabel('slope [\circ]');
ylabel('walking speed [km/h]');

legend('4 km/h', '5 km/h');

grid on;