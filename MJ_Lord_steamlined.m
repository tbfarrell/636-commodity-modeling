% Latest historical data
% Hard baked in because time crunch. Shit.

%n=11;
%prices = (corn(end-n:end-9)); % Column vector
%prices_too = (corn(end-9:end));
%production = (production(end-n:end-9));
%consumption = (consumption(end-n:end-9));

%sample values: 

n=11;
m=n-11;
prices = (corn(end-n:end-m)); % Column vector
prices_too = (corn(end-m:end));
production = (production(end-n:end-m));
consumption = (consumption(end-n:end-m));


% Initialize variables
latestPrice = prices(end);
latestProduction = production(end);
latestConsumption = consumption(end);

% Consumption ECM parameters
params.alpha = 0.5;  % Adjustment speed
params.beta = -0.2;  % Price elasticity
params.gamma = 1.0;  % Income elasticity

% Production dynamics parameters
coeffs.impact = 0.1;  % Immediate price elasticity
coeffs.lagged = 0.05; % Lagged price elasticity
lags = 3;             % Lag periods

% Forecast settings
forecastSteps = n-1; % Number of steps to forecast
futurePrices = zeros(forecastSteps, 1); % Placeholder for future prices

% Placeholder for GDP growth
% still using the dY handle
dY = 0.03; % Example: 3% growth rate

% Forecast loop
for t = 1:forecastSteps
    % Update consumption using ECM
    % This has some changes to it
    latestConsumption = consumptionECM(dY, latestConsumption, ...
                                        1.02^(length(prices) + t), latestPrice, params);

    % Update production using production dynamics
    latestProduction = productionDynamics([prices; futurePrices], length(prices) + t, lags, coeffs);

    % Supply-demand balance
    supplyDemandBalance = latestProduction - latestConsumption;

    % Update price with constraints
    % added a rand() function in the eleventh hour. Try it
  %  priceChange = 0.1 * supplyDemandBalance; % Scaling factor
     priceChange = 0.1 * supplyDemandBalance; % Scaling factor

    latestPrice =max(latestPrice + priceChange, 0.01); % Ensure price is non-negative

    % For models that include random walk elements:
    % latestPrice = max(latestPrice*((2*rand(1)-1)*1.05) + priceChange, 0.01);


    % Store results
    futurePrices(t) = latestPrice;

    % Debugging output because fuck
    disp(['Step ', num2str(t)]);
    disp(['Latest Price: ', num2str(latestPrice)]);
    disp(['Production: ', num2str(latestProduction)]);
    disp(['Consumption: ', num2str(latestConsumption)]);
end


% Combine historical and forecasted prices
allPrices = [prices; futurePrices];

% Time vector
time = 1:length(allPrices);

% Plot
figure;
plot(1:length(prices), prices, 'b', 'LineWidth', 1.5); % Historical prices
hold on;
plot(length(prices)+1:length(allPrices), prices_too, 'g', 'LineWidth', 1.5); %actual prices

plot(length(prices)+1:length(allPrices), futurePrices, 'r--', 'LineWidth', 1.5); % Forecasted prices
xlabel('Time');
ylabel('Price (Normalized)');
legend('Historical Prices', 'Actual Prices', 'Forecasted Prices');
title('Corn Price Forecast');
grid on;

