import math
import ev3dev2.motor as motor
import time

motor_a = motor.LargeMotor(motor.OUTPUT_B)
angle_need = 180
kp = [0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3, 1.5]

for i in range(len(kp)):
    startTime = time.time()
    start_pose = motor_a.position
    f = open('data_p_{}.csv'.format(i), 'w')
    while (True):
        currentTime = time.time() - startTime
        pose = motor_a.position - start_pose
        f.write("{} {}\n".format(currentTime, pose))
        U = kp[i] * (angle_need - pose)

        if U > 100:
            motor_a.run_direct(duty_cycle_sp=100)
        elif U < -100:
            motor_a.run_direct(duty_cycle_sp=-100)
        else:
            motor_a.run_direct(duty_cycle_sp=U)



        if currentTime > 5:
            motor_a.run_direct(duty_cycle_sp=0)
            time.sleep(1)
            break
f.close()