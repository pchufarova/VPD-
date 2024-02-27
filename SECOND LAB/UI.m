I_n = [-0.53, -0.47, -0.41, -0.36, -0.32, -0.28, -0.23, -0.17, -0.10];
I_p = [0.11, 0.16, 0.23, 0.29, 0.32, 0.37, 0.42, 0.47, 0.54];

U_n = [-55.0, -49.6, -44.1, -38.3, -34.2, -30.0, -24.4, -17.8, -11.3];
U_p = [11.1, 17.8, 24.1, 29.9, 33.8, 38.0, 42.2, 48.0, 52.8];
U_n = U_n/10;
U_p = U_p/10;

U = [U_n,U_p];
I = [I_n,I_p];

nums_9 = [1,2,3,4,5,6,7,8,9];
nums_18 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
a_n = 0;
b_n = 0;
a_p = 0;
b_p = 0;
for i = nums_9
    a_n = a_n + I_n(i) * U_n(i);
    b_n = b_n + I_n(i)^2;
    a_p = a_p + I_p(i) * U_p(i);
    b_p = b_p + I_p(i)^2;
end
R_n = a_n / b_n ;
R_p = a_p / b_p ;
R_FIN = (R_n + R_p) / 2; 
disp(R_FIN);

U_N = [1,2,3,4,5,6,7,8,9];
U_P = [1,2,3,4,5,6,7,8,9];
for i = nums_9
    U_N(i) = I_n(i) * R_n;
    U_P(i) = I_p(i) * R_p;
end

U_FIN = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
for i = nums_18
    U_FIN(i) = I(i) * R_FIN;
end

figure(1);
plot(I_n, U_n);
hold on;
plot(I_n, U_N);
xlabel('I, A');
ylabel('U, V');
grid on;
title("U(I) negative");
hold off;

figure(2);
plot(I_p, U_p);
hold on;
plot(I_p, U_P);
xlabel('I, A');
ylabel('U, V');
grid on;
title("U(I) positive");
hold off;

figure(3);
plot(I,U);
hold on;
plot(I, U_FIN);
xlabel('I, A');
ylabel('U, V');
grid on;
title("U(I) all");
hold off;










