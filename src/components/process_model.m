function dxdt = process_model(t, x, simulation)

    % Evaluate current process inputs
    inputs.Tin = simulation.process.inputs.Tin(t);
    inputs.Q = simulation.process.inputs.Q(t);

    % Run process model
    dxdt = simulation.process.model(t, x, simulation.process.params, inputs);

end