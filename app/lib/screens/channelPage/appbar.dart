import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String channelTitle;
  final String userId;
  const CustomAppBar(
      {Key key, @required this.channelTitle, this.userId = "testUser"})
      : super(key: key);

  Widget _backButton(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: theme.accentColor,
      ),
      onPressed: () {
        print("<CustomAppBar>: back button was pressed");
        Navigator.of(context).pop();
      },
    );
  }

  Widget _titleOfChannel(BuildContext context) {
    return Text(
      this.channelTitle,
      style: GoogleFonts.rubik(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _channelInfo(BuildContext context) {
    final theme = Theme.of(context);
    return ClipOval(
      child: Container(
        color: theme.accentColor,
        height: 45,
        width: 45,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4.0,
          ),
        ],
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _backButton(context),
          _titleOfChannel(context),
          _channelInfo(context),
        ],
      ),
    );
  }
}
