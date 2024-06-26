import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upload_file/data/models/file_data_model.dart';
import 'package:upload_file/data/models/file_status_model.dart';
import 'package:upload_file/services/file_manager_sevice.dart';

part 'file_manager_event.dart';

part 'file_manager_state.dart';

class FileManagerBloc extends Bloc<FileManagerEvent, FileManagerState> {
  FileManagerBloc()
      : super(
          const FileManagerState(
            progress: 0.0,
            newFileLocation: "",
          ),
        ) {
    on<DownloadFileEvent>(_downloadFile);
  }

  Future<void> _downloadFile(DownloadFileEvent event, emit) async {
    Dio dio = Dio();
    FileStatusModel fileStatusModel =
        await FileManagerService.checkFile(event.fileDataModel);
    if (fileStatusModel.isExist) {
      OpenFilex.open(fileStatusModel.newFileLocation);
    } else {
      await dio.download(
        event.fileDataModel.fileUrl,
        fileStatusModel.newFileLocation,
        onReceiveProgress: (count, total) async {
          emit(state.copyWith(progress: count / total));
        },
      );
      emit(
        state.copyWith(
          progress: 1,
          newFileLocation: fileStatusModel.newFileLocation,
        ),
      );
      OpenFilex.open(fileStatusModel.newFileLocation);
    }
  }


  Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      print("zaybalga kirvot");

      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          print("zaybalga kirvot");
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory;
  }
}
