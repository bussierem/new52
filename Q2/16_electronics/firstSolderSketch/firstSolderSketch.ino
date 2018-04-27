const int buttonPin = 2;
const int ledPin = 13;
int buttonState;
bool lightOn= false;
long debounceDelay = 200;
long onBtnLastDBTime = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  buttonState = digitalRead(buttonPin);
  if ((millis() - onBtnLastDBTime) > debounceDelay) {
    if (buttonState == LOW) {
      lightOn = !lightOn;
      onBtnLastDBTime = millis();
    }  
  }
  
  digitalWrite(ledPin, (lightOn) ? HIGH : LOW);
}
