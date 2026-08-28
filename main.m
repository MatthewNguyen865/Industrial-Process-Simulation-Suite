clc;
clear;
close all;

addpath(genpath("src"));

simulation = heated_tank_config();
[t, T] = ode45(@(t, x) process_model(t, x, simulation), simulation.settings.tspan, simulation.process.x0);

plot(t, T)