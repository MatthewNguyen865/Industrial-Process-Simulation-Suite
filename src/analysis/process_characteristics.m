function characteristics = process_characteristics(t, T, disturbance_time, input_initial, input_final)

    % Determine initial steady state
    initial_region = t >= 0.8 * disturbance_time & t < disturbance_time;
    initial_steady_state = mean(T(initial_region));

    % Determine final steady state
    final_region = t >= disturbance_time + 0.8 * (t(end) - disturbance_time);
    final_steady_state = mean(T(final_region));

    % Calculate process gain
    Kp = (final_steady_state - initial_steady_state)/(input_final - input_initial);

    % Calculate time constant
    T632 = initial_steady_state + 0.632 * (final_steady_state - initial_steady_state);
    after_dis = t > disturbance_time & t <= t(end);
    [~, index] = min(abs(T(after_dis) - T632));
    Tao = t(index);

    % Initialize Values
    characteristics.initial_steady_state = initial_steady_state;
    characteristics.final_steady_state = final_steady_state;
    characteristics.process_gain = Kp;
    characteristics.time_constant = Tao;
end