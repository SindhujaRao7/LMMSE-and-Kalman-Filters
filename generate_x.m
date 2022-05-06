function [x] = generate_x(N,alpha,sigma_w)

% Create the signal x

x = zeros(N,1);
r_0 = (sigma_w) / (1 - alpha^2);
sigma_x = sqrt(r_0);
x_0 = sigma_x * randn(1,1); % random initialization

%First value of x is initialized
x(1) = x_0;
%Create x column vector of length N
for n = 2:N
    x(n) = alpha * x(n-1) + (sigma_w * randn(1,1)); % Add w noise 
end

end