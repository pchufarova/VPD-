volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
k = [0.1611, 0.1558, 0.1546, 0.1506, 0.1427, 0.1510, 0.1646, 0.1675, 0.1679, 0.1747];
w_nls = [0,1,2,3,4,5,6,7,8,9];
nums = [1,2,3,4,5,6,7,8,9,10];
for i = nums
    w_nls(i) = volts(i)*k(i);
end
disp(w_nls);
figure(1);
plot(volts, w_nls, 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
plot(volts, w_nls)
xlabel('U, %');
ylabel('\omega_{ycm}, rad/c');
grid on;