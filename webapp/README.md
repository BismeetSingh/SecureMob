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

![snap (1)](https://github.com/BismeetSingh/SecureMob/assets/83116240/454c66ef-80b6-4444-912a-105af1c7b028)


### Members

- The main page (`/members`) displays a list of members.
- Members can be searched using the search bar.
- Recent members are displayed by default.

![snap (10)](https://github.com/BismeetSingh/SecureMob/assets/83116240/968df2f9-2c22-48ed-bfc8-f5cf0f19a5f4)


### Adding a Member

- Click the "Add Member" button on the main page.
- Fill in the required information (Name, Email) and select permissions.
- Click "Add Member" to save the new member.

![snap (2)](https://github.com/BismeetSingh/SecureMob/assets/83116240/b143f810-3aed-4938-ae76-7ed0c8c2f671)
![snap (3)](https://github.com/BismeetSingh/SecureMob/assets/83116240/16e69bc1-9a68-4555-9b11-0e35b68647f8)




### Editing a Member

- Click the "Edit" button next to a member on the main page.
- Update the member's information and permissions.
- Click "Edit Member" to save the changes.

![snap (6)](https://github.com/BismeetSingh/SecureMob/assets/83116240/368f1b94-0790-402a-86eb-05ffaf00504e)


### Deleting a Member

- Click the "Delete" button next to a member on the main page.
- A confirmation modal will appear.
- Click "Delete" to remove the member.

![snap (7)](https://github.com/BismeetSingh/SecureMob/assets/83116240/c2c68bfe-be9b-4fd6-844d-b0f09dd6fd89)


### Member Information

- Click on a member's name to view detailed information.
- The member's ID, name, email, date of joining, and permissions are displayed.

![snap (5)](https://github.com/BismeetSingh/SecureMob/assets/83116240/75003926-567c-4ff4-a856-eafdc42d84ad)


## JSON Export

- The application allows users to export selected member commands to a JSON file.
- Select the desired commands and click the "Export" button.

![snap (9)](https://github.com/BismeetSingh/SecureMob/assets/83116240/8254e064-ec42-46f8-82cf-5ede35f96805)


## Search Support

![snap (8)](https://github.com/BismeetSingh/SecureMob/assets/83116240/0751eab4-470c-494b-8c57-2510ddf8810c)

