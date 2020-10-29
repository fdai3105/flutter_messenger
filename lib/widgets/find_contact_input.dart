part of 'widgets.dart';

class FindContactInput extends StatelessWidget {
  final ValueChanged valueChanged;

  const FindContactInput({Key key, this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: _size.width - 20,
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            decoration: UI.textDecoration.copyWith(
                prefixIcon: const Icon(
                  Icons.find_replace,
                ),
                hintText: "Search"),
            onChanged: valueChanged,
          ),
        ),
      ],
    );
  }
}
