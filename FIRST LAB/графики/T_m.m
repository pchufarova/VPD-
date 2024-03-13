volts = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
Tm = [0.0981, 0.0877, 0.0829, 0.0773, 0.0584, 0.0753, 0.0864, 0.0833, 0.0859, 0.1182];
figure(1);
plot(volts, Tm, 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
plot(volts, Tm)
xlabel('U, %');
ylabel('Tm, c');
grid on;