function bacterial_abundance()
    % Here's some data!
    data_time = [0, 14, 19, 26, 28, 31, 33]; % Time in days
    data_W_abundance = [86.83, 68.97, 69.86, 32.70, 18.40, 40.25, 33.02]; % W abundance in %
    data_M_abundance = [13.17, 31.03, 30.14, 67.30, 81.60, 59.75, 66.98]; % M abundance in %

    % Initial parameter guess
    initial_params = [0.1, 0.1, 0.1, 0.1]; 
    % [r_W, r_M, alpha,  beta]
    
    % Parameter estimation
    options = optimset('Display','iter');
    est_params = fminsearch(@(params)cost_function(params, data_time, data_W_abundance, data_M_abundance), initial_params, options);
    
    %  the estimated parameters
    disp('Estimated parameters:');
    disp(['r_W: ', num2str(est_params(1))]);
    disp(['r_M: ', num2str(est_params(2))]);
    disp(['alpha: ', num2str(est_params(3))]);
    disp(['beta: ', num2str(est_params(4))]);
    
    % From here, we simulate and plot our results from start to finish
    %including some flagrant abuse of ode45
    [t, y] = ode45(@(t, y) model(t, y, est_params), [0, 33], [0.8683, 0.1317]);
    W_abundance = (100 * y(:, 1)) ./ (y(:, 1) + y(:, 2));
    M_abundance = (100 * y(:, 2)) ./ (y(:, 1) + y(:, 2));

    figure;

    hold on;
    plot(data_time, data_W_abundance, 'ro', 'MarkerSize', 8, 'DisplayName', 'Data W')
    plot(data_time, data_M_abundance, 'bo', 'MarkerSize', 8, 'DisplayName', 'Data M');
    plot(t, W_abundance, 'red-', 'LineWidth', 2, 'DisplayName', 'Model W');
    plot(t, M_abundance, 'blue-', 'LineWidth', 2, 'DisplayName', 'Model M');
    xlabel('Time (days)');
    ylabel('Abundance (%)');
    %an interesting title
    title('Bacterial Abundance Over Time Best Fit');
    %love the movable box
    legend('show');
    grid on;
    hold off;

end