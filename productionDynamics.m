function Qt = productionDynamics(P, t, lags, coeffs)
    % P: Full price vector
    % t: Current time step
    % lags: Number of lag periods
    if t > lags
        Qt = coeffs.impact * P(t-1) + coeffs.lagged * mean(P(t-lags:t-1));
    else
        Qt = 0; % Handle initial time steps where lags are insufficient
    end
end
