function simulation = heated_tank_config()

% Process parameters
simulation.process.params.rho = 1000;
simulation.process.params.V = 1;
simulation.process.params.Cp = 4180;
simulation.process.params.F = 0.01;
simulation.process.params.UA = 100;
simulation.process.params.Tamb = 298.15;

% Process inputs
simulation.process.inputs.Tin = @inlet_temperature;
simulation.process.inputs.Q = @(t) 5000;

simulation.process.inputs.Tin_initial = 298.15;
simulation.process.inputs.Tin_final = 293.15;

% Process conditions
simulation.process.x0 = 298.15;
simulation.process.disturbance_time = 200;

% Simulation settings
simulation.settings.tspan = [0 500];

% Process model
simulation.process.model = @heated_tank;

function Tin = inlet_temperature(t);

    if t < simulation.process.disturbance_time;
        Tin = simulation.process.inputs.Tin_initial;
    else
        Tin = simulation.process.inputs.Tin_final;
    end

end

end