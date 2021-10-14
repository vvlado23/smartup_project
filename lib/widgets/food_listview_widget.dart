import 'package:flutter/material.dart';

import '../providers/item.dart';

class FoodListViewWidget extends StatefulWidget {
  Item item;

  FoodListViewWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<FoodListViewWidget> createState() => _FoodListViewWidgetState();
}

class _FoodListViewWidgetState extends State<FoodListViewWidget> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    double _height = _isVisible ? 20 : 0;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 0.8,
          ),
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-2, 2),
            blurRadius: 0.8,
          ),
        ],
      ),
      child: Column(
        children: [
          Material(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(10)),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.item.title),
                    Icon(
                      _isVisible
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _height,
            width: double.infinity,
            child: Text(
              widget.item.description ?? " ",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
