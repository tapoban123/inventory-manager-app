import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final TextEditingController amountController;
  final VoidCallback removeItem;
  const ItemCard({
    super.key,
    required this.amountController,
    required this.title,
    required this.removeItem,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: IconButton(
          onPressed: widget.removeItem,
          icon: Icon(Icons.delete, color: Colors.red),
        ),
        title: Text(widget.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (int.parse(widget.amountController.text) > 0) {
                  widget.amountController.text =
                      (int.parse(widget.amountController.text) - 1).toString();
                  setState(() {});
                }
              },
              icon: Icon(CupertinoIcons.minus),
            ),
            SizedBox(
              width: 50,
              child: TextField(
                controller: widget.amountController,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              onPressed: () {
                widget.amountController.text =
                    (int.parse(widget.amountController.text) + 1).toString();
                setState(() {});
              },
              icon: Icon(CupertinoIcons.add),
            ),
          ],
        ),
      ),
    );
  }
}
