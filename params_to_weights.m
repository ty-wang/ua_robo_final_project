function [W1,b1,W2,b2] = params_to_weights(params,n_hidden)

    W1_shape = [n_hidden,4];
    n_W1 = W1_shape(1)*W1_shape(2);
    b1_shape = [n_hidden,1];
    n_b1 = b1_shape(1);
    W2_shape = [1, n_hidden];
    n_W2 = W2_shape(1)*W2_shape(2);
    b2_shape = [1,1];
    n_b2 = b2_shape(1);

    W1 = reshape(params(1:n_W1),W1_shape);
    b1 = reshape(params(n_W1+1:n_W1+n_b1),b1_shape);
    W2 = reshape(params(n_W1+n_b1+1:n_W1+n_b1+n_W2),W2_shape);
    b2 = params(end);
    
    

end
