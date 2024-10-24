#include <WiFiNINA.h>

const int buzzerPin = 5;
int buzzerFrequency = 2000;
int frequencyStep = 1000;
bool buzzerOn = false;

const char ssid[] = "LEOSWIFI";
const char pass[] = "m12345678";

WiFiClient client;

IPAddress server(192, 168, 132, 121);
const uint16_t port = 70;

void setup() {
  Serial1.begin(115200);

  while (WiFi.status() != WL_CONNECTED) {
    WiFi.begin(ssid, pass);
    delay(5000);
  }

  while (!client.connect(server, port)) {
    delay(5000);
  }

  pinMode(buzzerPin, OUTPUT);
}

void loop() {
  if (!client.connected()) {
    client.stop();
    delay(1000);
    while (!client.connect(server, port)) {
      delay(5000);
    }
  }

  while (client.available()) {
    int incomingByte = client.read();

    if (incomingByte != -1) {
      uint8_t receivedData = (uint8_t)incomingByte;

      switch (receivedData) {
        case 0xF1:
          tone(buzzerPin, buzzerFrequency);
          buzzerOn = true;
          break;
        case 0xF2:
          tone(buzzerPin, buzzerFrequency + frequencyStep);
          buzzerOn = true;
          break;
        case 0xF4:
          tone(buzzerPin, buzzerFrequency + 2.5 * frequencyStep);
          buzzerOn = true;
          break;
        case 0xF8:
          tone(buzzerPin, buzzerFrequency + 3 * frequencyStep);
          buzzerOn = true;
          break;
        case 0xF0:
          noTone(buzzerPin);
          buzzerOn = false;
          break;
        default:
          if (!buzzerOn) {
            noTone(buzzerPin);
          }
          Serial1.write(receivedData);
          break;
      }
    }
  }

  while (Serial1.available() > 0) {
    int uartData = Serial1.read();

    if (uartData != -1) {
      uint8_t receivedData = (uint8_t)uartData;
      client.write(receivedData);
    }
  }
}