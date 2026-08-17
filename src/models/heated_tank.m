function dTdt = heated_tank(~, T, params, inputs)

% Calculate temperature derivative
dTdt = (params.rho * params.F * params.Cp * (inputs.Tin - T) + inputs.Q - params.UA * (T - params.Tamb))/(params.rho * params.V * params.Cp);

end