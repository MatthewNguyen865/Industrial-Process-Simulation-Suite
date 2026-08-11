function dxdt = test_model(~, x, params)

%Calculate derivative

dxdt = -params.k * x;

end