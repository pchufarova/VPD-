import ev3dev2.motor as motor
import time

voltages = [10, 15, 20, 25, 30, 35, 40, 45, 50, -50, -45, -40, -35, -30, -25, -20, -15, -10]

motor_a = motor.LargeMotor(motor.OUTPUT_B)
for vol in voltages:
    startTime = time.time()
    while (True):
        currentTime = time.time() - startTime
        # motor_pose = motor_a.position
        # motor_vel = motor_a.speed
        motor_a.run_direct(duty_cycle_sp = vol)

        if currentTime > 2:
            motor_a.run_direct(duty_cycle_sp = 0)
            time.sleep(2)
            break