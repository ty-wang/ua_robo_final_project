function score = score_params(params,n_hidden,activ1,activ2,T,max_steps,plot)

    [W1,b1,W2,b2] = params_to_weights(params,n_hidden);
    controller = @(t,y) nn_controller(y,W1,b1,W2,b2,activ1,activ2);
    total_dist = simulate_walker(T,max_steps,controller,plot);
    score = total_dist;



end