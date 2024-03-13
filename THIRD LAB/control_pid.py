import math
import ev3dev2.motor as motor
import time

motor_a = motor.LargeMotor(motor.OUTPUT_B)
angle_need = 180
kp = [1, 3, 6]
kd = [0, 1, 3]
ki = [0, 3]
integr_summ = 0
for p in range(len(kp)):
    for d in range(len(kd)):
        for i in range(len(ki)):
            startTime = time.time()
            start_pose = motor_a.position
            f = open('data_pid_{}_{}_{}.csv'.format(kp, kd, ki), 'w')
            e = angle_need
            while (True):
                currentTime = time.time() - startTime
                pose = motor_a.position - start_pose
                f.write("{} {}\n".format(currentTime, pose))
                e_p = e
                e = angle_need - pose
                integr_summ += e
                U = kp[p]*e + ki[i]*integr_summ + kd[d]*(e-e_p)
                motor_a.run_direct(duty_cycle_sp=U)

                if currentTime > 2:
                    motor_a.run_direct(duty_cycle_sp=0)
                    time.sleep(0.5)
                    break

f.close()