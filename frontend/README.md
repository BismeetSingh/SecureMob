# SecMob

SecMob facilitates executing predefined commands on a server via a REST API. This repo is the front end that runs on the client's mobile device.

## Basic Idea of SecMob

Executable commands are predefined on the server in a format (JSON in this case). These commands are parsed by the backend system and sent over to the client via a REST API. The client receives randomly unique IDs of the commands and requests execution of the commands by sending back the ID to the server. The server executed the command defined on its end and returns the result to the client. The communication between the client and server is encrypted using AES-256-GCM and optional SSL.

**Note**: This app is developed and tested only on Android devices.

- [SecMob](#secmob)
  - [Basic Idea of SecMob](#basic-idea-of-secmob)
  - [Architecture](#architecture)
  - [API Reference](#api-reference)
  - [Directory Structure](#directory-structure)
  - [Miscellaneous Information](#miscellaneous-information)
    - [Key Exchange](#key-exchange)
    - [Secure Storage](#secure-storage)
    - [State Management](#state-management)
    - [Architecture](#architecture-1)
    - [Encryption](#encryption)
    - [Running Locally](#running-locally)


## Architecture

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1671632406350/WLIrB1aiG.png)

1. The Get Commands Handler makes an API call to `/getCommands` API endpoint and gets a list of available commands

2. The Run Commands Handler makes an API call to `/runCommand` API endpoints and gets the execution result as a response

3. The Display module displays the output on the screen

4. The Request module gets the API body and encrypts it and sends a response

5. The Response module gets the response from the API, decrypts it, and returns the response body to the handlers

6. The Key Management module stores the AES-256 key in a secure database and makes it available when needed for encryption and decryption

7. The API requests made are `/getCommands` and `/runCommand`

8. The response is received from the API


## API Reference

API responses are base64 encoded, AES-256-GCM encoded strings.

1. `/getCommands`: HTTP Post request to get the list of available commands from the server.


**Request Body**: None

**Response**:

Following is the JSON description

```json
{
   "status":1
   "message":"Data Fetched Successfully",
   "payload":[
      {
         "id":"UfKvDP",
         "title":"Get Docker Images"
      },
      {
         "id":"ttLNpU",
         "title":"Echo Hi"
      },
      {
         "id":"krgDkm",
         "title":"Git Status"
      }
   ],
}
```

`status`: Indicates the status of command execution. Values

* `0`: Command execution failed with an error

* `1`: Command execution successful


`message`: Informative message regarding the operation

`payload`: Response payload. Is always a list of objects. The objects contain response data

Command Object:

```json
{
    "id":"krgDkm",
    "title":"Git Status"
}
```

`id`: Randomly generated ID for commands by the server. Changes when the server restarts or commands are refreshed.

`title`: Descriptive title of the command

Response when no commands are defined

```json
{
   "message":"No Commands Found",
   "payload":null,
   "status":1
}
```

1. `/runCommand`: HTTP Post request to send execution request to the server


Request Body:

```json
{
    "commandId":"uXrXrS"
}
```

The server will parse the command with the provided ID and send its execution response

Response:

1. Command execution successful

    HTTP Status: `200`

    ```json
    {
       "message":"Command Executed Successfully",
       "payload":[
          {
             "output":"On branch main nothing to commit, working tree clean"
          }
       ],
       "status":1
    }
    ```

    Payload Object: The payload is always a list of objects. The object contains the execution result as follows

    ```json
    {
        "output":"On branch main nothing to commit, working tree clean"
    }
    ```

    `output`: A string of command execution responses.

2. Command execution failed

    HTTP Status: `200`

    ```json
    {
       "message":"Command Execution Failed",
       "payload":[
          {
             "output":"exec: \"echo\": executable file not found in %PATH%"
          }
       ],
       "status":0
    }
    ```

    Note the `status` here.

3. Invalid Body

    HTTP Status: `206`

    ```json
    {
        "message": "Invalid Body",
        "payload": null,
        "status": 0
    }
    ```


## Directory Structure

```bash
│   pubspec.yaml
│
├───lib
│   │   main.dart
│   │
│   ├───blocs
│   │       commands_display_bloc.dart
│   │       commands_execution_bloc.dart
│   │       prerequisites_bloc.dart
│   │
│   ├───controllers
│   │   ├───generics
│   │   │       api_communicator.dart
│   │   │
│   │   └───repositories
│   │           commands_repository.dart
│   │
│   ├───models
│   │       command_execution_result_model.dart
│   │       display_command_model.dart
│   │
│   ├───utils
│   │       api_status.dart
│   │       constants.dart
│   │
│   └───views
│       ├───screens
│       │       display_commands_screen.dart
│       │       display_command_output.dart
│       │       prerequisites_screen.dart
│       │
│       └───widgets
│               display_command_widget.dart
│               display_execution_result_widget.dart
```

`pubspec.yaml`: Pubspec file with dependencies and other information

`lib/main.dart`: The main file of the program

`lib/blocs/`: Contains BLoCs

`blocs/commands_display_bloc.dart`: Facilitates fetching and displaying commands from API onto the screen

`blocs/commands_execution_bloc.dart`: Facilitates sending command execution requests and displaying the result

`blocs/prerequisites.dart`: Facilitates the handling of prerequisites for app functioning which are:

* AES Key

* Server URI


`lib/controllers/`: Has controllers that interact with external services

`controllers/generics/`: Has generic controllers that can be used by anyone

`controllers/generics/api_communicator.dart`: Has HTTP request methods to interact with APIs

`controllers/repositories/`: BLoC repositories

`controllers/repositories/commands_repository.dart`: Facilitates commands fetching and execution request handling with state management

`lib/models/`: Has model classes

`lib/utils/`: Has utility classes and functions

`utils/api_status.dart`: API response status classes

`utils/constants.dart`: Has constant variables

`lib/views`: Has views classes i.e. screens and widgets

## Miscellaneous Information

### Key Exchange

The AES key is exchanged by scanning a QR code. The user must generate the key and generate QR from it.

### Secure Storage

[flutter\_secure\_storage](https://pub.dev/packages/flutter_secure_storage) package is used to store the AES key and Server URI securely

### State Management

BLoC

### Architecture

Model View View Model (MVVM)

### Encryption

AES-256-GCM

### Running Locally

1. Clone the repo

2. Run `flutter pub get`

3. Run `flutter run`
