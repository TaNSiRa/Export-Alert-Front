// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'P03SUMMARYMAIL/P03SUMMARYMAILMAIN.dart';

//---------------------------------------------------------

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return P03SUMMARYMAILMAIN();
  }
}

// class Page3blockget extends StatelessWidget {
//   const Page3blockget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => P03SUMMARYMAILGETDATA_Bloc(),
//         child: BlocBuilder<P03SUMMARYMAILGETDATA_Bloc, List<P03SUMMARYMAILGETDATAclass>>(
//           builder: (context, data) {
//             return Page3Body(
//               data: data,
//             );
//           },
//         ));
//   }
// }

// class Page3Body extends StatelessWidget {
//   Page3Body({
//     super.key,
//     this.data,
//   });
//   List<P03SUMMARYMAILGETDATAclass>? data;
//   @override
//   Widget build(BuildContext context) {
//     return P03SUMMARYMAILMAIN(
//       data: data,
//     );
//   }
// }
