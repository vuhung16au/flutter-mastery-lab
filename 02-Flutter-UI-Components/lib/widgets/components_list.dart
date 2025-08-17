import 'package:flutter/material.dart';
import '../components/icon_widget_demo.dart';
import '../components/expanded_widget_demo.dart';
import '../components/checkbox_widget_demo.dart';
import '../components/carousel_slider_demo.dart';
import '../components/staggered_grid_view_demo.dart';
import '../components/progress_indicators_demo.dart';
import '../components/alert_dialog_demo.dart';
import '../components/dialogs_demo.dart';
import '../components/expansion_tile_demo.dart';
import '../components/tabs_demo.dart';
import '../components/horizontal_list_demo.dart';
import '../components/charts_demo.dart';
import '../components/convex_bottom_bar_demo.dart';
import '../components/slidable_demo.dart';
import '../components/snackbar_demo.dart';

class ComponentsList extends StatelessWidget {
  const ComponentsList({super.key});

  final List<String> components = const [
    'Icon Widget',
    'Expanded Widget',
    'Checkbox Widget',
    'Carousel Slider',
    'Staggered Grid View',
    'Progress Indicators',
    'Alert Dialog',
    'Dialogs',
    'Expansion Tile',
    'Tabs',
    'Horizontal List',
    'Charts',
    'Convex Bottom Bar',
    'Slidable',
    'Snackbar',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: components.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(_getIconForComponent(index)),
            title: Text(components[index]),
            subtitle: Text('Tap to see ${components[index]} demo'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _navigateToComponent(context, index),
          ),
        );
      },
    );
  }

  IconData _getIconForComponent(int index) {
    switch (index) {
      case 0:
        return Icons.star;
      case 1:
        return Icons.expand;
      case 2:
        return Icons.check_box;
      case 3:
        return Icons.view_carousel;
      case 4:
        return Icons.grid_view;
      case 5:
        return Icons.trending_up;
      case 6:
        return Icons.warning;
      case 7:
        return Icons.chat_bubble;
      case 8:
        return Icons.expand_more;
      case 9:
        return Icons.tab;
      case 10:
        return Icons.view_list;
      case 11:
        return Icons.bar_chart;
      case 12:
        return Icons.navigation;
      case 13:
        return Icons.swipe;
      case 14:
        return Icons.message;
      default:
        return Icons.widgets;
    }
  }

  void _navigateToComponent(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const IconWidgetDemo();
        break;
      case 1:
        page = const ExpandedWidgetDemo();
        break;
      case 2:
        page = const CheckboxWidgetDemo();
        break;
      case 3:
        page = const CarouselSliderDemo();
        break;
      case 4:
        page = const StaggeredGridViewDemo();
        break;
      case 5:
        page = const ProgressIndicatorsDemo();
        break;
      case 6:
        page = const AlertDialogDemo();
        break;
      case 7:
        page = const DialogsDemo();
        break;
      case 8:
        page = const ExpansionTileDemo();
        break;
      case 9:
        page = const TabsDemo();
        break;
      case 10:
        page = const HorizontalListDemo();
        break;
      case 11:
        page = const ChartsDemo();
        break;
      case 12:
        page = const ConvexBottomBarDemo();
        break;
      case 13:
        page = const SlidableDemo();
        break;
      case 14:
        page = const SnackbarDemo();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
