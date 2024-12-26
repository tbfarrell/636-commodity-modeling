% Requires Econometrics Toolbox to run
% Currently working on a generalized form that allows comparison with
% Corn and soybean

data = readtable('Cut_stats.xlsx');
dates = datetime(data.Date, 'InputFormat', 'MM/yyyy'); % Adjust format as needed

% This is where variables from an .xlsx file may go
sugar = data.Sugar;
corn = data.Corn;
soybean = data.Soybean;
pumpkin = data.Pumpkin_k;

% Fill missing data (e.g., linear interpolation)
sugar = fillmissing(sugar, 'linear');
corn = fillmissing(corn, 'linear');
soybean = fillmissing(soybean, 'linear');
pumpkin = fillmissing(pumpkin, 'linear');

% Normalize prices for modeling
sugarWorldNorm = sugar / mean(sugar, 'omitnan');
%to specify the 'omitnan' option for the nanflag input argument.


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
consumption(1) = sugar(1);
production(1) = sugar(1);

% Run Simulation
for t = 2:T
    dY = 0.03; % Placeholder for GDP growth
    consumption(t) = consumptionECM(dY, consumption(t-1), 1.02^t, sugar(t), params);
    production(t) = productionDynamics(sugar, t, lags, coeffs);
end

% Forecast Prices
P_forecast = forecastPrice(sugar, [1, 1, 1]);

%for debugging
disp(size(dates));
disp(size(consumption));
disp(class(dates));
disp(class(consumption));
disp(size(production));
disp(class(production));

% stop
% ^ un-comment this interupter line to halt the script before it can 
% graph the results, if you dont want it generating visuals with each
% iteration

figure;
hold on;
plot(dates+74, sugar, 'b', 'LineWidth', 1.5);
plot(dates+74, corn, 'r', 'LineWidth', 1.5);
plot(dates+74, soybean, 'g', 'LineWidth', 1.5);
plot(dates+74, pumpkin, 'y', 'LineWidth', 1.5);

plot(dates, consumption, 'm', 'LineWidth', 1.5);


plot(dates, production, 'k', 'LineWidth', 1.5);
%legend('Sugar Prices', 'Consumption',  'Production');


legend('Sugar Price', 'Corn Prices', 'Soybean Prices','Pumpkin Prices','consumption','production');

xlabel('Time');
ylabel('Normalized Values');
%title('Commodity Market Dynamics');
title('World Market Prices');
grid on;
