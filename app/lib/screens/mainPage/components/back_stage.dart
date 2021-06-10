import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md_messenger/screens/startChannel.dart';

class MenuOptionDescription {
  final String title;
  final Function onTap;
  MenuOptionDescription({
    Key key,
    @required this.title,
    this.onTap,
  });
}

class BackGroundMenu extends StatelessWidget {
  BackGroundMenu({Key key, @required this.options}) : super(key: key);

  final List<MenuOptionDescription> options;

  @override
  Widget build(BuildContext context) {
    List<Widget> menuOptions = this
        .options
        .map((option) => MenuOption(
              title: option.title,
              onPress: option.onTap,
            ))
        .toList();
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // Padding from top
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "bratwava".toUpperCase(),
                  style: GoogleFonts.rubik(
                    fontSize: 36,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Color(0xff004A7C).withOpacity(0.24),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return CreateChannel();
                      }),
                    );
                  },
                  icon: Icon(
                    Icons.person_add,
                    color: Color(0xff005691),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: menuOptions,
          ),
        ],
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  final String title;
  final Function onPress;
  const MenuOption({Key key, @required this.title, this.onPress})
      : super(key: key);

  void onPressDefault() {
    print("<HomePage>: the menu item named: <$title> was pressed");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ?? onPressDefault,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 5,
          ),
          child: Text(
            this.title,
            style: GoogleFonts.rubik(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
