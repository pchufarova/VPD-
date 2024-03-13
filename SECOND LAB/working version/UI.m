nums_9 = [1,2,3,4,5,6,7,8,9];
nums_18 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];

volts = fliplr([-50, -45, -40, -35, -30, -25, -20, -15, -10, 10, 15, 20, 25, 30, 35, 40, 45, 50]);
L = 0.0047;
J = (15.6 / 1000) * (22.49 / 1000 / 2)^2 / 2 * 48^2;

I_n = [-0.53, -0.47, -0.41, -0.36, -0.32, -0.28, -0.23, -0.17, -0.10];
I_p = [0.11, 0.16, 0.23, 0.29, 0.32, 0.37, 0.42, 0.47, 0.54];
Iall = fliplr([I_n, I_p]);

U_n = [-55.0, -49.6, -44.1, -38.3, -34.2, -30.0, -24.4, -17.8, -11.3];
U_p = [11.1, 17.8, 24.1, 29.9, 33.8, 38.0, 42.2, 48.0, 52.8];
U_n = U_n/10;
U_p = U_p/10;
Uall = fliplr([U_n, U_p]);

UiIi_p = 0;
I2_p = 0;
UiIi_n = 0;
I2_n = 0;
for i = nums_9
    UiIi_n = UiIi_n + I_n(i) * U_n(i);
    I2_n = I2_n + I_n(i)^2;
    UiIi_p = UiIi_p + I_p(i) * U_p(i);
    I2_p = I2_p + I_p(i)^2;
end
R_n = UiIi_n / I2_n ;
R_p = UiIi_p / I2_p ;
R = (R_n + R_p) / 2;


U_n_formula = [1,2,3,4,5,6,7,8,9];
U_p_formula = [1,2,3,4,5,6,7,8,9];
for i = nums_9
    U_n_formula(i) = I_n(i) * R_n;
    U_p_formula(i) = I_p(i) * R_p;
end
U_formula = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
for i = nums_18
    U_formula(i) = Iall(i) * R;
end

figure(1);
title("U(I) negative");
xlabel('I, A');
ylabel('U, V');
grid on;
hold on;
plot(I_n, U_n);
plot(I_n, U_n_formula);
legend("measurements", "formula");
hold off;

figure(2);
title("U(I) positive");
xlabel('I, A');
ylabel('U, V');
grid on;
hold on;
plot(I_p, U_p);
plot(I_p, U_p_formula);
legend("measurements", "approximation");
hold off;

figure(3);
title("U(I) all");
xlabel('I, A');
ylabel('U, V');
grid on;
hold on;
plot(Iall, Uall);
plot(Iall, U_formula);
legend("measurements", "approximation");
hold off;

move_n = [112.818, 90.7397, 71.1745, 54.1576, 39.6888, 27.8031, 18.4307, 11.1003, -0.0698132];
move_p_noflip = [90.443, 70.6684, 53.2674, 38.2053, 25.7087, 15.6382, 8.08087, 2.79253, -0.0698132];
move_p = fliplr(move_p_noflip);
move = fliplr([move_n, move_p]);
K = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
TM = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];

for i = nums_18
    U_pr= Uall(i);
    data = readmatrix(strcat("data", num2str(volts(i)), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180 - move(i);
    time = data(:,1);
    par0=[0.5, 1];
    fun = @(par,time)U_pr*par(1)*(time - par(2)*(1 - exp(-time/par(2))));
    par = lsqcurvefit(fun,par0,time,angle);
    K(i) = par(1);
    TM(i) = par(2);
end

w_nls_n = [1,2,3,4,5,6,7,8,9];
w_nls_p = [1,2,3,4,5,6,7,8,9];
for i = nums_9
    w_nls_n(i) = U_n(i) * K(19-i);
    w_nls_p(i) = U_p(i) * K(10-i);
end

% апроксимировать функцией U = Ke * w_nls отрицательные
func = @(ke,w) ke * w;
ke0 = 0.5;
par = lsqcurvefit(func, ke0, w_nls_n, U_n);
ke_n = par(1);
U_n_func = func(ke_n, w_nls_n);

% апроксимировать функцией U = Ke * w_nls положительные
par = lsqcurvefit(func, ke0, w_nls_p, U_p);
ke_p = par(1);
U_p_func = func(ke_p, w_nls_p);

Ke = (ke_p + ke_n) / 2;
Km = Ke;


figure(4);
title("I(t)");
xlabel("t, c");
ylabel("I, A");
grid on;
hold on;
for i = nums_18
    U_pr = Uall(i);
    simulink_data = sim("mathmodel");
    x = simulink_data.I.Time;
    y = simulink_data.I.Data;
    plot(x, y);
end
legend('50', '45', '40', '35', '30', '25', '20', '15', '10', '-10', '-15', '-20', '-25', '-30', '-35', '-40', '-45', '-50');
hold off;

figure(5);
title("\theta(t)");
xlabel("t, c");
ylabel("\theta, rad");
grid on;
hold on;
for i = nums_18
    U_pr = Uall(i);
    k = K(i);
    Tm = TM(i);
    data = readmatrix(strcat("data", num2str(volts(i)), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180 - move(i);
    time = data(:,1);

    plot(time, angle);

    simulink_data = sim("smth");
    x = simulink_data.theta.Time;
    y = simulink_data.theta.Data;
    plot(x, y, '--');
end
legend('measurements', 'model');
hold off;

figure(6);
title("U(w_{ycm}) positive");
xlabel("w_{ycm}, rad/c");
ylabel("U, V");
grid on;
hold on;
plot(w_nls_p, U_p);
plot(w_nls_p, U_p_func);
legend("measurements", "approximation");
hold off;

figure(7);
title("U(w_{ycm}) negative");
xlabel("w_{ycm}, rad/c");
ylabel("U, V");
grid on;
hold on;
plot(w_nls_n, U_n);
plot(w_nls_n, U_n_func);
legend("measurements", "approximation");
hold off;







