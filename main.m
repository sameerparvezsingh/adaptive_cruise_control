clear;
clc;

speed = 0;
setSpeed = 0;
cruiseSpeed = 0;
checkBtn = 0;

isIncrease = 0;
isDecrease = 0;
isCancel = 0;
isCruise = 0;
isSet = 0;

increaseSpeedBtn = 'A5';
decreaseSpeedBtn = 'A4';
cancelBtn = 'A3';
setModeBtn = 'A2';
cruiseControlBtn = 'A1';

ledA = 'D10';
ledB = 'D13';
ledC = 'D6';
ledD = 'D7';
ledE = 'D8';
ledF = 'D11';
ledG = 'D5';
ledD1 = 'D12';
ledD2 = 'D4';

triggerPin = 'D2';
echoPin = 'D3';

ard = arduino();
ultrasonicObj = ultrasonic(ard,triggerPin,echoPin);
cloudCounter = 0;
speedCloud = [];
configurePin(ard, increaseSpeedBtn, 'DigitalInput');
configurePin(ard, decreaseSpeedBtn, 'DigitalInput');
configurePin(ard, cancelBtn, 'DigitalInput');
configurePin(ard, setModeBtn, 'DigitalInput');
configurePin(ard, cruiseControlBtn, 'DigitalInput');

configurePin(ard, ledA, 'DigitalOutput');
configurePin(ard, ledB, 'DigitalOutput');
configurePin(ard, ledC, 'DigitalOutput');
configurePin(ard, ledD, 'DigitalOutput');
configurePin(ard, ledE, 'DigitalOutput');
configurePin(ard, ledF, 'DigitalOutput');
configurePin(ard, ledG, 'DigitalOutput');
configurePin(ard, ledD1, 'DigitalOutput');
configurePin(ard, ledD2, 'DigitalOutput');

while (1)

    while (1)
        isIncrease = readDigitalPin(ard,increaseSpeedBtn);
        isDecrease = readDigitalPin(ard,decreaseSpeedBtn);
        isSetMode = readDigitalPin(ard,setModeBtn);
        isCruiseMode = readDigitalPin(ard,cruiseControlBtn);
        isCancel = readDigitalPin(ard,cancelBtn);
        

        if(isIncrease==0)
            %printLCD(lcd,char("Increasing"));pause(0.2);
            disp("Increasing speed");
            checkBtn=1;
            break;
        elseif(isDecrease==0)
            %printLCD(lcd,char("Decreasing"));pause(0.2);
            disp("Decreasing speed");
            checkBtn=2;
            break;
        elseif(isSetMode==0)
            %printLCD(lcd,char("Cruise Control"));pause(0.5);
            isSet=1;
            disp('Set speed mode')
            setSpeed = speed; % Set speed equals cruise speed
            break;
        elseif(isCruiseMode == 0)
            %printLCD(lcd,char("ACC Mode"));pause(0.5);
            isCruise = 1;
            disp('Adaptive cruise control')
            cruiseSpeed = speed; % Set speed equals adaptive cruise speed
            break;
        elseif(isCancel == 0)
            %printLCD(lcd,char("Cancel"));pause(0.5);
            disp('cancel')
            isSet = 0;
            isCruise = 0;
            setSpeed=0;
            cruiseSpeed=0;
            break;
        else
            checkBtn=0;
            break;
        end
    end


    switch checkBtn
    case 1
        if (isCruise == 0)
            speed=speed+1; % increase speed when increase button is pressed
        end
        
    case 2
        if (isCruise == 0)
            if (speed>0)
                speed=speed-1; % decrease speed when decrease button is pressed
            end
        end
    otherwise
        if(speed>0 && isSet==0 && isCruise==0)
            speed=speed-1; % Decrease speed when nothing is pressed
        elseif(isCruise==1)
            %writeDigitalPin(ard,ledD1,0);pause(0.02);%blink the LED
            %writeDigitalPin(ard,ledD2,0);  
            distance = 100*readDistance(ultrasonicObj); % Read ultrasonic sensor data when adaptive button is pressed
            if(distance<20 && speed~=0)
            speed=speed-1; % if senor distance is less than 20 then reduce speed
            elseif(speed<cruiseSpeed && distance>20)
            speed=speed+1; % if current speed is less than cruise speed;increase

            end
        end    
        %pause(0.5)


       % pause(0.2);
   end
    disp(speed);
    %taking 2 digits of the display
    if speed>10
        digitD1 = round(rem(speed,10),0);
        digitD2 = round((speed-digitD1)/10,0);
    else
        digitD1 = speed;
        digitD2 = 0;       
    end


    % Display current speed on the LED
    ledDigitHigh(ard,ledD1);
    ledDigitHigh(ard,ledD2);
    %callDisplay(ard,speed,ledD1,ledD2,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
    callDisplay2(ard,digitD1,digitD2,ledD1,ledD2,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
    %pause(0.2);
    %speedCloud = [speedCloud,speed];
    % Display current speed on the LED 
    callDisplay(ard,speed,ledD1,ledD2,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
    cloudCounter = cloudCounter + 1;
   % if (cloudCounter == 8)
   %     pause(15);
   %     thingSpeakWrite(1950094,speedCloud,'WriteKey','RX6S96ED0B19O1LQ');
   %     cloudCounter = 0;
    %    speedCloud = [];
   % end
end

%clear;



function callDisplay(ard,number,ledD1,ledD2,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
   switch number
       case 0
           %ledDigitHigh(ard,ledD1)
           ledZero(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 1
           %ledDigitHigh(ard,ledD1)
            ledOne(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 2
           %ledDigitHigh(ard,ledD1)
            ledTwo(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 3
           %ledDigitHigh(ard,ledD1)
           ledThree(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 4
           %ledDigitHigh(ard,ledD1)
           ledFour(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 5
           %ledDigitHigh(ard,ledD1)
           ledFive(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 6
           %ledDigitHigh(ard,ledD1)
           ledSix(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 7
           %ledSeven(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 8
           %ledEight(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
           %ledZero(ard,ledD2,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
       case 9
           %ledDigitHigh(ard,ledD1)
           ledNine(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
       case 10
           %ledDigitLow(ard,ledD1)
           ledDigitHigh(ard,ledD1)
           ledZero(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
           ledDigitHigh(ard,ledD)           
           ledOne(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);

        %pause(0.3)


   end
end

function callDisplay2(ard,digitD1,digitD2,ledD1,ledD2,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
    ledDigitHigh(ard,ledD1);
    ledDigitHigh(ard,ledD2);
    if digitD2 == 0
        ledZero(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
    elseif digitD2 == 1
        ledOne(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
    elseif digitD2 == 2
        ledTwo(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 3
        ledThree(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 4
        ledFour(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 5
        ledFive(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 6
        ledSix(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 7
        ledSeven(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 8
        ledEight(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD2 == 9
        ledNine(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
    end

    ledDigitLow(ard,ledD1);
    pause(0.1);
    ledDigitHigh(ard,ledD1);
    if digitD1 == 0
        ledZero(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
    elseif digitD1 == 1
        ledOne(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
    elseif digitD1 == 2
        ledTwo(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 3
        ledThree(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 4
        ledFour(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 5
        ledFive(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 6
        ledSix(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 7
        ledSeven(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 8
        ledEight(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);   
    elseif digitD1 == 9
        ledNine(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG);
    end
    
    ledDigitLow(ard,ledD2);
    pause(0.1);
    ledDigitHigh(ard,ledD2);
      
end


function ledDigitHigh(ard,digit)
    writeDigitalPin(ard,digit,1);
end
function ledDigitLow(ard,digit)
    writeDigitalPin(ard,digit,0);
end

function ledZero(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
    writeDigitalPin(ard,ledA,1);
    writeDigitalPin(ard,ledB,1);
    writeDigitalPin(ard,ledC,1);
    writeDigitalPin(ard,ledD,1);
    writeDigitalPin(ard,ledE,1);
    writeDigitalPin(ard,ledF,1);
    writeDigitalPin(ard,ledG,0);
end
function ledOne(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,0);
        writeDigitalPin(ard,ledB,1);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,0);
        writeDigitalPin(ard,ledE,0);
        writeDigitalPin(ard,ledF,0);
        writeDigitalPin(ard,ledG,0);
end
function ledTwo(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,1);
        writeDigitalPin(ard,ledB,1);
        writeDigitalPin(ard,ledC,0);
        writeDigitalPin(ard,ledD,1);
        writeDigitalPin(ard,ledE,1);
        writeDigitalPin(ard,ledF,0);
        writeDigitalPin(ard,ledG,1);
end
function ledThree(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,1);
        writeDigitalPin(ard,ledB,1);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,1);
        writeDigitalPin(ard,ledE,0);
        writeDigitalPin(ard,ledF,0);
        writeDigitalPin(ard,ledG,1);
end
function ledFour(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,0);
        writeDigitalPin(ard,ledB,1);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,0);
        writeDigitalPin(ard,ledE,0);
        writeDigitalPin(ard,ledF,1);
        writeDigitalPin(ard,ledG,1);
end
function ledFive(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,1);
        writeDigitalPin(ard,ledB,0);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,1);
        writeDigitalPin(ard,ledE,0);
        writeDigitalPin(ard,ledF,1);
        writeDigitalPin(ard,ledG,1);
end
function ledSix(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,1);
        writeDigitalPin(ard,ledB,0);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,1);
        writeDigitalPin(ard,ledE,1);
        writeDigitalPin(ard,ledF,1);
        writeDigitalPin(ard,ledG,1);
end
function ledSeven(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,1);
        writeDigitalPin(ard,ledB,1);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,0);
        writeDigitalPin(ard,ledE,0);
        writeDigitalPin(ard,ledF,0);
        writeDigitalPin(ard,ledG,0);
end
function ledEight(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
    writeDigitalPin(ard,ledA,1);
    writeDigitalPin(ard,ledB,1);
    writeDigitalPin(ard,ledC,1);
    writeDigitalPin(ard,ledD,1);
    writeDigitalPin(ard,ledE,1);
    writeDigitalPin(ard,ledF,1);
    writeDigitalPin(ard,ledG,1);
end
function ledNine(ard,ledA,ledB,ledC,ledD,ledE,ledF,ledG)
        writeDigitalPin(ard,ledA,1);
        writeDigitalPin(ard,ledB,1);
        writeDigitalPin(ard,ledC,1);
        writeDigitalPin(ard,ledD,0);
        writeDigitalPin(ard,ledE,0);
        writeDigitalPin(ard,ledF,1);
        writeDigitalPin(ard,ledG,1);
end
