import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/model/create_session_model.dart';
import 'package:my_flutter_app/mentor/service/create_session_service.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';


class CreateSessionProvider with ChangeNotifier {
  final CreateSessionService _createSessionService = CreateSessionService();
  String _responseData = ''; // Property to store the response from the server
  String get responseData => _responseData; // Getter to access the response from the server

  Future<bool> submitSession({
    required String category,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required int maxParticipants,
    required String description,
    required String title,
    required BuildContext context,
  }) async {
    String? mentorId = await UserPreferences.getUserId();
    if (mentorId == null) {
      print('Error: No mentorId found');
      return false;
    }

    var sessionModel = CreateSessionModels(
      category: category,
      dateTime: date,
      startTime: startTime,
      endTime: endTime,
      maxParticipants: maxParticipants,
      description: description,
      title: title,
    );

    try {
      final response = await _createSessionService.createSession(sessionModel, mentorId);

      

      if (response.statusCode == 200) {
        _responseData = response.data.toString(); // Set the response data
        notifyListeners(); // Notify listeners of the change in response data
        return true; // Return true because the data was successfully sent
      } else {
        // If the status code is not 200, show a dialog with the error message
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Upss gagal",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              content: Text(
                response.data.toString(), // Use toString() to ensure it's a string
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
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Upss gagal",
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
