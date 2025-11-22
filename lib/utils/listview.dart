// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PenyakitListPage extends StatelessWidget {
//   const PenyakitListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> penyakitStream =
//         FirebaseFirestore.instance.collection('penyakit').snapshots();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Penyakit Padi'),
//         backgroundColor: Colors.green,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: penyakitStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text('Terjadi kesalahan'));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final data = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               var item = data[index];
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(item['nama_penyakit']),
//                   subtitle: Text(item['rincian']),
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (_) => AlertDialog(
//                         title: Text(item['nama_penyakit']),
//                         content: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("🧾 Ringkasan:\n${item['rincian']}\n"),
//                               Text("🛡 Pencegahan:\n${item['pencegahan']}\n"),
//                               Text("💊 Pengobatan:\n${item['pengobatan']}"),
//                             ],
//                           ),
//                         ),
//                         actions: [
//                           TextButton(
//                             child: const Text('Tutup'),
//                             onPressed: () => Navigator.pop(context),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
