# Flutter - Themes

## Overview
This component demonstrates how to implement consistent theming across your Flutter application using ThemeData and MaterialApp theme configuration.

## Key Components Used

### 1. ThemeData
- **Purpose**: Defines the visual theme for the entire app
- **Usage**: Configured in MaterialApp to provide consistent styling

### 2. MaterialApp
- **Purpose**: The root widget that provides theme configuration
- **Usage**: Wraps the app and applies theme settings

### 3. ColorScheme
- **Purpose**: Defines the color palette for the app
- **Usage**: Provides primary, secondary, and surface colors

### 4. TextTheme
- **Purpose**: Defines text styles for different text types
- **Usage**: Provides consistent typography across the app

## Implementation Steps

1. **Define ThemeData**:
   ```dart
   ThemeData(
     primarySwatch: Colors.blue,
     brightness: Brightness.light,
     colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
     textTheme: TextTheme(
       headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
       bodyLarge: TextStyle(fontSize: 16),
     ),
   )
   ```

2. **Apply Theme to MaterialApp**:
   ```dart
   MaterialApp(
     title: 'Flutter App',
     theme: ThemeData(...),
     home: MyHomePage(),
   )
   ```

3. **Access Theme in Widgets**:
   ```dart
   Theme.of(context).textTheme.headlineLarge
   Theme.of(context).colorScheme.primary
   ```

## Theme Properties
- **primarySwatch**: Primary color for the app
- **brightness**: Light or dark theme
- **colorScheme**: Complete color palette
- **textTheme**: Typography styles
- **appBarTheme**: AppBar styling
- **buttonTheme**: Button styling
- **inputDecorationTheme**: Input field styling

## Best Practices
- Use consistent color schemes
- Consider dark mode support
- Test themes on different devices
- Use semantic color names
- Maintain accessibility standards
