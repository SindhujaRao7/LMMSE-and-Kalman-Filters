function [y] = generate_y(x,N,sigma_v)

% Create the signal y from x and sigma_v
y = zeros(N,1);
for n = 1:N
    y(n) = x(n) + (sigma_v * randn(1,1)); % Add v(n) noise
end
end