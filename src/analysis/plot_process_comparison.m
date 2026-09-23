function plot_process_comparison(results, disturbance_time)

    figure
    hold on

    for i = 1:length(results)
        plot(results(i).t, results(i).T, 'LineWidth', 2)
    end

    xlabel('Time (s)')
    ylabel('Temperature (K)')
    title('Process Response to Different Inlet Temperature Disturbances')

    legend( ...
    'Tin_{final} = 293.15 K', ...
    'Tin_{final} = 288.15 K', ...
    'Tin_{final} = 283.15 K', ...
    'Location', 'best')

    xline(disturbance_time, '--', 'Inlet Temperature Step', 'LabelVerticalAlignment', 'middle', 'HandleVisibility', 'off')

    hold off

end