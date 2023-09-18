# adaptive_cruise_control
Arduino uno based adaptive cruise control system

List of components
1. Arduino UNO
2. 4 digit 7-segment anode display
3. Ultrasonic sensor
4. 10 ohm Resistors
5. Push Buttons
6. Breadboard 
7. Jumper wires

Following circuit diagram can be used. It can be hard to see connections so the code can be used to set up connections for particular ports or the ports can be modified in the code.

Circuit Diagram:
![image](https://github.com/sameerparvezsingh/adaptive_cruise_control/assets/112791092/9511386d-a3f7-4616-837e-e683c5edfd58)

Description:

The main part to understand here is how to display a number greater than 10. 
One option is to use a hardware driver with the 7 segment display.
Second option is to turn 2 segments(one's place and ten's place) alternatively by splitting the number to one's place and ten's place but displaying them as a one's place on different segments.
