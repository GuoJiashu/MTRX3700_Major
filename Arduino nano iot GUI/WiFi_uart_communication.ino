#include <WiFiNINA.h>

// Wi-Fi credentials
const char ssid[] = "Kan";          // Replace with your Wi-Fi network name
const char pass[] = "LYKan0202";    // Replace with your Wi-Fi network password

WiFiClient client;

// Server details
IPAddress server(172, 20, 10, 7); // Replace with your server's IP address
const uint16_t port = 80;         // Replace with your server's port

void setup() {

  // Initialize Serial communication for debugging
  Serial.begin(115200);
  while (!Serial) { ; } // Wait for Serial to be ready (needed for some boards)

  // Initialize Serial1 for UART communication with FPGA
  Serial1.begin(115200); // Ensure this matches the FPGA's UART configuration

  // Connect to Wi-Fi
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print("Attempting to connect to SSID: ");
    Serial.println(ssid);
    WiFi.begin(ssid, pass);
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
  // Check server connection periodically
  if (!client.connected()) {
    Serial.println("Server connection lost. Attempting to reconnect...");
    client.stop();
    delay(1000);
    while (!client.connect(server, port)) {
      Serial.println("Reconnecting to server failed. Retrying in 5 seconds...");
      delay(5000);
    }
    Serial.println("Reconnected to server.");
  }

  // Handle incoming data from the Wi-Fi server
  while (client.available()) {
    int incomingByte = client.read(); // Read one byte at a time

    if (incomingByte != -1) {
      uint8_t receivedData = (uint8_t)incomingByte;

      Serial.print("Received from server: ");
      for (int i = 7; i >= 0; i--) {
        Serial.print(bitRead(receivedData, i));
      }
      Serial.println();

      Serial1.write(receivedData);
      Serial.print("Sent to FPGA via UART: ");
      for (int i = 7; i >= 0; i--) {
        Serial.print(bitRead(receivedData, i));
      }
      Serial.println();
    }
  }

  // Handle incoming data from Serial1 (FPGA)
  while (Serial1.available() > 0) {
    int uartData = Serial1.read();

    if (uartData != -1) {
      uint8_t receivedData = (uint8_t)uartData;

      // 打印收到的 UART 数据
      Serial.print("Received from FPGA via UART: ");
      for (int i = 7; i >= 0; i--) {
        Serial.print(bitRead(receivedData, i));
      }
      Serial.println();

      // Send the received data to the server
      client.write(receivedData);
      Serial.print("Sent to server: ");
      for (int i = 7; i >= 0; i--) {
        Serial.print(bitRead(receivedData, i));
      }
      Serial.println();
    }
  }

  // Handle incoming data from USB Serial (e.g., Serial Monitor)
  if (Serial.available() > 0) {
    String userInput = Serial.readStringUntil('\n');
    userInput.trim(); // Remove any leading/trailing whitespace

    if (userInput.length() > 0) {
      // Convert the input string to a number
      char* endPtr;
      uint8_t userData = (uint8_t)strtoul(userInput.c_str(), &endPtr, 0);

      if (*endPtr != '\0') {
        Serial.println("Invalid input. Please enter a valid number.");
      } else {
        // Send the user input to the server
        client.write(userData);
        Serial.print("Sent to server: ");
        for (int i = 7; i >= 0; i--) {
          Serial.print(bitRead(userData, i));
        }
        Serial.println();
      }
    } else {
      Serial.println("No input detected. Nothing sent.");
    }
  }
}