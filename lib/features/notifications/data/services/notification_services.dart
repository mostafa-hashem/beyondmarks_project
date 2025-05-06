// import 'dart:convert';
//
// import 'package:Talksy/features/groups/data/model/group_data.dart';
// import 'package:Talksy/route_manager.dart';
// import 'package:Talksy/ui/screens/call_screen.dart';
// import 'package:Talksy/utils/path.dart';
// import 'package:Talksy/utils/data/models/user.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:http/http.dart' as http;
//
// class NotificationsServices {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final GlobalKey<NavigatorState> navigatorKey;
//
//   NotificationsServices(this.navigatorKey);
//
//   Future<String?> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final callId = message.data['callId'];
//       final isVideo = message.data['isVideo'] == 'true';
//
//       if (callId != null) {
//         navigatorKey.currentState?.push(
//           MaterialPageRoute(
//             builder: (context) =>
//                 CallScreen(callId: callId as String? ?? "", isVideo: isVideo),
//           ),
//         );
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _handleNotificationClick(message);
//     });
//
//     await _firebaseMessaging.getInitialMessage();
//
//     return fCMToken;
//   }
//
//   static Future<void> handleBackgroundMessage(RemoteMessage message) async {
//     // Handle background message
//   }
//
//   Future<void> _handleNotificationClick(RemoteMessage message) async {
//     final data = message.data;
//     if (data['friendData'] != null) {
//       final friend = User.fromJson(
//         jsonDecode(data['friendData'] as String) as Map<String, dynamic>,
//       );
//       navigatorKey.currentState?.pushNamed(
//         Routes.friendChatScreen,
//         arguments: friend,
//       );
//     } else if (data['groupData'] != null) {
//       final group = Group.fromJson(
//         jsonDecode(data['groupData'] as String) as Map<String, dynamic>,
//       );
//
//       navigatorKey.currentState?.pushNamed(
//         Routes.groupChatScreen,
//         arguments: group,
//       );
//     } else if (data['isFriendRequest'] == 'true') {
//       navigatorKey.currentState?.pushNamed(
//         Routes.friendAndGroupRequestsScreen,
//       );
//     }
//   }
//
//   Future<String> getAccessToken() async {
//     // Your client ID and client secret obtained from Google Cloud Console
//     final serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "chat-app-319",
//       "private_key_id": "fcf75af68115d39ea789e3773dcc661ae1338cb1",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCQNG2Gj/onNiFA\nEWCG7t1613dc7tK0MlHEK+9ELSeaKIwpOFKPXsNZdPgtCQpq77XPOWjBSfTbqeGj\nKHjGShlp28W3l77iigNqgn5KKC06zJz9Y6oixUbxNysAKUayEGBsMUvDhNccrdOA\nopObOjJdNdr1r1Ds3NJEIJjVodWY5S/HFf+dTF31TYx6l58JKoFYwV41BNVfxfQj\nrOoIQpNx3TXKGIOcI1gyYetMVLJmLufSiaxzE9Fc3eaPRVmQO4p8uzg4hs+D/9zE\nJYToz3U5CKhibSPHGx1gkZL40fEQGBIKfXEZWmHdhgqYhgABf37gQqi9j6dJTVgh\nx2RdJisnAgMBAAECggEADqDC23uPbJrZFJ6upAFnBicFPLAdP5o7ISMzyj6qXcDv\nNt83wMNkHZb39dmM7PwT/Uldjv3pkL7S3LImTjcGDO72R4FlI6XMYumJ1gvtSqGm\n6y1I/O32HFH0UrfdLALtRQxbGyJGj+oyIkJbpstogHwOEg4Or3hW/AIyfrlD6ZZv\nDo5W9R69uHLjk16MpgBMbxgIYGHzGnVq29E8L2MbQHsLDBmOGxMgdTXAP4DTk+8S\nn+F6lcLAIGos/+oF6pr23OJoSIb2x/u6AoHa2AunW9pe69k/e8yitHYKRpUlDi6P\nym4mSHw6gGcnyjW2aGk1FM/TMgGoLj1t+USDDb5aQQKBgQDLj2Ta+TuwmXypq3MY\nuDSIt7Cl65N7nyerAacpW8aKzzcv5/e/NaJxvQdR7ZM7VVjFdkX0xli3STKoxBNz\nM4mYXoC2utDmCFOiMHsNWRqc2+lTDWUZ0XqUOtmRBHPxVCecbEM6MQTprQUThteo\nygdqHC6irbDqZWhhy5rhYtapswKBgQC1WppxNxmAaafCOLnvMLtYdcO5gM3xdR93\nmlE6VaNdNuRsgEuAwaR/3FDWx8OAvY64Hn52ZQ4NUwqIQ69dZ3GBEJ/3rJCpwTLG\ngVdkY2c8gMqCYLsz+D20irwPo61Wyamu4SgC5cXMHLlVSJzB4OsVxDKFh4UB5nNu\n1tkrF9SWvQKBgBqDWseKntOpqisPQbZ+h5knE8MIo/T+DdSgKn2gjoOV6cI7nHEz\nMy1NSZ7KKtsXirBtbz8qdnOo/QguQbpHhCxsYqdqPbs4amw9lElwyZ6UphdDL1/l\ngOm9oIja458TLvWYxEjYCaPF/VtFvOEnL0AK26gkp15gRvA17L5eeUcxAoGAF0iA\nl5R5Y7Es5pSd2oWpJ9xGuqQ8zIk69wIK97BS/v6zKPL3vpod4oSIpGqVQQwVLLJN\njim/Ohq1OXVnKFjFi8p0nzm6gPDa8f1dGPhiIrRuS3rbzfpLAcjmCCP9dy0A6gDi\nQCz7zg7KBJcD+ShFRlAgJGCXxPyvSUWwMAYpNwkCgYAKyf6AoV93E4P4rijyViDk\nU6hga5ePKdeX21jqwhn9g35ij/uyvAks6FKS66jnggER8utkBF3apRQKiUmXxjw2\nRr6s2SrFrzhj/m3rKE/zbGsmAjIhioheUYDl5xdK8w4VuGpyn/ickQ26lwmTwDJ/\nHWgAfw0b6XLwnKAN4MIsZA==\n-----END PRIVATE KEY-----\n",
//       "client_email":
//           "firebase-adminsdk-v51fn@chat-app-319.iam.gserviceaccount.com",
//       "client_id": "103329749487187122963",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-v51fn%40chat-app-319.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com",
//     };
//
//     final List<String> scopes = [
//       "https://www.googleapis.com/auth/userinfo.email",
//       "https://www.googleapis.com/auth/firebase.database",
//       "https://www.googleapis.com/auth/firebase.messaging",
//     ];
//
//     final http.Client client = await auth.clientViaServiceAccount(
//       auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//       scopes,
//     );
//
//     // Obtain the access token
//     final auth.AccessCredentials credentials =
//         await auth.obtainAccessCredentialsViaServiceAccount(
//       auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//       scopes,
//       client,
//     );
//
//     // Close the HTTP client
//     client.close();
//
//     // Return the access token
//     return credentials.accessToken.data;
//   }
//
//   Future<void> sendNotification({
//     required String fcmToken,
//     required String title,
//     required String body,
//     String? callId,
//     String? imageUrl,
//     User? friendData,
//     Group? groupData,
//     String? isFriendRequest,
//   }) async {
//     final String serverKey = await getAccessToken();
//
//     final notification = {
//       'title': title,
//       'body': body,
//       'click_action': "FLUTTER_NOTIFICATION_CLICK",
//       if (imageUrl != null) 'image': imageUrl,
//     };
//
//     final data = {
//       'message': {
//         'token': fcmToken,
//         'notification': notification,
//         'data': {
//           'click_action': "FLUTTER_NOTIFICATION_CLICK",
//           'current_user_fcm_token': fcmToken,
//           'title': title,
//           'body': body,
//           'callId'
//               'isFriendRequest': isFriendRequest ?? 'false',
//           if (friendData != null) 'friendData': jsonEncode(friendData),
//           if (groupData != null) 'groupData': jsonEncode(groupData),
//           if (imageUrl != null) 'image': imageUrl,
//         },
//       },
//     };
//
//     final response = await http.post(
//       Uri.parse(FirebasePath.fcmUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $serverKey',
//       },
//       body: jsonEncode(data),
//     );
//
//     if (response.statusCode == 200) {
//       debugPrint('Notification sent successfully');
//     } else {
//       // debugPrint('Failed to send notification: ${response.body}');
//     }
//   }
// }
