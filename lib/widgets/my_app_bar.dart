import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Function searchCallbackHandler;

  MyAppBar(this.searchCallbackHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      width: double.infinity,
      child: Card(
        child: ListTile(
          onTap: (){},
            leading: Icon(Icons.menu),
            title: TextField(
              onSubmitted: searchCallbackHandler,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by location',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(74);
}
