# Nikkle

## Flutter App Assignment

### Overview

This project was developed as part of an assignment to demonstrate my Flutter knowledge and UI/UX implementation skills. Given a tight schedule, I focused on delivering core functionality across four screens, keeping as close to the provided UI as possible. This project helped reinforce existing Flutter concepts, and I am eager to expand my skills, particularly in animations and advanced app publishing techniques.

### Technologies and Packages Used

- Flutter: For UI design and app logic.
- Navigator: Used for simple routing between screens.
- Provider: Used for state management, especially in managing the cart items.
- Shared Preferences: To store cart data locally.
- ValueNotifier: For dynamically displaying cart badge counts.

### Features Implemented

1. Splash Screen
   Implemented the provided UI layout.
   Note: While I didn’t include animations due to time constraints, I plan to enhance my animation skills in Flutter to add interactive experiences in the future.
2. Login Screen
   Designed according to the provided UI.
   Although I am familiar with form validation and custom keyboard settings, this screen was set up solely to navigate to the dashboard without additional validations.
3. Main Screens (Home and Checkout Pages)
   Used a BottomNavigationBar setup with an index.dart file to manage the app bar and navigation across tabs.
   The BottomNavigationBar switches content based on the selected tab.
   Tabs include HomePage, CheckoutPage, and placeholder tabs with basic messages.
4. Home Page (Dashboard)
   Added a search TextField to filter products as the user types.
   Implemented ListView.builder to display a product list.
   Created a dialog box to add selected items to the cart.
   Designed a Cart Provider to manage cart items and used Shared Preferences to store cart data locally.
5. Cart Page
   Bottom navigation displays a badge showing the number of items in the cart using ValueNotifier.
   Retrieves cart items each time the tab is opened, utilizing Provider for efficient state management.
   Added functionality to remove, increment, and decrement items in the cart.
   Dialog for checkout displays the steps involved in the checkout procedure.

### Challenges and Future Improvements

Completing this project within a tight schedule reinforced my Flutter skills, especially in UI design, state management, and local data storage. I am eager to learn more about animations, signing release APKs, and other advanced Flutter concepts. I am confident I could refine and enhance this project if given the opportunity to join the team.
