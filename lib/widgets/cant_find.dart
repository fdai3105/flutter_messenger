part of 'widgets.dart';

class CantFind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
            "assets/images/illustrations/not_found.png"),
        Text(
          "Oops!",
          style: UI.textStyle.copyWith(
              fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text("We can't find contact", style: UI.textStyle),
        Text("you looking for.", style: UI.textStyle),
      ],
    );
  }
}
