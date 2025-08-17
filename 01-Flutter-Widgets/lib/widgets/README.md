# Flutter Widgets Demo - File Structure

This directory contains the refactored Flutter widgets demo, organized by concept for educational purposes.

## File Structure

### `main.dart`
- **Location**: `lib/main.dart`
- **Purpose**: Main app entry point
- **Concepts**: MaterialApp, basic app structure
- **Size**: ~30 lines

### `home_page.dart`
- **Location**: `lib/widgets/home_page.dart`
- **Purpose**: Main navigation and layout structure
- **Concepts**: 
  - Scaffold
  - AppBar
  - Drawer
  - BottomNavigationBar
  - FloatingActionButton
- **Size**: ~150 lines

### `basic_widgets_page.dart`
- **Location**: `lib/widgets/basic_widgets_page.dart`
- **Purpose**: Demonstrates fundamental Flutter widgets
- **Concepts**:
  - Container (with decoration, borders, shadows)
  - SizedBox (for spacing and sizing)
  - ClipRRect (for rounded corners)
  - RichText (for styled text)
- **Size**: ~150 lines

### `layout_widgets_page.dart`
- **Location**: `lib/widgets/layout_widgets_page.dart`
- **Purpose**: Demonstrates layout and positioning widgets
- **Concepts**:
  - Row and Column (for linear layouts)
  - Stack (for overlapping elements)
  - Wrap (for flexible wrapping)
  - Positioned (within Stack)
- **Size**: ~120 lines

### `input_widgets_page.dart`
- **Location**: `lib/widgets/input_widgets_page.dart`
- **Purpose**: Demonstrates user input widgets
- **Concepts**:
  - TextField (with various configurations)
  - Switch
  - Checkbox
  - Radio buttons
  - TextEditingController
- **Size**: ~180 lines

### `list_widgets_page.dart`
- **Location**: `lib/widgets/list_widgets_page.dart`
- **Purpose**: Demonstrates list and grid widgets
- **Concepts**:
  - ListView.builder (for efficient lists)
  - GridView.builder (for grid layouts)
  - TabBar and TabBarView
  - Card and ListTile
- **Size**: ~140 lines

## Benefits of This Structure

1. **Modularity**: Each file focuses on a specific concept
2. **Maintainability**: Easier to find and modify specific functionality
3. **Educational**: Clear separation of concepts for learning
4. **Reusability**: Individual widgets can be easily reused
5. **Readability**: Smaller files are easier to understand

## Learning Path

For educational purposes, students can study these files in order:

1. Start with `main.dart` to understand app structure
2. Study `home_page.dart` for navigation concepts
3. Learn basic widgets in `basic_widgets_page.dart`
4. Understand layouts in `layout_widgets_page.dart`
5. Explore input handling in `input_widgets_page.dart`
6. Master lists and grids in `list_widgets_page.dart`

Each file is self-contained and demonstrates real-world usage of Flutter widgets with Sydney-themed content.
