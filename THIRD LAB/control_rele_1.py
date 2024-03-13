import math
import ev3dev2.motor as motor
import time

motor_a = motor.LargeMotor(motor.OUTPUT_B)
angle_need = 180

U = 100

startTime = time.time()
f = open('data_rele.csv', 'w')

start_pose = motor_a.position
while (True):
    currentTime = time.time() - startTime
    pose = motor_a.position - start_pose
    f.write("{} {}\n".format(currentTime, pose))

    if pose < angle_need:
        motor_a.run_direct(duty_cycle_sp=U)
    elif pose > angle_need:
        motor_a.run_direct(duty_cycle_sp=-U)
    else:
        motor_a.run_direct(duty_cycle_sp=0)

    if currentTime > 5:
        motor_a.run_direct(duty_cycle_sp=0)
        time.sleep(1)
        break
f.close()