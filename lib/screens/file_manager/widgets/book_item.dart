import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:upload_file/bloc/file_manager_bloc.dart';
import 'package:upload_file/data/models/file_data_model.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.fileDataModel});

  final FileDataModel fileDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileManagerBloc, FileManagerState>(
      builder: (context, state) {
        FileManagerBloc fileManagerBloc = FileManagerBloc();
        debugPrint("qayta zildi");
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Image.asset(
                  fileDataModel.iconPath,
                  height: 100,
                  width: 50,
                  fit: BoxFit.fill,
                ),
                title: Text(fileDataModel.fileName),
                trailing: state.newFileLocation.isNotEmpty
                    ? IconButton(
                        onPressed: () async {
                          await OpenFilex.open(state.newFileLocation);
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ))
                    : state.progress != 0
                        ? CircularProgressIndicator(
                            value: state.progress,
                            backgroundColor: Colors.blue,
                          )
                        : IconButton(
                            onPressed: () async {
                              if (state.newFileLocation.isEmpty) {
                                fileManagerBloc.add(
                                  DownloadFileEvent(
                                    fileDataModel: fileDataModel,
                                  ),
                                );
                              } else {
                                await OpenFilex.open(state.newFileLocation);
                              }
                            },
                            icon: const Icon(
                              Icons.download,
                              color: Colors.blue,
                            ),
                          ),
              ),
            ),
          ],
        );
      },
    );
  }
}
