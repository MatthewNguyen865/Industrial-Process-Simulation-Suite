function plot_process_response(t, T, disturbance_time, characteristics)

    plot(t, T, 'LineWidth', 2)
    xlabel('Time (s)')
    ylabel('Temperature (K)')
    xline(disturbance_time, '--', sprintf('Inlet Temperature\nStep           '), 'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle', 'LabelHorizontalAlignment', 'left', 'Color', 'r', 'LineWidth', 1.2)

    yline(characteristics.initial_steady_state, '-', 'Color', 'b', 'LineWidth', 1.2)
    text(220, characteristics.initial_steady_state, 'Initial Steady State', 'VerticalAlignment', 'top', 'Color', 'b')
    yline(characteristics.final_steady_state, '-', 'Color', 'g', 'LineWidth', 1.2)
    text(220, characteristics.final_steady_state, 'Final Steady State', 'VerticalAlignment', 'bottom', 'Color', 'g')

    hold on
    % Plot estimated 63.2% response point
    t63 = characteristics.t63;
    plot(t63, characteristics.T632, 'o', 'MarkerSize', 7, 'LineWidth', 1.5)
    text(characteristics.t63, characteristics.T632, '  63.2% Response', 'VerticalAlignment', 'bottom')
    plot([disturbance_time t63], [characteristics.T632 characteristics.T632], '--', 'Linewidth', 1.2)
    text((disturbance_time + t63)/2, characteristics.T632, sprintf('\\tau = %.1f s', characteristics.time_constant), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center')
end