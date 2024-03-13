import math
import ev3dev2.motor as motor
import time

motor_a = motor.LargeMotor(motor.OUTPUT_B)
angle_need = 90
kp = [0.5, 1, 1.5, 2, 2.5, 3]

for i in range(len(kp)):
    startTime = time.time()
    start_pose = motor_a.position
    f = open('data_p_{}.csv'.format(i), 'w')
    while (True):
        currentTime = time.time() - startTime
        pose = motor_a.position - start_pose

        U = kp[i] * (angle_need - pose)

        if U > 100:
            motor_a.run_direct(duty_cycle_sp=100)
        elif U < -100:
            motor_a.run_direct(duty_cycle_sp=-100)
        else:
            motor_a.run_direct(duty_cycle_sp=U)

        f.write("{} {}\n".format(currentTime, pose))

        if currentTime > 10:
            motor_a.run_direct(duty_cycle_sp=0)
            time.sleep(1)
            break
f.close()