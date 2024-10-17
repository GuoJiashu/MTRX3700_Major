#include <WiFiNINA.h>
#include <stdint.h>

// Wi-Fi credentials
const char ssid[] = "JG";          // Replace with your Wi-Fi network name
const char pass[] = "20030921";    // Replace with your Wi-Fi network password
int status = WL_IDLE_STATUS;

WiFiClient client;

// Server details
IPAddress server(172, 20, 10, 7); // Replace with your server's IP address
const uint16_t port = 80;         // Replace with your server's port

// Buffer to store incoming data from Serial1
String serial1Buffer = "";

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);      // set LED pin as output
  digitalWrite(LED_BUILTIN, LOW);    // switch off LED pin
  // Initialize Serial communication for debugging
  Serial.begin(115200);
  while (!Serial) { ; } // Wait for Serial to be ready (needed for some boards)

  // Initialize Serial1 for UART communication
  Serial1.begin(115200); // Ensure this matches the other Arduino's baud rate

  // Connect to Wi-Fi
  while (status != WL_CONNECTED) {
    Serial.print("Attempting to connect to SSID: ");
    Serial.println(ssid);
    status = WiFi.begin(ssid, pass);
    delay(5000); // Wait 5 seconds before retrying
  }
  Serial.println("Connected to Wi-Fi!");

  // Connect to the server
  Serial.print("Connecting to server at ");
  Serial.print(server);
  Serial.print(":");
  Serial.println(port);
  
  while (!client.connect(server, port)) {
    Serial.println("Failed to connect to server. Retrying in 5 seconds...");
    delay(5000);
  }
  Serial.println("Connected to server!");
}

void loop() {
  // Handle incoming data from the Wi-Fi server
  if (client.available()) {
    int incomingByte = client.read(); // Read one byte at a time

    if (incomingByte != -1) {
      uint8_t receivedData = (uint8_t)incomingByte;

      // 打印收到的字节，显示为十六进制
      Serial.print("Received from server: 0x");
      Serial.println(receivedData, HEX);

      // 发送到另一个 Arduino（通过 Serial1）
      Serial1.write(receivedData);
      Serial.print("Sent to another Arduino via UART: 0x");
      Serial.println(receivedData, HEX);

      digitalWrite(LED_BUILTIN, HIGH);
    }
  }

  // Handle incoming data from Serial1 (another Arduino)
  if (Serial1.available() > 0) {
    uint8_t uartData = Serial1.read();

    // 打印收到的 UART 数据
    Serial.print("Received from UART: 0x");
    Serial.println(uartData, HEX);

    // Send the received data to the server
    if (client.connected()) {
      client.write(uartData); // 直接发送字节
      Serial.print("Sent to server: 0x");
      Serial.println(uartData, HEX);
    } else {
      Serial.println("Server connection lost. Attempting to reconnect...");
      while (!client.connect(server, port)) {
        Serial.println("Reconnecting to server failed. Retrying in 5 seconds...");
        delay(5000);
      }
      Serial.println("Reconnected to server.");
      client.write(uartData);
      Serial.print("Sent to server: 0x");
      Serial.println(uartData, HEX);
    }
  }

  // Handle incoming data from USB Serial (e.g., Serial Monitor)
  if (Serial.available() > 0) {
    String userInput = Serial.readStringUntil('\n');
    userInput.trim(); // Remove any leading/trailing whitespace

    if (userInput.length() > 0) {
      // Convert the input string to a number
      uint8_t userData = (uint8_t)strtoul(userInput.c_str(), NULL, 0); // 支持十进制和十六进制输入

      // Send the user input to the server
      if (client.connected()) {
        client.write(userData);
        Serial.print("Sent to server: 0x");
        Serial.println(userData, HEX);
      } else {
        Serial.println("Server connection lost. Attempting to reconnect...");
        while (!client.connect(server, port)) {
          Serial.println("Reconnecting to server failed. Retrying in 5 seconds...");
          delay(5000);
        }
        Serial.println("Reconnected to server.");
        client.write(userData);
        Serial.print("Sent to server: 0x");
        Serial.println(userData, HEX);
      }
    } else {
      Serial.println("No input detected. Nothing sent.");
    }
  }
}