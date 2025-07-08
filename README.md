# 🦚 Bird Detector

## 🐦 About the Project

This Flutter app allows users to instantly identify bird species from images using a machine learning model built with Teachable Machine and deployed via TensorFlow Lite. The app features a visually appealing UI, smooth animations, and accurate classification of Indian bird species.

This application uses a custom-trained TensorFlow Lite model developed with `Teachable Machine`, trained on a small dataset of approximately 100 images per class.

## Screenshots
![thumbnail1](https://github.com/user-attachments/assets/acd03b4e-49f6-49b3-a06f-e77c48059dae)


## video

https://github.com/user-attachments/assets/d4aec528-c1bc-4679-9354-efec7bd441e2



## ✨ Features

- 🎯 Bird Species Classification
- 🤖 📷 Image Picker Support
- 📊 Display confidence scores in a chart
- 🌿 Modern Teal UI
- 🧠 Offline AI Inference
---

## 🐦 Trained Bird Classes

The model was built using Teachable Machine with 100 images per class for the following species:

  - Male Peafowl
  - Peahen
  - Rose Ringed Parakeet
  - Eagle
  - Bulbul
  - Robin
  - Hornbill
  - Owl
  - Trogon
  - Kingfisher

Note:
- If the prediction confidence is below 75%, the app will report: "Not a bird"

## 🧰 Packages Used

| Package          | Description                                         |
|------------------|-----------------------------------------------------|
| image_picker     | Picking images from camera or gallery               |
| tflite_flutter   | Run TensorFlow Lite model inference                 |
| image            | Image preprocessing and decoding                    |
| fl_chart         | Confidence bar charts for prediction output         |
| collection       | Utility functions for handling collections          |
| animate_do       | Add fade/slide animations to widgets                |
| google_fonts     | Use custom fonts like Poppins                       |


## ✅ **Requirements**

    Flutter SDK: Latest stable version.

    Java JDK 17 or higher.

    VS Code or Android Studio.


## 🔧 Project Setup

### Prerequisites

Before you begin, make sure you have the following installed:

1. **Flutter SDK** (Version: 3.22.3 or higher)
   - To check if Flutter is installed, run:
     ```bash
     flutter --version
     ```
   - Example output:
     ```
     Flutter 3.22.3 • channel [user-branch] • unknown source
     Framework • revision b0850beeb2 (10 months ago) • 2024-07-16 21:43:41 -0700
     Engine • revision 235db911ba
     Tools • Dart 3.4.4 • DevTools 2.34.3
     ```

2. **Java Development Kit (JDK)** (Version 17 or higher)
   - Ensure that Java 17 is installed on your machine. You can verify it by running:
     ```bash
     java -version
     ```

3. **VS Code** (or any IDE of your choice)
   - Install **VS Code** for Flutter development.
   - Install the **Flutter** and **Dart** plugins in your IDE.

---