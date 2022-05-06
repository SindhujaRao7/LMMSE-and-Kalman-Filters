function wiener_plots(alpha,n_0,realz,N,sigma_w)

%     Function to plot Theoretical and Bayesian MSE for all three Wiener interpolators/Predictors
% Run for different values of alpha between 0.1 and 0.9 over 1000 realizations

alpha_vector = transpose(.1:.1:.9);

%Initializations
TMSE_1 = zeros(size(alpha_vector));
TMSE_2 = zeros(size(alpha_vector));
TMSE_3 = zeros(size(alpha_vector));
BMSE_1 = zeros(size(alpha_vector));
BMSE_2 = zeros(size(alpha_vector));
BMSE_3 = zeros(size(alpha_vector));

for j = 1: size(alpha_vector)
    TMSE_1_a = zeros(realz,1);
    TMSE_2_a = zeros(realz,1);
    TMSE_3_a = zeros(realz,1);
    BMSE_1_a = zeros(realz,1);
    BMSE_2_a = zeros(realz,1);
    BMSE_3_a = zeros(realz,1);

    x = generate_x(N,alpha,sigma_w);
    x_true = x(n_0);
    %reassign x without x(n_0)
    x(x == x(n_0)) = 0;
    %Call each function to get both errors for each alpha value
    for i= 1: realz
        [x_true_pred_1, BMSE_1_a(i)] = wiener_interpolator1(x, n_0, alpha_vector(j),N,sigma_w);
        %disp(alpha_vector(j));
        [x_true_pred_2, BMSE_2_a(i)] = wiener_interpolator2(x, n_0, alpha_vector(j),sigma_w);
        [x_true_pred_3, BMSE_3_a(i)] = wiener_predictor(x, n_0, alpha_vector(j),sigma_w);
        TMSE_1_a(i) = (x_true - x_true_pred_1) ^ 2;
        TMSE_2_a(i) = (x_true - x_true_pred_2) ^ 2;
        TMSE_3_a(i) = (x_true - x_true_pred_3) ^ 2;

        %Average Errors over realizations
        BMSE_1(j) = sum(BMSE_1_a) / realz;
        BMSE_2(j) = sum(BMSE_2_a) / realz;
        BMSE_3(j) = sum(BMSE_3_a) / realz;
        TMSE_1(j) = sum(TMSE_1_a) / realz;
        TMSE_2(j) = sum(TMSE_2_a) / realz;
        TMSE_3(j) = sum(TMSE_3_a) / realz;
    end
end
%Plot aplha vs MSEs
%Wiener Interpolator 1
figure
plot(alpha_vector,BMSE_1,'b');
hold on;
plot(alpha_vector,TMSE_1,'r');
xlabel('Alpha');
xlim([0.1 0.9])
ylabel('Mean-Squared Error');
ylim([0 1])
title('Wiener interpolator 1')
legend('BMSE','TMSE');

%Wiener Interpolator 2
figure
plot(alpha_vector,BMSE_2,'b');
hold on;
plot(alpha_vector,TMSE_2,'r');
xlabel('Alpha');
xlim([0.1 0.9])
ylabel('Mean-Squared Error');
ylim([0 1])
title('Wiener interpolator 2')
legend('BMSE','TMSE');

%Wiener Predictor 
figure
plot(alpha_vector,BMSE_3,'b');
hold on;
plot(alpha_vector,TMSE_3,'r');
xlabel('Alpha');
xlim([0.1 0.9])
ylabel('Mean-Squared Error');
ylim([0 1])
title('Wiener Predictor')
legend('BMSE','TMSE');

end