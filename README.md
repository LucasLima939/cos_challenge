# cos_challenge

This project is a CarOnSale challenge and these are our main goal:
- Step 1: The app must provide an user identification.
    - Bonus: Save the data locally so the step can be skipped.
- Step 2: The user should be able to enter the VIN for search a vehicle, this process should have a good error handling structure.
    - Bonus: Show the user the specific error and how to resolve it.
- Step 3: If the user receives a status code 300 show the user the options for selecting the correct vehicle.
    - Bonus: Consider the "similarity" parameter (ranging from 0 to 99) you received. The higher the value, the better the match.
- Step 4: If you receive a success status code in the second step, save the data persistently and locally, then navigate to the next screen.
    - Bonus: If an error occurs during an additional request, allow the user to see the previously fetched data (if any) from the local cache.
- Step 5: Display the auction data: price, model, and UUID.
    - Bonus: Consider the feedback received and whether it was positive or negative, and display this to the user as well.

## Getting Started

### How to configure
- Flutter SDK Version: 3.32.2
- Dart SDK Version: 3.8.1

### Project Structure

This project follows the best practices for Flutter, we are using:
- Architecture: Clean Arch.
- State Management: Cubit.
- Design Patterns: Adapter.
- Dependency Injector: GetIt + BlocProvider.
- Follows the SOLID principles.

### About the Clean Architecture

![Clean Architecture Diagram](https://www.dbestech.com/uploads/20231219/429302f2ab88bfae0e98b8e692dcf12e.jpg)

