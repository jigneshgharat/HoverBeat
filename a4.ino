int photocellPin = 0;
int photocellReading;
int led = 13; // the pin the LED is connected to

void setup(void) {
  Serial.begin(9600); 
  pinMode(led, OUTPUT); // Declare the LED as an output

}
 
void loop(void) {
  photocellReading = analogRead(photocellPin);
  Serial.println(photocellReading);
  delay(100);
  
  digitalWrite(led, HIGH); // Turn the LED on

}
