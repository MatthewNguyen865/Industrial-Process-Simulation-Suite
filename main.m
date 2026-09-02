clc;
clear;
close all;

addpath(genpath("src"));

simulation = heated_tank_config();
[t, T] = ode45(@(t, x) process_model(t, x, simulation), simulation.settings.tspan, simulation.process.x0);

plot(t, T)

characteristics = process_characteristics(t, T, simulation.process.disturbance_time, simulation.process.inputs.Tin_initial, simulation.process.inputs.Tin_final);

fprintf('Initial = %.4f K\n', characteristics.initial_steady_state);
fprintf('Final = %.4f K\n', characteristics.final_steady_state);
fprintf('Process gain = %.4f\n', characteristics.process_gain);
fprintf('Tao = %.4f S\n', characteristics.time_constant);