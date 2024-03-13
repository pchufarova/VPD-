import math
import ev3dev2.motor as motor
import time

motor_a = motor.LargeMotor(motor.OUTPUT_B)
angle_need = 90 * 180 / math.pi

U = 100

startTime = time.time()
f = open('data_rele.csv', 'w')

while (True):
    currentTime = time.time() - startTime
    pose = motor_a.position

    if pose < angle_need:
        motor_a.run_direct(duty_cycle_sp=U)
    elif pose > angle_need:
        motor_a.run_direct(duty_cycle_sp=-U)
    else:
        motor_a.run_direct(duty_cycle_sp=0)

    f.write("{}, {}\n".format(currentTime, pose))

    if currentTime > 1:
        motor_a.run_direct(duty_cycle_sp=0)
        # time.sleep(1)
        break
f.close()