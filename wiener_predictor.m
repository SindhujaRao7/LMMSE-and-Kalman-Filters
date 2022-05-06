function [x_3,BMSE_3] = wiener_predictor(x, n_0, alpha,sigma_w)

%  Function to implement Part A (3) for stticly past values <n0=40

%initialization
R = zeros(n_0-1,n_0-1);
r = zeros(n_0-1,1);
a = zeros(n_0-1,1);
%Create new data set with past values
x1 = x(1:n_0-1,:);

for i = 1:n_0-1
    for j = 1:n_0-1
        if abs(i - j) < n_0-1
            R(i,j) = alpha ^ abs(i - j);
        else
            R(i,j) = alpha ^ abs(i - j + 1);
        end
    end
end


for i = 1:n_0-1
    if i < n_0-1
        r(i) = alpha ^ ((n_0-1) - i);
    else
        r(i) = alpha ^ (i - (n_0-1) + 1);
    end
end
a = inv(R) * r;
x_3 = dot(a, x1);
r_0 = sigma_w / (1 - alpha ^ 2);
%BMSE for this Predictor
BMSE_3 = r_0 - transpose(r) * inv(R) * r;

end