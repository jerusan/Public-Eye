//Sensor Serial Communication with Arduino
//Arduino turns on LEDs and buzzer when sensor values are below threshold value
//WORK BY JEFF HIRSCH - 5113412

//POSSIBLE FIXES

//Dual serial line - one for sending sensor data one 
//Different microcontroller - different communication protocal
//WHILE LOOP?  if broken go into error? --> sensor needs to be very accurate
//interrupts to update sensor value periodically


import processing.serial.*; //import the Serial library
Serial myPort;              //the Serial port object
String val;
// since we're doing serial handshaking, 
// we need to check if we've heard from the arduino
boolean firstContact = false;
int sensorvalue = 0;         //tried to reset variable but didn't work this way, kept the variable anyways
//int count = 0;

void ArduinoSetup()
{

    //initialize your serial port and set the baud rate to 9600-->match with arduino code
    myPort = new Serial(this, Serial.list()[0], 9600);
    myPort.bufferUntil('\n'); 

}

//THIS NEEDS TO RUN IN PARALLEL WITH EVERYTHING TO CONSTANTLY READ SERIAL LINE

void serialEvent( Serial myPort)       //to receive sensor data it must loop back to this point
  {    
    //put the incoming data into a String - 
    //the '\n' is our end delimiter indicating the end of a complete packet
    val = myPort.readStringUntil('\n'); 
    //make sure our data isn't empty before continuing
    if (val != null) 
      {
        //trim whitespace and formatting characters (like carriage return)
        val = trim(val);
        //println(val);
        //look for our 'A' string to start the handshake
        //if it's there, clear the buffer, and send a request for data
        if (firstContact == false)       //establishes contact here
          {
            if (val.equals("A")) 
              {
                myPort.clear();
                firstContact = true;
                myPort.write("A");
                println("ContactWithArduino");
              }
         }
         
         
        //MAIN CODE 
        else 
        { //if we've already established contact, keep getting and parsing data
        
         println(val);
              
              if(val.equals("Nothing Detected"))
             {
               println("Nothing Detected");
           
             }
           if(val.equals("Delete Clip"))
             {
               DeleteFile("newMov.mov");
             
             }
             if(val.equals("Running LED Sequence"))
             {
               for(int i = 0; i < 475; i++)
               {
                    cameraRead();
               }
               
             }
             if(val.equals("Keep Clip"))
             {
                 cam.stop(); 
             }
              
            
            
              
        }
              
           
        
          // when you've parsed the data you have, ask for more:
          myPort.write("A");
        }
  }