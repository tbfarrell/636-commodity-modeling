% Requires Econometrics Toolbox to run
% Currently working on a generalized form that allows comparison with
% Corn and soybean

data = readtable('Cut_stats_sugar.xlsx');
dates = datetime(data.Date, 'InputFormat', 'MM/yyyy'); % Adjust format as needed

% This is where variables from an .xlsx file may go
sugarEU = data.Sugar_EU;
sugarUS = data.Sugar_US;
sugarWorld = data.Sugar_World;

% Fill missing data (e.g., linear interpolation)
sugarEU = fillmissing(sugarEU, 'linear');
sugarUS = fillmissing(sugarUS, 'linear');
sugarWorld = fillmissing(sugarWorld, 'linear');

% Normalize prices for modeling
sugarWorldNorm = sugarWorld / mean(sugarWorld, 'omitnan');


% Example Parameters
% By all means, feel free to play with these
params.alpha = 0.5; % Adjustment speed
params.beta = -0.2; % Price elasticity
params.gamma = 1.0; % Income elasticity
coeffs.impact = 0.1; % Immediate response
coeffs.lagged = 0.05; % Lagged response
lags = 3; % Lag periods

% Prepare storage for simulation
T = length(dates);
consumption = zeros(T, 1);
production = zeros(T, 1);

% Initialize
consumption(1) = sugarWorld(1);
production(1) = sugarWorld(1);

% Run Simulation
for t = 2:T
    dY = 0.03; % Placeholder for GDP growth
    consumption(t) = consumptionECM(dY, consumption(t-1), 1.02^t, sugarWorld(t), params);
    production(t) = productionDynamics(sugarWorld, t, lags, coeffs);
end

% Forecast Prices
P_forecast = forecastPrice(sugarWorld, [1, 1, 1]);

%for debugging
disp(size(dates));
disp(size(consumption));
disp(class(dates));
disp(class(consumption));
disp(size(production));
disp(class(production));


figure;
hold on;
plot(dates, sugarWorld, 'b', 'LineWidth', 1.5);
plot(dates, sugarEU, 'r', 'LineWidth', 1.5);
plot(dates, sugarUS, 'g', 'LineWidth', 1.5);

%plot(dates, consumption, 'p', 'LineWidth', 1.5);


%plot(dates, production, 'y', 'LineWidth', 1.5);
%legend('Sugar Prices', 'Consumption',  'Production');


legend('World Price', 'EU Price', 'US Price','production');

xlabel('Time');
ylabel('Normalized Values');
%title('Commodity Market Dynamics');
title('Sugar Market Prices');
grid on;
