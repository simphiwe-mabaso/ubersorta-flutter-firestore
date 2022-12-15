import 'package:flutter/material.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
    this.enableFreeSwag = false,
  });

  final bool loggedIn;
  final void Function() signOut;
  final bool enableFreeSwag;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 50, //height of button
            width: 300, //width of button
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, //background color of button
                    side: const BorderSide(width: 1, color: Colors.purple), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: const EdgeInsets.all(20) //content padding inside button
                ),
                onPressed: (){
                  !loggedIn
                      ? Navigator.of(context).pushNamed('/sign-in')
                      : signOut();
                },
                child: !loggedIn
                    ? const Text('LOGIN', style: TextStyle(color: Colors.black))
                    : const Text('LOGOUT', style: TextStyle(color: Colors.black))
            )
        ),
        Visibility(
            visible: enableFreeSwag,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                  onPressed: () {
                    throw Exception('free swag unimplemented');
                  },
                  child: const Text('Free swag!')),
            )),
      ],
    );
  }
}
