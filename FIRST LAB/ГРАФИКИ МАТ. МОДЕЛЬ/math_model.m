volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
move = [19.5128, 31.8348, 40.9803, 46.9319, 49.7768, 46.8097, 40.352, 30.4211, 17.0693, 0];
%volts = [100];
i=1;
J = 0.0023;
k = 0.05;
Tm = 1;

for vol = volts

    U_pr= vol;

    data = readmatrix(strcat("data", num2str(vol), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180 - move(i);
    time = data(:,1);
    omega = data(:,3)*pi/180;
    %figure(i);
    %plot(time, angle);
    %hold on;
    %xlabel("time");
    %ylabel("angle");
    figure(i);
    plot(time, omega);
    hold on;
    xlabel("time");
    ylabel("speed");

    par0=[0.5, 1];
    fun = @(par,time)U_pr*par(1)*(time - par(2)*(1 - exp(-time/par(2))));
    par = lsqcurvefit(fun,par0,time,angle);
    k = par(1);
    Tm = par(2);
    disp(i);
    disp(k);
    disp(Tm);
    time_apr = 0:0.01:1;
    %theta = U_pr*k*(time_apr - Tm*(1 - exp(-time_apr/Tm)));
    omega_F = U_pr*k*(1-exp(-(time_apr/Tm)));
    figure(i);
    %plot(time_apr, theta);
    plot(time_apr, omega_F);

    simulink_data = sim("smth");
    x = simulink_data.omega.Time;
    y = simulink_data.omega.Data;
    figure(i);
    plot(x, y, '--');
    xlabel("t, s");
    ylabel("\omega, rad/s");
    hold off;
    grid on;
    legend("эксперимент", "аппроксимация", "модель")
    i=i+1;
end