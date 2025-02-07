import 'package:flutter/material.dart';

typedef DialogActionCallback = void Function();

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelButtonText;
  final String confirmButtonText;
  final DialogActionCallback onCancel;
  final DialogActionCallback onConfirm;
  final Color backgroundColor;
  final Color cancelButtonColor;
  final Color confirmButtonColor;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onCancel,
    required this.onConfirm,
    this.backgroundColor = const Color(0xFFF0F0F0),
    this.cancelButtonColor = const Color.fromRGBO(239, 164, 200, 1),
    this.confirmButtonColor = const Color.fromRGBO(79, 165, 111, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: backgroundColor,
      child: SizedBox(
        width: 315,
        height: 203,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(38, 43, 46, 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(38, 43, 46, 1),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cancelButtonColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(130, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          cancelButtonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmButtonColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(130, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          confirmButtonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String cancelButtonText,
  required String confirmButtonText,
  required DialogActionCallback onCancel,
  required DialogActionCallback onConfirm,
  Color backgroundColor = const Color(0xFFF0F0F0),
  Color cancelButtonColor = const Color.fromRGBO(239, 164, 200, 1),
  Color confirmButtonColor = const Color.fromRGBO(79, 165, 111, 1),
  // required String cancelButtonLabel,
  // required String confirmButtonLabel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        message: message,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
        onCancel: onCancel,
        onConfirm: onConfirm,
        backgroundColor: backgroundColor,
        cancelButtonColor: cancelButtonColor,
        confirmButtonColor: confirmButtonColor,
      );
    },
  );
}
