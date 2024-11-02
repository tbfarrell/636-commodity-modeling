function dydt = model(t, y, params)
    % Unpacking the parameters
    r_W = params(1);
    r_M = params(2);
    alpha = params(3);
    beta = params(4);
    
    %initialize some values

    W = y(1);
    M = y(2);
    
    %these are the dif eqs we described in question five
    dWdt = r_W * W * (1 - W - alpha * M);
    dMdt = r_M * M * (1 - M - beta * W);
    
    dydt = [dWdt; dMdt];
end