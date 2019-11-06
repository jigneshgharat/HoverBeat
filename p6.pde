
import processing.sound.*; /// For SimplePlayBack
import processing.serial.*; // import the Processing serial library
Serial myPort;              // The serial port
int photocellReading;
float mappedphotocellReading;

 //For SimplePlayBack
SoundFile soundfile;///

void setup() {
  size(800, 300);
  // List all the available serial ports in the console
  printArray(Serial.list());

  // Change the 0 to the appropriate number of the serial port
  // that your microcontroller is attached to.
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  // read incoming bytes to a buffer
  // until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');
  
  //For SimplePlayBack
  // Load a soundfile
  soundfile = new SoundFile(this, "Tabla.mp3");
    // These methods return useful infos about the file
  println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");

  // Play the file in a loop
  soundfile.loop();
  
}


void draw() {
  background(000);
  
  if (photocellReading > 235) {
  fill(57, 255, 20);
  
  // Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback speed,
  // 2 is twice the speed and will sound an octave higher, 0.5 is half the speed and
  // (photocellReading, 0, width, 0.1, 4.0);
  // will make the file sound one ocative lower.
  float playbackSpeed = map(photocellReading, 0, width, 0.1, 3.0);
  soundfile.rate(playbackSpeed);
  
  // Map photocellReading from 0.2 to 1.0 for amplitude
  float amplitude = map(photocellReading, 0, width, 0.2, 1.0);
  soundfile.amp(amplitude);
 
  } else {
    
  fill(253, 78, 179);
  float playbackSpeed = map(photocellReading, 0, width, 1, 1);
  soundfile.rate(playbackSpeed);

  }
  
  ellipse(width/2, mappedphotocellReading, 50, 50);

}


void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    
  // println(myString);
  myString = trim(myString);

  // split the string at the commas
  // and convert the sections into integers:
  int sensors[] = int(split(myString, ','));
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
  print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
    }
    
  // add a linefeed at the end:
  println();
  photocellReading = sensors[0];  
  mappedphotocellReading = map(photocellReading, 0, 1023, height, 0);
   
  }
}
