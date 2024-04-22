kp = [0.3];
kd = [0];
ki = [0,0.1,0.12,0.15,0.25,0.2,0.3,0.4,0.5];




% nums = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
i = 1;
leg = {};
for kp_i = kp
    for kd_i = kd
        for ki_i = ki

            filename = "data_pid_" + num2str(kp_i) + "_" + num2str(kd_i) + "_" + num2str(ki_i) + ".csv";
            data = readmatrix(filename);
            time = data(:,1);
            angle = data(:,2);
       

            figure(1);
            plot(time, angle);
            xlabel("time, s");
            ylabel("angle, rad");
            title( "ПИД-kp-" + kp_i + "-kp-" + kd_i + "-ki-" + ki_i + ".csv");
%             leg(i) = { "kp-" + kp_i + "-kp-" + kd_i + "-ki-" + ki_i};
            hold on;
            
            i= i + 1;

            figure(i);
            plot(time, angle);
            xlabel("time, s");
            ylabel("angle, rad");
            title( "ПИД-kp-" + kp_i + "-kp-" + kd_i + "-ki-" + ki_i + ".csv");
        end
    end
end
figure(1);
hold off;