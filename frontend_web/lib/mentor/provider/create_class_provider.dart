// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_flutter_app/Mentor/model/create_class_models.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';

import '../service/create_class_service.dart';




class CreateClassProvider with ChangeNotifier {
  final CreateClassService _createClassService = CreateClassService();
  String _responseData = ''; // Property to store the response from the server
  String get responseData => _responseData; // Getter to access the response from the server

  Future<bool> submitClass({
    required String address,
    required List<String> targetLearning,
    required String schedule,
    required String location,
    required DateTime endDate,
    required DateTime startDate,
    required int capacitymentee,
    required String educationLevel,
    required String category,
    required String name,
    required String description,
    required List<String> terms,
    required int price,
    required int durationInDays,
    required BuildContext context, // Add BuildContext parameter
  }) async {
    // Get mentorId from shared preferences or other source
    String? mentorId = await UserPreferences.getUserId();
    if (mentorId == null) {
      print('Error: No mentorId found');
      return false;
    }

    // Create an instance of ClassModel with the provided data
    var classModel = CreateClassModels(
      address: address,
      targetLearning: targetLearning,
      schedule: schedule,
      location: location,
      endDate: endDate,
      startDate: startDate,
      maxParticipants: capacitymentee,
      educationLevel: educationLevel,
      category: category,
      name: name,
      description: description,
      terms: terms,
      price: price,
      durationInDays: durationInDays,
    );

    try {
      // Send data to the server using CreateClassService
      final response = await _createClassService.createClass(classModel, mentorId);

      if (response.statusCode == 200) {
        _responseData = response.toString(); // Set the response data
        notifyListeners(); // Notify listeners of the change in response data
        return true; // Return true because the data was successfully sent
      } else {
        // If the status code is not 200, show a dialog with the error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Error",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              content: Text(
                response.data['message'],
                style: const TextStyle(),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return false; // Return false because there was an error
      }
    } catch (e) {
      // If there was an error sending data to the server, show a dialog with the error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Error",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            content: Text(
              e.toString(),
              style: const TextStyle(),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false; // Return false because there was an error
    }
  }
}
