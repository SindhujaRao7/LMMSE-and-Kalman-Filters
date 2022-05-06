function compare_wiener_kf_error_plots(x,y,n_0,sigma_v,sigma_w,alpha)

% iterate kalman filter function
%reuse from previous function
x_true = zeros(n_0,1);
x_estimate = zeros(n_0,1);
P_true = zeros(n_0,1);
P_predict = zeros(n_0,1);
BMSE_3_vector= zeros(n_0,1);

x_true(1) = x(1);
x_estimate(1) = x(1);
P_true(1) = 1;
P_predict(1) = 1;

%Get Errors for both Wiener and KF
for i= 1: n_0
    [x_true_pred_3, BMSE_3_vector(i)] = wiener_predictor(x, i, alpha,sigma_w);
end

for i = 2:n_0
    [x_true(i), x_estimate(i), P_true(i), P_predict(i)] = kf(y(i),sigma_v,sigma_w,x_true(i-1),P_true(i-1));
end

wiener_predict_error_at_n_0 =BMSE_3_vector(end);
fprintf('The Wiener-Predictor error at e.g n0 = 40 is: \n');
disp(wiener_predict_error_at_n_0);
kf_predict_error_at_n_0 = P_predict(end);
fprintf('And the Kalman-Filter Prediction error at e.g n0 = 40 is: \n');
disp(kf_predict_error_at_n_0);


%plot for all n0 till n0=40

figure
plot(BMSE_3_vector,'b');
hold on;
plot(P_predict,'r');
xlabel('n');
xlim([1 40])
ylabel('Predicted Errors');
ylim([0 1])
title('Wiener vs Kalman-Filter Predicted Error')
legend('Wiener','Kalman-Filter');

end
