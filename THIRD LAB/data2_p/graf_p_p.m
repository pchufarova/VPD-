nums = [05, 1, 15, 2, 25, 3, 35, 4, 45, 5, 55, 6, 65, 7, 75, 8, 9, 95];
for n = nums

    data = readmatrix(strcat("data_p_0_", num2str(n), ".csv"));
    angle = data(:,2);
    angle = angle*pi/180; 
    time = data(:,1)/1000;
    figure(n);
    plot(time, angle);
    hold on;
    grid on;
    xlabel("t, c");
    ylabel("\theta, rad");

end