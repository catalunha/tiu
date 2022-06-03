import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';

class FileDataButton extends StatefulWidget {
  final MilestoneController _milestoneController = Get.find();

  FileDataButton({Key? key}) : super(key: key);

  @override
  State<FileDataButton> createState() => _FileDataButtonState();
}

class _FileDataButtonState extends State<FileDataButton> {
  String? path;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            widget._milestoneController.loading = true;

            if (result != null) {
              File file = File(result.files.single.path!);
              widget._milestoneController.file = file;
              setState(() {});
            } else {
              // User canceled the picker
            }
            widget._milestoneController.loading = false;
          },
          child: const Text('Selecione o arquivo'),
        ),
        widget._milestoneController.file == null
            ? const Text('Sem arquivo.')
            : Text(
                'Arquivo lido com sucesso: ${widget._milestoneController.file!.path}')
      ],
    );

    // return GestureDetector(
    //   child: _xfile != null
    //       ? Container(
    //           width: 100,
    //           height: 100,
    //           decoration: BoxDecoration(
    //             border: Border.all(color: Colors.blue),
    //             borderRadius: BorderRadius.circular(10.0),
    //           ),
    //           child: kIsWeb
    //               ? Image.network(
    //                   _xfile!.path,
    //                   errorBuilder: (BuildContext context, Object exception,
    //                       StackTrace? stackTrace) {
    //                     print('error 1');
    //                     return errorBuilderWidget();
    //                   },
    //                 )
    //               : Image.file(
    //                   File(_xfile!.path),
    //                   errorBuilder: (BuildContext context, Object exception,
    //                       StackTrace? stackTrace) {
    //                     print('error 2');
    //                     return errorBuilderWidget();
    //                   },
    //                 ),
    //         )
    //       : widget._milestoneController.milestone?.image == null
    //           ? Container(
    //               width: 100,
    //               height: 100,
    //               decoration: BoxDecoration(
    //                 border: Border.all(color: Colors.green),
    //                 borderRadius: BorderRadius.circular(10.0),
    //               ),
    //               child: const Center(
    //                 child: Text(
    //                   'Click aqui para buscar uma imagem',
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //             )
    //           : ClipRRect(
    //               borderRadius: BorderRadius.circular(10.0),
    //               child: Image.network(
    //                 widget._milestoneController.productList!.imageUrl,
    //                 // loadingBuilder: (_, __, ___) {
    //                 //   return const Center(
    //                 //       child: CircularProgressIndicator());
    //                 // },
    //                 height: 100,
    //                 width: 100,
    //                 errorBuilder: (BuildContext context, Object exception,
    //                     StackTrace? stackTrace) {
    //                   print('error 3');
    //                   return errorBuilderWidget();
    //                 },
    //               ),
    //             ),
    //   onTap: () async {
    //     print('aqui...');
    //     final XFile? pickedFile =
    //         await _picker.pickImage(source: ImageSource.gallery);

    //     if (pickedFile != null) {
    //       widget._milestoneController.xfile = pickedFile;
    //       setState(() {
    //         _xfile = pickedFile;
    //       });
    //     }
    //   },
    // );
  }

  // Container errorBuilderWidget() {
  //   return Container(
  //     width: 100,
  //     height: 100,
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.red),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: const Center(
  //       child: Text('Erro ao buscar esta imagem'),
  //     ),
  //   );
  // }
}
