function kf_plots(x,y,n_0)
% iterate kalman filter function
x_true = zeros(n_0,1);
x_estimate = zeros(n_0,1);
P_true = zeros(n_0,1);
P_predict = zeros(n_0,1);

x_true(1) = x(1);
x_estimate(1) = x(1);
P_true(1) = 1;
P_predict(1) = 1;

%Get true and estimate value and errors for each n0
for i = 2:n_0
    [x_true(i), x_estimate(i), P_true(i), P_predict(i)] = kf(y(i), sigma_v, sigma_w, x_true(i-1),P_true(i-1));
end

%plot x true vs estimate x
figure
plot(x_true,'b');
hold on;
plot(x_estimate,'r');
xlabel('n');
xlim([1 40])
ylabel('Signal x(n)');
ylim([-2 2])
title('True vs Estimated X')
legend('x true','x estimate');

%plot true vs predicted error
figure
plot(P_true,'b');
hold on;
plot(P_predict,'r');
xlabel('n');
xlim([1 40])
ylabel('Error P');
ylim([-1 1])
title('True vs Predicted Error P')
legend('P true','P predicted');

end