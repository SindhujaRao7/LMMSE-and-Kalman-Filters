function [x_1,BMSE_1] = wiener_interpolator1(x,n_0,alpha,N,sigma_w)

%  Function to implement Part A (1)
%initialization
R = zeros(N,N);
r = zeros(N,1);
a = zeros(N,1);

%create Autocorrelation Matrix
for i = 1: N
    for j= 1: N
        if abs(i-j) < n_0
            R(i,j) = alpha ^ abs(i-j);
        else
            R(i,j) = alpha ^ abs(i-j+1);
        end
    end
end
%create the r vector using alpha
for i = 1: N
    if i < n_0
        r(i) = alpha ^ (n_0-i);
    else
        r(i) = alpha ^ (i -n_0 + 1);
    end
end

a = inv(R) * r;
%Get the estimate using interpolation
x_1 = dot(a, x);
%Intial value for r
r_0 = (sigma_w)/(1 - alpha^2);
%Get the BMSE
BMSE_1 = r_0 - (transpose(r)*inv(R)*r);

end
