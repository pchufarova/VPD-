nums = [0, 1, 2, 3, 4, 5];
for n = nums

    data = readmatrix(strcat("data_p_", num2str(n), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180; 
    time = data(:,1)/1000;
    figure(n+1);
    plot(time, angle);
    hold on;
    grid on;
    xlabel("t, c");
    ylabel("\theta, rad");

end