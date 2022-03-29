import 'package:flutter/material.dart';


import '../../../../../../../../util/app_shaerd_data.dart';

class SocialShareButtons extends StatelessWidget {
  const SocialShareButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // onClicked: () => share(SocialMedia.whatsapp);

              },
              child: const Image(
                  width: 34.45,
                  height: 34.45,
                  image: AssetImage('assets/png/whatsapp.png')),
            ),
            const SizedBox(width: 20.3),
            // Gesture detector for the whatsapp icon
            GestureDetector(
                onTap: () {
                  // onClicked: () => share(SocialMedia.instagram);
                  // Call the a method to sign in with whatsapp
                  // AuthService().signInWithWhatsapp();
                },
                child: const Image(
                    width: 31.45,
                    height: 31.45,
                    image: AssetImage('assets/png/instagram.png'))),
            const SizedBox(width: 20.3),
            // Gesture detector for the Google icon
            GestureDetector(
                onTap: () {
                  // onClicked: () => share(SocialMedia.youtube);

                  // Call the a method to sign in with Instagram
                  // AuthService().signInWithInstagram();
                },
                child: const Image(
                    width: 31.45,
                    height: 31.45,
                    image: AssetImage('assets/png/youtube.png'))),

            const SizedBox(width: 20.3),
            GestureDetector(
                onTap: () {
                  // onClicked: () => share(SocialMedia.twitter);

                  // Call the a method to sign in with Youtube
                  // AuthService().signInWithYoutube();
                },
                child: const Image(
                    width: 31.45,
                    height: 31.45,
                    image: AssetImage('assets/png/twitter.png'))),
            const SizedBox(width: 20.3),
            // Gesture detector for the Google icon
            GestureDetector(
                onTap: () {
                  // onClicked: () => share(SocialMedia.facebook);

                  // Call the a method to sign in with Twitter
                  // AuthService().signInWithTwitter();
                },
                child: const Image(
                    width: 31.45,
                    height: 31.45,
                    image: AssetImage('assets/png/facebook.png')
                )
            ),
            const SizedBox(width: 20.3),
          ],
        ),
      ],
    );
  }
}

// Future share(SocialMedia platform) async {
//
//   final urls = {
//     SocialMedia.whatsapp : ('whatsapp shareable link')
//     ,SocialMedia.instagram : ('instagram shareable link')
//     ,SocialMedia.youtube : ('youtube shareable link')
//     ,SocialMedia.twitter : ('twitter shareable link')
//     ,SocialMedia.facebook : ('face book shareable link')
//
//   };
//   final url = urls[platform]!;
//   await launch(url);
// }
//
//
// enum SocialMedia { whatsapp , instagram , youtube, twitter  ,facebook }
//
// Widget buildSocialButton({required IconData icon, Color? color, required Function() onClicked})
// => InkWell(
//   child: const SizedBox(
//     width : 60,
//     height : 60,
//   ),
//   onTap: onClicked,
// );