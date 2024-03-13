%volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
%move = [19.5128, 31.8348, 40.9803, 46.9319, 49.7768, 46.8097, 40.352, 30.4211, 17.0693, 0];
i = 1;
%for vol = volts

    data = readmatrix("data_rele.csv");
    angle = data(:,2);
    angle = angle*pi/180; 
    time = data(:,1)/1000;
    figure(1);
    plot(time, angle);
    hold on;
    grid on;
    xlabel("t, c");
    ylabel("\theta, rad");
    i = i + 1;

%end
figure(1);
% legend("-100", "-80", "-60", "-40", "-20", "20", "40", "60", "80", "100");
% figure(2);
% legend("-100", "-80", "-60", "-40", "-20", "20", "40", "60", "80", "100");