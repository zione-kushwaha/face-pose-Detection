# Flutter Pose Detection with Villain Effects

A real-time pose and face detection app with villainous visual effects using MediaPipe ML Kit.

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── screens/                          # UI Screens
│   └── pose_detection_screen.dart    # Main detection screen
├── services/                         # Business Logic Services  
│   ├── camera_service.dart           # Camera management
│   └── ml_detection_service.dart     # ML pose/face detection
├── widgets/                          # Custom Widgets
│   └── pose_and_face_painter.dart    # Visual effects painter
├── models/                           # Data Models
│   └── detection_result.dart         # Detection result structure
└── utils/                            # Utilities & Helpers
    ├── coordinate_translator.dart     # Camera-to-screen coordinate mapping
    ├── pose_connections.dart          # Pose landmark connections
    └── constants.dart                 # App constants and settings
```

## 🏗️ Architecture Overview

### **Separation of Concerns**

1. **main.dart**: Minimal app entry point with camera initialization
2. **screens/**: Contains UI screens and user interaction logic
3. **services/**: Business logic for camera and ML processing
4. **widgets/**: Reusable UI components and custom painters
5. **models/**: Data structures for type safety
6. **utils/**: Helper functions and configuration

### **Key Components**

#### **CameraService**
- Manages camera initialization and permissions
- Handles front/back camera selection
- Controls image stream processing
- Provides camera status updates

#### **MLDetectionService**  
- Initializes pose and face detectors
- Processes camera frames with performance optimization
- Implements frame skipping for better performance
- Returns structured detection results

#### **PoseAndFacePainter**
- Custom painter for villainous visual effects
- Draws pose landmarks with muscular effects
- Renders geometric face mesh overlays
- Applies villain-themed eye and face effects

#### **CoordinateTranslator**
- Translates ML detection coordinates to screen space
- Handles front/back camera coordinate flipping
- Scales coordinates for different screen sizes

## 🎨 Visual Effects Features

### **Pose Detection**
- ✨ Muscular glow effects on pose landmarks
- 🔴 Multi-layered red lighting effects
- 💪 Enhanced connection lines for powerful appearance
- 🌟 Shadow and highlight effects

### **Face Detection**
- 🎭 Geometric wireframe face mesh
- 👁️ Villainous eye effects with crosshairs
- ⚡ Targeting rings and geometric overlays
- 🗡️ Scar marks and dark face outlines
- 📐 Grid overlay for cyberpunk aesthetic

## ⚡ Performance Optimizations

### **Frame Processing**
- **Frame Skipping**: Processes every 3rd frame for 3x performance boost
- **Fast Models**: Uses base pose detection and fast face detection models
- **Reduced Effects**: Simplified visual effects while maintaining quality

### **Rendering Optimizations**
- **Simplified Mesh**: Reduced mesh complexity from 8x6 to 4x3 grid
- **Reduced Blur**: Lower blur radius for faster rendering
- **Smart Repainting**: Optimized shouldRepaint logic
- **Essential Landmarks**: Only processes key facial landmarks

## 🛠️ Usage Instructions

### **Running the App**
```bash
flutter pub get
flutter run
```

### **Customizing Effects**
1. **Visual Settings**: Edit `utils/constants.dart`
2. **Pose Connections**: Modify `utils/pose_connections.dart`
3. **Paint Effects**: Customize `widgets/pose_and_face_painter.dart`

### **Performance Tuning**
- Adjust `frameSkipRate` in constants for performance vs accuracy
- Modify blur radius and stroke width for visual quality vs performance
- Change detector models in `ml_detection_service.dart`

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ✅ Front and back camera support
- ✅ Portrait and landscape orientations

## 🔧 Dependencies

```yaml
dependencies:
  camera: ^0.10.5+5
  google_mlkit_pose_detection: ^0.6.0
  google_mlkit_face_detection: ^0.6.0
  permission_handler: ^11.0.1
```

## 🎯 Key Benefits of This Structure

1. **Maintainability**: Clear separation makes code easier to understand and modify
2. **Testability**: Services can be unit tested independently
3. **Reusability**: Widgets and utilities can be reused across the app
4. **Scalability**: Easy to add new features without affecting existing code
5. **Performance**: Optimized for real-time processing with frame skipping
6. **Debugging**: Issues can be isolated to specific components

## 🚀 Future Enhancements

- Add more villain effect themes
- Implement gesture recognition
- Add recording functionality
- Create custom pose detection models
- Add augmented reality features
