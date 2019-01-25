

#include <SD.h>
#define SD_ChipSelectPin 10
#include <TMRpcm.h>

TMRpcm tmrpcm;
char mychar;

void setup()
  {
    tmrpcm.speakerPin = 9;
    Serial.begin(9600);
    if(!SD.begin(SD_ChipSelectPin))
    {
        Serial.println("SD fail");
        return;
      
    }
    tmrpcm.play("success.wav");
  }

  void loop(){
    if(Serial.available()){
      mychar = Serial.read();
      if(mychar == 's'){
        tmrpcm.play("success.wav");
      }
      else if(mychar == 'f'){
        tmrpcm.play("fail.wav");
      }
      else if(mychar == 'h'){
        tmrpcm.play("hello.wav");
      }
    }
  }

