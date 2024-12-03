% may be totally bork'd, actively debugging

function dC = consumptionECM(dY, C, Y, P, params)
    % Parameters: params.alpha (adjustment speed), params.beta (price elasticity)
    % params.gamma (income elasticity)
    equilibrium = params.gamma * log(Y) - params.beta * log(P);
    dC = params.alpha * (equilibrium - log(C)) + dY;
end