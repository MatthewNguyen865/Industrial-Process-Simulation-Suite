clc;
clear;
close all;

addpath(genpath("src"));

simulation = heated_tank_config();
t_start = simulation.settings.tspan(1);
t_end = simulation.settings.tspan(2);
t_dis = simulation.process.disturbance_time;

Tin_initial = simulation.process.inputs.Tin_initial;
Tin_final = simulation.process.inputs.Tin_final;

simulation_initial = simulation;
simulation_initial.process.inputs.Tin = @(t) Tin_initial;

simulation_final = simulation;
simulation_final.process.inputs.Tin = @(t) Tin_final;

[t1, T1] = ode45(@(t, x) process_model(t, x, simulation_initial), [t_start t_dis], simulation.process.x0);
[t2, T2] = ode45(@(t, x) process_model(t, x, simulation_final), [t_dis t_end], T1(end));

t = [t1; t2(2:end)];
T = [T1; T2(2:end)];

characteristics = process_characteristics(t, T, simulation.process.disturbance_time, simulation.process.inputs.Tin_initial, simulation.process.inputs.Tin_final);

fprintf('Initial = %.4f K\n', characteristics.initial_steady_state);
fprintf('Final = %.4f K\n', characteristics.final_steady_state);
fprintf('T(end) = %.6f K\n', T(end));
fprintf('Process gain = %.4f\n', characteristics.process_gain);
fprintf('Time constant = %.4f S\n', characteristics.time_constant);

plot_process_response(t, T, simulation.process.disturbance_time, characteristics);