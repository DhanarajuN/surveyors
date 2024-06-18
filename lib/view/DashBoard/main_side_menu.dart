import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  

  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final List<String> items=['1','2','3','4','5','6','7','8','9','10'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Set the number of items in each row
                crossAxisSpacing: 10, // Set the spacing between items horizontally
                mainAxisSpacing: 10, // Set the spacing between items vertically
              ),
              itemCount: items.length, // Set the number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                // Build the grid item based on the index
                return GridItemWidget(item: items[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final String item; // The item to display in the grid

  const GridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Example color for demonstration
      height: 100,
      width: 100,
      child: Center(
        child: Text(
          item,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
