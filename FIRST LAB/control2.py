import ev3dev2.motor as motor
import time

voltages = [100, 80, 60, 40, 20, -20, -40, -60, -80, -100]

motor_a = motor.LargeMotor(motor.OUTPUT_B)
for vol in voltages:
    startTime = time.time()
    f = open('ГРАФИКИ МАТ. МОДЕЛЬ{}.csv'.format(vol),'w')
    while (True):
        currentTime = time.time() - startTime
        motor_pose = motor_a.position
        motor_vel = motor_a.speed
        motor_a.run_direct(duty_cycle_sp = vol)
        f.write("{} {} {}\n".format(currentTime, motor_pose, motor_vel))

        if currentTime > 1:
            motor_a.run_direct(duty_cycle_sp = 0)
            time.sleep(1)
            break
    f.close()