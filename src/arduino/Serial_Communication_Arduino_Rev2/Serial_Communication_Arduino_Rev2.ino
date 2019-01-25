// The following link was used as reference in making arduino/processing communication possible:
// https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing

int sensorPin = A0; // Define input pin for the proximity sensor.
int secondsPersonHasBeenPresent;

void setup() 
{
  Serial.begin(9600); // 9600 bits per second.
  establishContact();
}

void loop()
{
  if (isPersonPresent(analogRead(sensorPin))) // A person has initiated recording a clip of their eye.
  {
    Serial.println("R");  // Tell processing to begin recording. R for recording.

    while(1)
    {
      delay(1000);
   
      if (isPersonPresent(analogRead(sensorPin))) // Then the person is still recording a clip of their eye.
      {
        secondsPersonHasBeenPresent++;
      }
      else  // The person has left the recording station early.
      {
        Serial.println("D");  // Tell processing to terminate recording & ditch the clip. D for delete clip.
        break;
      }
    
      if (secondsPersonHasBeenPresent >= 15)  // Then the person is has completed the recording of a clip of their eye.
      {
        Serial.println("K");  // Tell processing that the recording is finished and the clip can be added to the temporary recordings. K for keep clip.
        delay(5000);
        break;
      }
    }

    secondsPersonHasBeenPresent = 0;  // Reset count for next recording.
  }  
}

bool isPersonPresent(int sensorValue)
{
  if (sensorValue <= 200) return true;  
  else return false;
}

void establishContact() 
{
  while (Serial.available() <= 0) 
  {
    Serial.println("A");   
    delay(300);
  }
} 



  




