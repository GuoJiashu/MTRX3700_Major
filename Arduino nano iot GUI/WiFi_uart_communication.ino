#include <WiFiNINA.h>

// Wi-Fi credentials
const char ssid[] = "JG";          // Replace with your Wi-Fi network name
const char pass[] = "20030921";    // Replace with your Wi-Fi network password
int status = WL_IDLE_STATUS;

WiFiClient client;

// Server details
IPAddress server(172, 20, 10, 7); // Replace with your server's IP address
const uint16_t port = 70;         // Replace with your server's port

// Buffer to store incoming data from Serial1
String serial1Buffer = "";

void setup() {
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
    String serverData = client.readStringUntil('\n');
    serverData.trim(); // Remove any leading/trailing whitespace

    if (serverData.length() > 0) {
      Serial.println("Received from server: " + serverData);
      
      // Send the received data to the other Arduino via Serial1
      Serial1.println(serverData);
      Serial.println("Sent to another Arduino via UART: " + serverData);
    }
  }

  // Handle incoming data from Serial1 (another Arduino)
  while (Serial1.available() > 0) {
    char incomingByte = Serial1.read();
    if (incomingByte == '\n') {
      // Complete message received
      serial1Buffer.trim(); // Clean up the received data
      if (serial1Buffer.length() > 0) {
        Serial.println("Received from UART: " + serial1Buffer);
        
        // Send the received data to the server
        if (client.connected()) {
          client.println(serial1Buffer);
          Serial.println("Sent to server: " + serial1Buffer);
        } else {
          Serial.println("Server connection lost. Attempting to reconnect...");
          while (!client.connect(server, port)) {
            Serial.println("Reconnecting to server failed. Retrying in 5 seconds...");
            delay(5000);
          }
          Serial.println("Reconnected to server.");
          client.println(serial1Buffer);
          Serial.println("Sent to server: " + serial1Buffer);
        }
        // Clear the buffer after processing
        serial1Buffer = "";
      }
    } else {
      // Append incoming byte to the buffer
      serial1Buffer += incomingByte;
    }
  }

  // Handle incoming data from USB Serial (e.g., Serial Monitor)
  if (Serial.available() > 0) {
    String userInput = Serial.readStringUntil('\n');
    userInput.trim(); // Remove any leading/trailing whitespace

    if (userInput.length() > 0) {
      // Send the user input to the server
      if (client.connected()) {
        client.println(userInput);
        Serial.println("Sent to server: " + userInput);
      } else {
        Serial.println("Server connection lost. Attempting to reconnect...");
        while (!client.connect(server, port)) {
          Serial.println("Reconnecting to server failed. Retrying in 5 seconds...");
          delay(5000);
        }
        Serial.println("Reconnected to server.");
        client.println(userInput);
        Serial.println("Sent to server: " + userInput);
      }
    } else {
      Serial.println("No input detected. Nothing sent.");
    }
  }
}