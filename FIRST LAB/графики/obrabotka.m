volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];

for vol = volts

    data = readmatrix(strcat("data", num2str(vol), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180;
    time = data(:,1)/1000;
    omega = data(:,3)*pi/180;
    figure(1);
    plot(time, angle);
    hold on;
    xlabel("time");
    ylabel("angle");
    figure(2);
    plot(time, omega);
    hold on;
    xlabel("time");
    ylabel("speed");


end