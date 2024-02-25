volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
move = [19.5128, 31.8348, 40.9803, 46.9319, 49.7768, 46.8097, 40.352, 30.4211, 17.0693, 0];
i = 1;
for vol = volts

    data = readmatrix(strcat("data", num2str(vol), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180 - move(i); 
    time = data(:,1)/1000;
    omega = data(:,3)*pi/180;
    figure(1);
    plot(time, angle);
    hold on;
    xlabel("t, c");
    ylabel("\theta, rad");
    figure(2);
    plot(time, omega);
    hold on;
    xlabel("t, c");
    ylabel("\omega, rad/c");
    i = i + 1;


end