# Charts in Flutter

## Overview

The `fl_chart` package provides a comprehensive charting library for Flutter applications. It supports various chart types including line charts, bar charts, pie charts, and more, making it perfect for data visualization and analytics.

## Key Features

- **Multiple Chart Types**: Line, bar, pie, scatter, radar, and area charts
- **Interactive**: Touch interactions and animations
- **Customizable**: Highly customizable appearance and behavior
- **Responsive**: Adapts to different screen sizes
- **Performance**: Efficient rendering for large datasets

## Installation

Add to `pubspec.yaml`:
```yaml
dependencies:
  fl_chart: ^0.66.2
```

## Basic Usage

```dart
LineChart(
  LineChartData(
    gridData: FlGridData(show: true),
    titlesData: FlTitlesData(show: false),
    borderData: FlBorderData(show: true),
    lineBarsData: [
      LineChartBarData(
        spots: [
          const FlSpot(0, 3),
          const FlSpot(2.6, 2),
          const FlSpot(4.9, 5),
          const FlSpot(6.8, 3.1),
          const FlSpot(8, 4),
          const FlSpot(9.5, 3),
          const FlSpot(11, 4),
        ],
        isCurved: true,
        color: Colors.blue,
        barWidth: 3,
        dotData: FlDotData(show: false),
      ),
    ],
  ),
)
```

## Chart Types

### 1. LineChart
Displays data points connected by lines, perfect for showing trends over time.

### 2. BarChart
Shows data as rectangular bars, ideal for comparing quantities.

### 3. PieChart
Displays data as slices of a pie, great for showing proportions.

### 4. ScatterChart
Shows individual data points without connecting lines.

### 5. RadarChart
Displays data in a circular format with multiple axes.

## Examples

### Basic Line Chart
```dart
LineChart(
  LineChartData(
    gridData: FlGridData(show: true),
    titlesData: FlTitlesData(show: false),
    borderData: FlBorderData(show: true),
    lineBarsData: [
      LineChartBarData(
        spots: [
          const FlSpot(0, 3),
          const FlSpot(2.6, 2),
          const FlSpot(4.9, 5),
          const FlSpot(6.8, 3.1),
          const FlSpot(8, 4),
          const FlSpot(9.5, 3),
          const FlSpot(11, 4),
        ],
        isCurved: true,
        color: Colors.blue,
        barWidth: 3,
        dotData: FlDotData(show: false),
      ),
    ],
  ),
)
```

### Bar Chart
```dart
BarChart(
  BarChartData(
    alignment: BarChartAlignment.spaceAround,
    maxY: 20,
    barTouchData: BarTouchData(enabled: false),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Text('${value.toInt()}');
          },
        ),
      ),
    ),
    borderData: FlBorderData(show: false),
    barGroups: [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.blue)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: Colors.red)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: Colors.green)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: Colors.yellow)]),
    ],
  ),
)
```

### Pie Chart
```dart
PieChart(
  PieChartData(
    sectionsSpace: 0,
    centerSpaceRadius: 40,
    sections: [
      PieChartSectionData(
        color: Colors.blue,
        value: 40,
        title: '40%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ],
  ),
)
```

## Common Use Cases

### 1. Analytics Dashboard
- Sales trends
- User activity metrics
- Performance indicators

### 2. Financial Applications
- Stock price charts
- Expense tracking
- Budget analysis

### 3. Health and Fitness
- Weight tracking
- Exercise progress
- Vital signs monitoring

### 4. Business Intelligence
- Revenue analysis
- Customer metrics
- Operational data

## Best Practices

1. **Choose Appropriate Chart Type**: Select the chart type that best represents your data
2. **Use Consistent Colors**: Maintain consistent color schemes across your app
3. **Provide Context**: Include titles, labels, and legends for clarity
4. **Optimize Performance**: Limit the number of data points for better performance
5. **Handle Empty Data**: Provide fallback UI when no data is available

## Implementation in Demo App

In our demo app, charts are used in:

- Dashboard tab for data visualization
- Interactive examples with sample data
- Line chart demonstration with curved lines

## Code Example from Demo

```dart
SizedBox(
  height: 200,
  child: LineChart(
    LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 3),
            const FlSpot(2.6, 2),
            const FlSpot(4.9, 5),
            const FlSpot(6.8, 3.1),
            const FlSpot(8, 4),
            const FlSpot(9.5, 3),
            const FlSpot(11, 4),
          ],
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
      ],
    ),
  ),
)
```

## Interactive Features

### Touch Interactions
```dart
LineChart(
  LineChartData(
    lineTouchData: LineTouchData(
      touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
        // Handle touch events
      },
    ),
    // ... other chart data
  ),
)
```

### Animations
```dart
LineChart(
  LineChartData(
    // ... chart data
  ),
  swapAnimationDuration: const Duration(milliseconds: 150),
  swapAnimationCurve: Curves.linear,
)
```

## Data Formatting

### Custom Axis Labels
```dart
titlesData: FlTitlesData(
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        return Text('${value.toInt()}');
      },
    ),
  ),
)
```

### Custom Tooltips
```dart
lineTouchData: LineTouchData(
  touchTooltipData: LineTouchTooltipData(
    tooltipBgColor: Colors.blue,
    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
      return touchedBarSpots.map((barSpot) {
        return LineTooltipItem(
          '${barSpot.y}',
          const TextStyle(color: Colors.white),
        );
      }).toList();
    },
  ),
)
```

## Related Widgets

- `CustomPaint`: For custom chart implementations
- `AnimatedBuilder`: For custom chart animations
- `SizedBox`: For controlling chart dimensions
- `Container`: For chart styling and decoration
