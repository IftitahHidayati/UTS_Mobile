// ADD TASK ===========================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';
 
class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final TextEditingController _controller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Masukkan Task Baru",
                errorText: context.watch<Tasklist>().taskName.errorMessage,
              ),
              controller: _controller,
              onChanged: (value) {
                print("done");
                context.read<Tasklist>().whileTaskNameChange(value);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: context.watch<Tasklist>().isActive
                        ? () {
                            context
                                .read<Tasklist>()
                                .setTaskName(_controller.text);
                            if (context.read<Tasklist>().isValidated()) {
                              context.read<Tasklist>().addTask(
                                    _controller.text,
                                  );
                              Navigator.pop(context);
                            }
                          }
                        : null,
                    child: const Text("Tambah Task Baru"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:provider_listview/service/tasklist.dart';

// class AddTaskPage extends StatelessWidget {
//   const AddTaskPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Tambah Task Baru"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: const InputDecoration(
//                 hintText: "Masukkan Task Baru",
//               ),
//               onChanged: (value) {
//                 context.read<Tasklist>().changeTaskName(value);
//               },
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<Tasklist>().addTask();
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Tambah Task Baru"),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
