clc
clear
close all

Fs = 1000;
T = 1;
t = 0:1/Fs:T;

tx = zeros(size(t));
tx(1:30) = 1;

rx = zeros(size(t));

d1 = 120;
d2 = 300;

rx(d1:d1+29) = 0.9;
rx(d2:d2+29) = 0.7;

rx = rx + 0.15*randn(size(rx));

threshold = 0.5;
locs = [];
peaks = [];

for i = 2:length(rx)-1
    if rx(i) > rx(i-1) && rx(i) > rx(i+1) && rx(i) > threshold
        locs = [locs i];
        peaks = [peaks rx(i)];
    end
end

c = 3e8;
delay = locs/Fs;
distance = (c*delay)/2;

figure
plot(t,tx,"LineWidth",2)
title("Transmitted Pulse")
ylim([-0.2 1.5])
grid on

figure
plot(t,rx)
title("Received Signal")
grid on

figure
plot(t,rx)
hold on
plot(locs/Fs,peaks,"ro","MarkerSize",8,"MarkerFaceColor","r")
title("Detected Targets")
grid on

disp("Detected Targets")

for i = 1:length(distance)
    printf("Target %d : %.2f meters\n",i,distance(i));
end
