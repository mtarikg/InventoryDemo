# Inventory Demo

Project overview with both visual and technical aspects: [Watch here](https://youtu.be/SXZay6Yhupc)


## 1. Definition
A mobile application for inventory management, developed using .NET, MSSQL and Flutter.

## 2. Stakeholders
The project supports two types of users, Admin and Personnel, whose capabilities are described below:

<img width="550" height="700" alt="Use Case Diagram" src="https://github.com/user-attachments/assets/78e28eb6-359e-46ff-8a5b-064aa0c3ebd5" />

## 3. System Behavior

The interactions between the system and its users, as well as how data across different components, are illustrated for each type of user below.

### 3.1 Admin
<img width="650" height="650" alt="Sequence Diagram (Admin)" src="https://github.com/user-attachments/assets/2a3e08a5-3f15-4f43-b222-291715990bbb" />

#### Key Points:
- Only an admin can assign a property to a personnel.

### 3.2 Personnel
<img width="650" height="650" alt="Sequence Diagram (Personnel)" src="https://github.com/user-attachments/assets/f53b1a6b-047f-4afc-8d10-cac01a7245a8" />

#### Key Points:
- A personnel has to confirm the assigned properties.

## 4. User Interface
Key screens from the Balsamiq designs are highlighted below.

For the full clickable versions, see [Admin prototype](User%20Interface/Admin%20Design.pdf) and [Personnel prototype](User%20Interface/Personnel%20Design.pdf).

### 4.1 Admin
<p float="left">
  <img width="300" height="700" alt="image" src="https://github.com/user-attachments/assets/e07b1df4-ed28-40f4-8159-00c173bdb086" />
  <img width="300" height="700" alt="image" src="https://github.com/user-attachments/assets/268c56ba-2af8-4fcf-b34f-0f180e19487f" />
  <img width="300" height="700" alt="image" src="https://github.com/user-attachments/assets/62265074-c601-4e2c-b63b-694d8960bb67" />
</p>

### 4.2 Personnel
<p float="left">
  <img width="300" height="700" alt="image" src="https://github.com/user-attachments/assets/40f07129-1590-45fd-8227-630a4bad1b11" />
  <img width="300" height="700" alt="image" src="https://github.com/user-attachments/assets/6d66555d-6435-4f1d-b67d-c445329dec36" />
</p>

## 5. System Architecture
The project follows a layered architecture, separating presentation, business logic and data access layers.

The repository pattern is implemented to manage the data access layer.

### 5.1 Tools
- Entity Framework Core (EF Core): ORM for database interaction.
- AutoMapper: Simplifies mapping between domain models and DTOs.
- JWT: Handles authentication and authorization.
- Secure Storage (Flutter): Stores JWT tokens securely.

### 5.2 Database Design
The following Entity-Relationship Diagram (ERD) illustrates the database structure:

<img width="500" height="500" alt="Entity-Relationship Diagram" src="https://github.com/user-attachments/assets/658e2028-1ae8-473d-b998-e0fd4f5967d0" />

## 6. Conclusion
This project, developed during my internship, demonstrates a complete inventory management system with role-based functionality for Admin and Personnel users.

It features secure authentication using JWT, client-side token protection with Flutter Secure Storage, and a maintainable layered architecture with repository patterns.

Built with .NET, MSSQL, and Flutter. For a full walkthrough, refer to the video overview and UI mock-ups.
