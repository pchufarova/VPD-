import ev3dev2.motor as motor
import time

voltages = [10, 15, 20, 25, 30, 35, 40, 45, 50]

motor_a = motor.LargeMotor(motor.OUTPUT_B)
for vol in voltages:
    startTime = time.time()
    # f = open('.csv'.format(vol),'w')
    while (True):
        currentTime = time.time() - startTime
        # motor_pose = motor_a.position
        # motor_vel = motor_a.speed
        motor_a.run_direct(duty_cycle_sp = vol)
        # f.write("{} {} {}\n".format(currentTime, motor_pose, motor_vel))

        if currentTime > 1:
            motor_a.run_direct(duty_cycle_sp = 0)
            time.sleep(1)
            break
    # f.close()