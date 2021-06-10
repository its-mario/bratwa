import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md_messenger/screens/channelPage/channelPage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// ignore: must_be_immutable
class ChannelButton extends StatelessWidget {
  final String title;
  final String lastMessage;
  final String lastDate;
  final String urlAvatarImage;
  final Channel channel;
  Image image;
  ChannelButton({
    Key key,
    @required this.title,
    this.lastMessage = "nothing yet",
    this.lastDate = "25:00",
    this.urlAvatarImage,
    @required this.channel,
  }) : super(key: key);

  void onTap(BuildContext context) {
    print("<Channel Button>: Open Channel Page");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChannelPage(channel: this.channel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15,
        ),
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 12,
          right: 12,
        ),
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 3,
                color: Colors.black.withOpacity(0.25),
              )
            ]),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                height: 66,
                width: 66,
                child: Image(
                  image: this.urlAvatarImage == null
                      ? AssetImage("assets/images/defaultAvatar.png")
                      : NetworkImage(urlAvatarImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 21,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    this.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    this.lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w200,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: Colors.black.withAlpha(150)),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              this.lastDate,
              style: GoogleFonts.rubik(
                fontSize: 14,
                color: Colors.black.withAlpha(150),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
