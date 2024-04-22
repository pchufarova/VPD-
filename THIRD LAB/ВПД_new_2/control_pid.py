import math
import ev3dev2.motor as motor
import time

motor_a = motor.LargeMotor(motor.OUTPUT_B)
angle_need = 90
kp = [0.5, 1, 1.5]
kd = [0, 0.5, 1]
ki = [0, 0.5, 1]

for p in range(len(kp)):
    for d in range(len(kd)):
        for i in range(len(ki)):
            startTime = time.time()
            start_pose = motor_a.position
            integr_summ = 0  # Reset integral sum for each set of parameters
            with open('data_pid_{}_{}_{}.csv'.format(kp[p], kd[d], ki[i]), 'w') as f:
                e = angle_need
                currentTime = time.time() - startTime
                while True:
                    deltaTime = time.time() - startTime - currentTime
                    currentTime = time.time() - startTime
                    pose = motor_a.position - start_pose
                    f.write("{} {}\n".format(currentTime, pose))
                    e_previous = e
                    e = angle_need - pose
                    integr_summ += e
                    
                    U = kp[p]*e + ki[i]*integr_summ*deltaTime - kd[d]*(e-e_previous)/deltaTime
                    
                    U = max(min(U, 100), -100)  # Assuming duty cycle range of -100 to 100
                    motor_a.run_direct(duty_cycle_sp=U)

                    if currentTime > 5:
                        motor_a.run_direct(duty_cycle_sp=0)
                        time.sleep(0.5)
                        break
