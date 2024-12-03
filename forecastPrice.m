function P_forecast = forecastPrice(P, order)
    model = arima(order(1), order(2), order(3));
    fitModel = estimate(model, P);
    [P_forecast, ~] = forecast(fitModel, 1); % Predict one step ahead
end