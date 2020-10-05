import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadTaskListTile extends StatelessWidget {
  const UploadTaskListTile(
      {Key key, this.task, this.onDismissed, this.onDownload})
      : super(key: key);

  final StorageUploadTask task;
  final VoidCallback onDismissed;
  final VoidCallback onDownload;

  String get status {
    String result;
    if (task.isComplete) {
      if (task.isSuccessful) {
        result = 'Complete';
      } else if (task.isCanceled) {
        result = 'Canceled';
      } else {
        result = 'Failed ERROR: ${task.lastSnapshot.error}';
      }
    } else if (task.isInProgress) {
      result = 'Uploading';
    } else if (task.isPaused) {
      result = 'Paused';
    }
    return result;
  }

  String _bytesTransferred(StorageTaskSnapshot snapshot) {
    return '${(snapshot.bytesTransferred / 1024).toStringAsFixed(2)} / ${(snapshot.totalByteCount / 1024).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StorageTaskEvent>(
      stream: task.events,
      builder: (BuildContext context,
          AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final StorageTaskEvent event = asyncSnapshot.data;
          final StorageTaskSnapshot snapshot = event.snapshot;
          subtitle = Text('$status: ${_bytesTransferred(snapshot)} KB sent');
        } else {
          subtitle = const Text('Starting...');
        }
        var event = asyncSnapshot?.data?.snapshot;
        double progressPercent =
        event != null ? event.bytesTransferred / event.totalByteCount : 0;
        return task.isComplete
            ? Container()
            : Column(
          children: <Widget>[
            Dismissible(
              key: Key(task.hashCode.toString()),
              onDismissed: (_) => onDismissed(),
              child: ListTile(
                title: Text('Upload Task #${task.hashCode}'),
                subtitle: subtitle,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Offstage(
                      offstage: !task.isInProgress,
                      child: IconButton(
                        icon: const Icon(Icons.pause),
                        onPressed: () => task.pause(),
                      ),
                    ),
                    Offstage(
                      offstage: !task.isPaused,
                      child: IconButton(
                        icon: const Icon(Icons.file_upload),
                        onPressed: () => task.resume(),
                      ),
                    ),
                    Offstage(
                      offstage: task.isComplete,
                      child: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => task.cancel(),
                      ),
                    ),
                    Offstage(
                      offstage: !(task.isComplete && task.isSuccessful),
                      child: IconButton(
                        icon: const Icon(Icons.file_download),
                        onPressed: onDownload,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LinearProgressIndicator(
              value: progressPercent,
              backgroundColor: Colors.blue[100],
            ),
            //Text("${(progressPercent * 100).toStringAsFixed(2)} % "),
          ],
        );
      },
    );
  }
}