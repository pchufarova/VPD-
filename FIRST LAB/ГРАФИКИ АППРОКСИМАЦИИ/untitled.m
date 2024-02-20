%volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
%move = [19.5128, 31.8348, 40.9803, 46.9319, 49.7768, 46.8097, 40.352, 30.4211, 17.0693, 0];
% это массив отклонений которые нужно вычесть при аппроксимации графиков
% угла, чтобы они шли из нуля. нужно вычитать их в расчете значения angle
volts = [100];


for vol = volts

    U_pr= vol;
    data = readmatrix(strcat("data", num2str(vol), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180;
    time = data(:,1);
    omega = data(:,3)*pi/180;
    figure(1); %закомментированное для скорости
    plot(time, angle);
    hold on;
    xlabel("time, s");
    ylabel("angle, rad");
    %figure(1);
    %plot(time, omega);
    %hold on;
    %xlabel("time, s");
    %ylabel("angle speed, rad\s");

    par0=[0.1;0.06];
    %fun = @(par,time)U_pr*par(1)*(1-exp(-(time/par(2))));
    fun = @(par,time)U_pr*par(1)*(time - par(2)*(1 - exp(-time/par(2))));

    %par = lsqcurvefit(fun,par0,time,omega);
    par = lsqcurvefit(fun,par0,time,angle);

    k = par(1);
    Tm = par(2);
    disp(k);
    disp(Tm);
    time_apr = 0:0.01:1;
    %omega_F = U_pr*k*(1-exp(-(time_apr/Tm)));
    theta = U_pr*k*(time_apr - Tm*(1 - exp(-time_apr/Tm)));
    figure(1);
    %plot(time_apr, omega_F);
    plot(time_apr, theta);
    
end