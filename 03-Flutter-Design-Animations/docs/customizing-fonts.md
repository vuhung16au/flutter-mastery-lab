# Customizing Fonts in Flutter

This guide covers various techniques for customizing fonts in Flutter applications, including Google Fonts integration, custom font families, and responsive typography.

## Google Fonts Integration

### Setup
1. Add the `google_fonts` package to your `pubspec.yaml`:
```yaml
dependencies:
  google_fonts: ^6.1.0
```

2. Import the package in your Dart file:
```dart
import 'package:google_fonts/google_fonts.dart';
```

### Usage Examples

#### Basic Google Fonts Usage
```dart
Text(
  'Hello World',
  style: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

#### Multiple Font Families
```dart
// Poppins font
Text(
  'Poppins Font',
  style: GoogleFonts.poppins(fontSize: 16),
)

// Roboto font
Text(
  'Roboto Font',
  style: GoogleFonts.roboto(fontSize: 16),
)

// Open Sans font
Text(
  'Open Sans Font',
  style: GoogleFonts.openSans(fontSize: 16),
)

// Lato font
Text(
  'Lato Font',
  style: GoogleFonts.lato(fontSize: 16),
)
```

## Theme Integration

### Global Font Theme
Apply Google Fonts to your entire app theme:

```dart
MaterialApp(
  theme: ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true,
  ),
  home: MyHomePage(),
)
```

### Dark Theme Support
```dart
MaterialApp(
  theme: ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true,
  ),
  darkTheme: ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
  ),
  home: MyHomePage(),
)
```

## Custom Font Files

### Adding Custom Fonts
1. Create a `fonts` directory in your project
2. Add your font files (e.g., `.ttf`, `.otf`)
3. Update `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: CustomFont
      fonts:
        - asset: fonts/CustomFont-Regular.ttf
        - asset: fonts/CustomFont-Bold.ttf
          weight: 700
        - asset: fonts/CustomFont-Italic.ttf
          style: italic
```

### Using Custom Fonts
```dart
Text(
  'Custom Font Text',
  style: TextStyle(
    fontFamily: 'CustomFont',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
)
```

## Auto Size Text

### Setup
Add the `auto_size_text` package:
```yaml
dependencies:
  auto_size_text: ^3.0.0
```

### Basic Usage
```dart
AutoSizeText(
  'This text will automatically resize to fit the container',
  style: TextStyle(fontSize: 16),
  maxLines: 2,
  minFontSize: 8,
)
```

### Advanced Configuration
```dart
AutoSizeText(
  'Responsive text with custom settings',
  style: TextStyle(fontSize: 20),
  maxLines: 3,
  minFontSize: 10,
  maxFontSize: 20,
  stepGranularity: 1,
  overflow: TextOverflow.ellipsis,
)
```

## Font Styling Options

### Font Weight
```dart
Text(
  'Different font weights',
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.w100, // Thin
  ),
)

Text(
  'Bold text',
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold, // Bold
  ),
)
```

### Font Style
```dart
Text(
  'Italic text',
  style: GoogleFonts.poppins(
    fontStyle: FontStyle.italic,
  ),
)
```

### Letter Spacing
```dart
Text(
  'Text with letter spacing',
  style: GoogleFonts.poppins(
    letterSpacing: 2.0,
  ),
)
```

### Line Height
```dart
Text(
  'Text with custom line height',
  style: GoogleFonts.poppins(
    height: 1.5,
  ),
)
```

## Responsive Typography

### Screen Size Based Font Sizing
```dart
class ResponsiveText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    double fontSize;
    if (screenWidth < 600) {
      fontSize = 16; // Mobile
    } else if (screenWidth < 900) {
      fontSize = 18; // Tablet
    } else {
      fontSize = 20; // Desktop
    }
    
    return Text(
      'Responsive text',
      style: GoogleFonts.poppins(fontSize: fontSize),
    );
  }
}
```

### Theme-Based Font Sizing
```dart
Text(
  'Theme-based text',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontFamily: GoogleFonts.poppins().fontFamily,
  ),
)
```

## Font Performance

### Preloading Fonts
```dart
// Preload fonts for better performance
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Preload Google Fonts
  await GoogleFonts.pendingFonts([
    GoogleFonts.poppins(),
    GoogleFonts.roboto(),
  ]);
  
  runApp(MyApp());
}
```

### Font Caching
Google Fonts automatically caches fonts for better performance. You can also implement custom caching:

```dart
class FontCache {
  static final Map<String, TextStyle> _cache = {};
  
  static TextStyle getFont(String fontFamily, {
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    final key = '$fontFamily-$fontSize-$fontWeight';
    
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }
    
    final style = GoogleFonts.getFont(fontFamily).copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
    
    _cache[key] = style;
    return style;
  }
}
```

## Best Practices

1. **Choose appropriate fonts** for your app's purpose and target audience
2. **Limit font families** to 2-3 per app for consistency
3. **Use font weights** to create hierarchy
4. **Consider readability** on different screen sizes
5. **Test fonts** on various devices and screen densities
6. **Optimize for performance** by preloading essential fonts
7. **Provide fallbacks** for custom fonts

## Common Font Combinations

### Modern & Clean
```dart
// Headings
Text(
  'Heading',
  style: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)

// Body text
Text(
  'Body text',
  style: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
)
```

### Professional
```dart
// Headings
Text(
  'Professional Heading',
  style: GoogleFonts.openSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
)

// Body text
Text(
  'Professional body text',
  style: GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
)
```

This comprehensive font system provides flexibility and performance for creating beautiful typography in Flutter applications.
