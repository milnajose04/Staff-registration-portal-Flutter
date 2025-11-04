import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileBox extends StatelessWidget {
  String mainText;
  String subText;
  // ignore: prefer_typing_uninitialized_variables
  final void Function()? onPressed;

  ProfileBox(
      {super.key,
      required this.mainText,
      required this.subText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      offset: const Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1),
                  BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        mainText,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 17),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: onPressed,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  child: Text(
                    subText,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
      ],
    );
  }
}
