# WebApp for SysAdmin

## Overview

This demo Flask application is designed for SysAdmin to manage a member database, allowing users to view, add, edit, and delete member records and permissions. The application uses SQLite for data storage and includes features such as user authentication, member search, and exporting selected member information to JSON.

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Usage](#usage)
  - [Logging In](#logging-in)
  - [Members](#members)
  - [Adding a Member](#adding-a-member)
  - [Editing a Member](#editing-a-member)
  - [Deleting a Member](#deleting-a-member)
  - [Member Information](#member-information)
4. [JSON Export](#json-export)
5. [Contributing](#contributing)
6. [License](#license)

## Installation

1. Clone the repository:
  
  ```bash
  git clone https://github.com/BismeetSingh/SecureXAccess
  ```
  
2. Change directory to webapp
  
  ```bash
  cd SecureXAccess/webapp
  ```
  
  3. Install the required dependencies:
    
  
  ```bash
  pip install -r requirements.txt
  ```
  

## Configuration

- **Database**: The application uses SQLite. The database file is named `sqlite.db`. You can configure the database connection in the `app.py` file.
  
- **Session**: Session settings are configured in the `app.config` section of the `app.py` file.
  

## Usage

### Logging In

The application has a simple login system. SysAdmin need to provide a valid username and password.

![snap 1png](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(1).png?msec=1702776726244)

### Members

- The main page (`/members`) displays a list of members.
- Members can be searched using the search bar.
- Recent members are displayed by default.
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(10).png?msec=1702776999585)

### Adding a Member

- Click the "Add Member" button on the main page.
- Fill in the required information (Name, Email) and select permissions.
- Click "Add Member" to save the new member.
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(2).png?msec=1702776750916)
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(3).png?msec=1702776757140)

### Editing a Member

- Click the "Edit" button next to a member on the main page.
- Update the member's information and permissions.
- Click "Edit Member" to save the changes.
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(6).png?msec=1702776780809)

### Deleting a Member

- Click the "Delete" button next to a member on the main page.
- A confirmation modal will appear.
- Click "Delete" to remove the member.
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(7).png?msec=1702776790877)

### Member Information

- Click on a member's name to view detailed information.
- The member's ID, name, email, date of joining, and permissions are displayed.
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(5).png?msec=1702776799525)

## JSON Export

- The application allows users to export selected member commands to a JSON file.
- Select the desired commands and click the "Export" button.
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(9).png?msec=1702776927177)

## Search Support
![](file://C:\Users\Administrator\Desktop\SecureXcess\webapp\screenshots\snap%20(8).png?msec=1702776927177)
