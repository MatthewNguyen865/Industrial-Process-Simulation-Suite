clc;
clear;
close all;

addpath(genpath("src"));

simulation = heated_tank_config();
Tin_final_cases = [293.15 288.15 283.15];

t_start = simulation.settings.tspan(1);
t_end = simulation.settings.tspan(2);
t_dis = simulation.process.disturbance_time;

results = struct();

for i = 1:length(Tin_final_cases)

    simulation_case = simulation;

    simulation_case.process.inputs.Tin_final = Tin_final_cases(i);

    Tin_initial = simulation_case.process.inputs.Tin_initial;
    Tin_final = simulation_case.process.inputs.Tin_final;

    simulation_initial = simulation_case;
    simulation_initial.process.inputs.Tin = @(t) Tin_initial;

    simulation_final = simulation_case;
    simulation_final.process.inputs.Tin = @(t) Tin_final;

    [t1, T1] = ode45(@(t, x) process_model(t, x, simulation_initial), [t_start t_dis], simulation_case.process.x0);
    [t2, T2] = ode45(@(t, x) process_model(t, x, simulation_final), [t_dis t_end], T1(end));

    t_case = [t1; t2(2:end)];
    T_case = [T1; T2(2:end)];

    results(i).Tin_final = Tin_final;
    results(i).t = t_case;
    results(i).T = T_case;

    results(i).characteristics = process_characteristics(t_case, T_case, t_dis, Tin_initial, Tin_final);
end

plot_process_comparison(results, t_dis);