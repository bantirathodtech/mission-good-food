**image_picker_guide.md:**
```markdown
# Image Picker Implementation Guide

## Package Information
- Package: image_picker
- Version: ^0.8.0
- Platform Support: Android, iOS, Web

## Features
- Gallery Image Selection
- Camera Capture
- Multiple Image Selection
- Image Compression

## Implementation Steps
1. Permission Configuration
2. Image Picker Setup
3. Image Processing
4. Error Handling

## Usage Example
```dart
final ImagePicker picker = ImagePicker();
final XFile? image = await picker.pickImage(
  source: ImageSource.gallery
);