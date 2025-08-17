# Flutter - Themes

## Overview
This component demonstrates how to implement consistent theming across your Flutter application using ThemeData and MaterialApp theme configuration. The project now includes a comprehensive animation gallery that fully utilizes the theming system for consistent visual design.

## Key Components Used

### 1. ThemeData
- **Purpose**: Defines the visual theme for the entire app
- **Usage**: Configured in MaterialApp to provide consistent styling
- **Animation Gallery Integration**: All animation demos use theme-aware colors and styling

### 2. MaterialApp
- **Purpose**: The root widget that provides theme configuration
- **Usage**: Wraps the app and applies theme settings
- **Animation Gallery**: The gallery screen inherits theme settings for consistent appearance

### 3. ColorScheme
- **Purpose**: Defines the color palette for the app
- **Usage**: Provides primary, secondary, and surface colors
- **Animation Gallery**: Uses dynamic colors for cards, backgrounds, and interactive elements

### 4. TextTheme
- **Purpose**: Defines text styles for different text types
- **Usage**: Provides consistent typography across the app
- **Animation Gallery**: Consistent typography in gallery cards and animation descriptions

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

## 🎨 Animation Gallery Theming

### Theme-Aware Design
The animation gallery fully utilizes the theming system:

```dart
// Theme-aware colors in animation cards
Container(
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    border: Border.all(
      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
    ),
  ),
  child: Icon(
    demo.icon,
    color: Theme.of(context).colorScheme.primary,
  ),
)
```

### Dynamic Color Usage
- **Primary Colors**: Used for interactive elements and highlights
- **Surface Colors**: Used for card backgrounds and containers
- **Outline Colors**: Used for borders and dividers
- **OnSurface Colors**: Used for text and icons on surface backgrounds

### Responsive Theming
- **Light Theme**: Bright, clean appearance with subtle shadows
- **Dark Theme**: Dark backgrounds with appropriate contrast
- **Dynamic Colors**: Adapts to system color preferences (Material 3)

## Best Practices
- Use consistent color schemes across all components
- Consider dark mode support for better accessibility
- Test themes on different devices and screen sizes
- Use semantic color names for better maintainability
- Maintain accessibility standards with proper contrast ratios
- Apply themes consistently across animation gallery components
- Use theme-aware colors for all interactive elements

## 🚀 Integration with Animation Gallery

### Theme Consistency
All animation demos follow the same theming principles:
- Consistent color usage across all animation screens
- Theme-aware text styling and typography
- Unified visual design language
- Responsive design that adapts to theme changes

### Customization
Themes can be easily customized to match your brand:
- Modify color schemes for brand colors
- Adjust typography for brand fonts
- Customize animation timing and curves
- Maintain consistency across all animation components
