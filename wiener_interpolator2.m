function [x_2,BMSE_2] = wiener_interpolator2(x, n_0, alpha,sigma_w)

%  Function to implement Part A (2) for observations x[n_0 - 1] and x[n_0 +
%  1] only

%Predicted value at n_0
x_2 = (alpha / (1 + alpha^2)) * (x(n_0-1) + x(n_0 + 1));

r_0 = sigma_w / (1 - alpha^2);
r_1 = alpha * r_0;
r_2 = alpha * r_1;
r = transpose([r_1, r_1]);
R = [r_0, r_2; r_2, r_0];

%BMSE for this interpolation
BMSE_2 = r_0 - transpose(r)*inv(R)*r;

end