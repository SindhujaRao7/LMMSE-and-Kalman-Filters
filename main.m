
%main function to call respective functions
clc;
clear all;
%As per requirement
N = 100;
n_0 = 40;
sigma_v = 1;
sigma_w = 0.36;
alpha = 0.8;
realz=1000;

%required functions
[x] = generate_x(N,alpha,sigma_w); %Create Data set x
[x_1,BMSE_1] = wiener_interpolator1(x,n_0,alpha,N,sigma_w); %Part B (1)
[x_2,BMSE_2] = wiener_interpolator2(x,n_0,alpha,sigma_w); %Part B (2)
[x_3,BMSE_3] = wiener_predictor(x, n_0, alpha,sigma_w); %Part B (3)
wiener_plots(alpha,n_0,realz,N,sigma_w); %Part B (4)
[y] = generate_y(x,N,sigma_v); %Create output data set
kf_plots(x,y,n_0,sigma_v,sigma_w); %Part B (5), includes the kf function
compare_wiener_kf_error_plots(x,y,n_0,sigma_v,sigma_w,alpha); %Part B (6), running for values till n0=1:40, can be changed to any value between 1:100



