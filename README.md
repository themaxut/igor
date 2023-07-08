# Igor - A personal assistant to answer any questions you have
#### Video Demo:  <https://youtube.com/watch?v=2Tz27t4vwkg>
## Description
### Summary
Igor is a Flutter-based mobile application that facilitates user interaction with an AI - in this case Open AI GPT 3.5turbo - in chat format.

For the backend, I used:
- Google Firebase for authentication
- Google Firestore for data persistence

To Integrate with OpenAI's API, I used the Dart library by Anas Fikhi
https://github.com/anasfik/openai

For unit tests, I used the `mockito` Dart Library as it's a popular Dart package to use for creating mock objects.
https://pub.dev/packages/mockito


## Background
The motive behind creating Igor was to explore mobile development, to work on a personal project, and to fulfill the project requirement for the CS50 course. I have been undertaking various courses in the past besides CS50x (i.e. React/TypeScript, Java, and others) as I find software engineering an enjoyable hobby and technology is one of my passions; I work in Product within the FinTech sector and collaborate closely with Software Engineers.

The idea of Igor mainly stemmed from:
1. the recent rise in popularity of LLMs
1. exploring mobile development.
   - For this, I took a Flutter course by Vandad Nahavandipoor (https://www.youtube.com/watch?v=VPvVD8t02U8) after completing the CS50 lectures, seminars and problem sets. I chose Flutter as it seemed like a good fit as it can be used across different devices and operating systems, and compiles the code natively for each platform. Plus it seems that it's also gaining some popularity recently.
1. exploring the use of a third-party API and/or library

I chose Firebase and Firestore for the backend, instead of creating one from scratch to optimize the time needed to create a workable first version, as time is a scarce commodity for me nowadays due to professional and personal/family committments.

## App structure
The application follows the BLoC (Business Logic Component) pattern. The app structure is as follows:
- `components`: Contains `typing_indicator.dart` which is used to animate the ellipses whilst waiting for the AI repsonse
- `helpers/loading`: Contains the files for the loading screen
- `models`: Contains the ChatMessage model used throughout the application.
- `services`: Includes all the services used in the application and is divided into:
  - `auth`: Contains the Firebase authentication service files and the `bloc` directory containing the Firebase authentication BLoC pattern files (`auth_bloc.dart`, `auth_event.dart`, `auth_state.dart`)
  - `chat`: Contains OpenAI service (`openai_service.dart`) which uses the `dart_openai` library and the `bloc` directory containing the Chat BLoC pattern files (`chat_bloc.dart`, `chat_event.dart`, `chat_state.dart`)
  - `firestore`: Includes Firestore service files
- `utilities/dialogs`: Contains the files defining the different dialogs used such as error and confirmation dialogs.
- `view`: Contains all the UI components of the application which are divided into:
  - `auth`: Contains the registration, login, forgot password and verification screens.
  - `chat`: Contains the Chat screens.

- `main.dart`: This is the entry point of the application. The user is presented with the login screen if not logged in, or the appropriate chat screen if logged in. This file also contains the logic to handle which Auth view (login/forgot password/registration/verification) to show based on the user's authentication status and/or action.

## Design choices
- Used BLoC patterns to separate the presentation layer from the business logic of the application as this are the best practises for Flutter's reactive style and state management. Further more this allows for better maintainability and extensibility - if I decide to do further work on this app in the future - as well as making it easier to test the code and write the unit tests.
- Used Google Firebase and Firestore as they are easy and seamless to integrate with Flutter, and could help in terms of optimizing time spent developing this app. I do not intend to publish the app in a store or use it extensively at the moment since it is just a personal project to apply my learning.
- Although the `dart_openai`library supports Streams for the Chat Completion (i.e. API response) which would allow to stream and display the response tokens as they are received, I decided to stick with using the Future as I deemed it unecessary given this application will not be published on store and it's currently only for personal use. I will consider switching to using Streams for and improved user experience if a return to it at a later time.
- I do not pass the full chat history via the API. This is a conscious decision to prevent high token usage, and consequently cost of OpenAI API use. If I decide to extend the app's features in the future, or decide to use it extensively then this is something I consider implementing at a later stage in order to improve the user experience; mainly in the context of retrieving higher quality, contextualy relevant responses over several prompts sent to the GPT model.

## General Flow and Use Cases Covered
### New user (sunny day)
1. The user opens the application and the login screen is presented
1. The user navigates to the registration screen
1. The user enters an email, password and password confirmation and then proceeds to register
1. A verification email is sent by Firebase to the user's email address
1. The user verifies their email
1. The user navigates to the login screen
1. The user logs in
1. The Greeting chat view is presented
1. The user enters a prompt
1. The chat view is presented and a response is given by Igor (aka the response from OpenAI API).

### Existing, logged-in user opens app and then logs out (sunny day)
Pre-requisites:
- the user is already logged in
- the user has already sent and received some messages within the app
- the user has not cleared the chat history

Flow:
1. the user opens the application
1. the chat view is presented with the historical messages that were exchanged
1. the user logs out
1. the login screen is presented

### User clears chat history (sunny day)
Pre-requisites:
- the user is already logged in
- the user has already sent and received some messages within the app
- the user has not cleared the chat history

Flow:
1. the user opens the application
1. the chat view is presented with the historical messages that were exchanged
1. the user clears the chat history
1. messages are removed and the greeting view is presented

### User resets password and then successfully logs in (sunny day)
Pre-requisites:
- the user already exists in Firebase
- the user is not logged in

Flow:
1. the user opens the application and the login screen is presented
1. the user taps on "Forgot Password" and the reset password screen is presented
1. the user enters their email
1. the user receives a reset password link in their inbox
1. the user open the reset password link and creates a new password
1. the user navigates to the login screen
1. the user enters their email and new password and successfully logs in