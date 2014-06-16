actual_track_length  = 10;
actual_ascend_length = (0:.1:10);

[speed, duration, slope] = naismith(actual_track_length, actual_ascend_length);

close all;
plot(rad2deg(atan(slope)), speed);
title('Naismith''s rule');
xlabel('slope [\circ]');
ylabel('walking speed [km/h]');
grid on;