function cost = cost_function(params, data_time, data_W_abundance, data_M_abundance)
    [~, y] = ode45(@(t, y) model(t, y, params), data_time, [0.8683, 0.1317]);
    W_abundance = (100 * y(:, 1)) ./ (y(:, 1) + y(:, 2));
    M_abundance = (100 * y(:, 2)) ./ (y(:, 1) + y(:, 2));
    cost = sum((data_W_abundance - W_abundance').^2) + sum((data_M_abundance - M_abundance').^2);
    %least square method
end