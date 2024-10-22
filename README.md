# Car Workshop Mobile App

Welcome to the Car Workshop Mobile App! This Flutter application allows users to book car servicing, view services, and manage appointments. It's designed with role-based access, enabling users, mechanics, and admins to interact efficiently within the app.

## Screenshot 
![Alt text](https://res.cloudinary.com/dntre6bam/image/upload/v1729626199/1_frksob.png)
![Alt text](https://res.cloudinary.com/dntre6bam/image/upload/v1729626200/2_mwslni.png)
![Alt text](https://res.cloudinary.com/dntre6bam/image/upload/v1729626200/3_slz2ss.png)
![Alt text](https://res.cloudinary.com/dntre6bam/image/upload/v1729626201/4_pqytxl.png)


## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [App Access](#app-access)
- [Contributing](#contributing)
- [License](#license)

## Features

1. **User Authentication**: Registration and login using email/password with role-based access for users, mechanics, and admins.
2. **Booking Creation**: Admins can create service bookings with car details, customer details, and assign mechanics. Bookings are saved in a database.
3. **Calendar View of Bookings**: Integrates a calendar UI component to display bookings, allowing mechanics to view their assigned jobs.
4. **Service Management**: Admins can create, update, delete, and view services offered by the workshop.

## Technologies Used

- **Flutter**: 3.24.1 (Stable Channel)
- **Dart**: 3.5.1
- **Firebase**: Used for backend services, including authentication and data storage.
- **GetX**: For state management and route management.

## Installation

To run this app on your local machine, follow these steps:

1. Clone the repository:
```bash
  git clone https://github.com/muradhossin/car_workshop_app.git
```
2. Navigate to the project directory:
```bash
  cd car_workshop_app
```
3. Clean and get dependencies:
```bash
  flutter clean
```
```bash
  flutter pub get
```
4. Run the app:
```bash
  flutter run
```

## App Access

- **User**: Register and login as a user to book car servicing.
- **Mechanic**: Register and login as a mechanic to view assigned jobs. Login can be done if admin approves the mechanics registration.
- **Admin**: Use the following credentials to login as an admin:
  - Email: admin@admin.com
  - Password: 12345678



## Contributing
Contributions are welcome! If you have suggestions or improvements, please create a pull request or open an issue.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
