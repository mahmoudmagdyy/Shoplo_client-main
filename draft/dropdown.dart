// DropdownButton<int>(
// hint: Text("Pick"),
// value: _number_tickets_total,
// items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((int value) {
// return new DropdownMenuItem<int>(
// value: value,
// child: new Text(value.toString()),
// );
// }).toList(),
// onChanged: (newVal) {
// setState(() {
// _number_tickets_total = newVal;
// });
// }),