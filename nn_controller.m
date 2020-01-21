function F = nn_controller(y,W1,b1,W2,b2,activ1,activ2)

    %simple 1 layer neural network with weights and biases W1, b1, W2, b2
    %and activation functions activ1 and activ2

    a1 = W1*y + b1;
    z1 = activ1(a1);
    a2 = W2*z1 + b2;
    F = activ2(a2);

    


end

