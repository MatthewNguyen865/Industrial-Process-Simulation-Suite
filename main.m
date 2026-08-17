clc;
clear;
close all;

addpath(genpath("src"));

simulation = heated_tank_config();
[t, T] = ode45(simulation.process.model, simulation.settings.tspan, simulation.process.x0);

plot(t, T)