clc;
clear;
close all;

addpath(genpath("src"));

simulation.process.params.k = 0.1;
simulation.process.model = @(t, x) test_model(t, x, simulation.process.params);
simulation.settings.tspan = [0 50];
simulation.process.x0 = 10;
[t, x] = ode45(simulation.process.model, simulation.settings.tspan, simulation.process.x0);

plot(t, x)