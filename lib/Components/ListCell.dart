import 'package:flutter/material.dart';

class ListCell extends StatelessWidget {
  String title;
  String subtitle;
  String imageURL;

  ListCell(
    {
      @required this.title,
      @required this.subtitle,
      this.imageURL
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        color: Colors.white,
        child: _buildCellRow(),
      ),
    );
  }

  //MARK: Widgets
  Widget _buildCellRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildImageWidgetIfNeeded()
        ),

        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildTitleWidget(),
              _buildSubtitleWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      this.title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitleWidget() {
    return Text(
      this.subtitle,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    );
  }

  Widget _buildImageWidgetIfNeeded() {
    if(this.imageURL == null) {
      return SizedBox.shrink();
    }

    return CircleAvatar(
      child: Image.network(this.imageURL),
    );
  }
}