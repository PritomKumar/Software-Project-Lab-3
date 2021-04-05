import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

/// Displays the current state of a single UploadTask.
class UploadTaskListTile extends StatelessWidget {
  // ignore: public_member_api_docs
  const UploadTaskListTile({
    Key key,
    this.task,
    this.onDismissed,
    this.onDownload,
    this.onDownloadLink,
    this.onSuccessful,
  }) : super(key: key);

  /// The [UploadTask].
  final firebase_storage.UploadTask /*!*/ task;

  /// Triggered when the user dismisses the task from the list.
  final VoidCallback /*!*/ onDismissed;

  /// Triggered when the user presses the download button on a completed upload task.
  final VoidCallback /*!*/ onDownload;

  /// Triggered when the user presses the "link" button on a completed upload task.
  final VoidCallback /*!*/ onDownloadLink;

  final VoidCallback onSuccessful;

  /// Displays the current transferred bytes of the task.
  String _bytesTransferred(firebase_storage.TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  double _bytesTransferredDouble(firebase_storage.TaskSnapshot snapshot) {
    return snapshot.bytesTransferred / snapshot.totalBytes;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_storage.TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (
        BuildContext context,
        AsyncSnapshot<firebase_storage.TaskSnapshot> asyncSnapshot,
      ) {
        Widget subtitle = const Text('---');
        double progressPercent;
        firebase_storage.TaskSnapshot snapshot = asyncSnapshot.data;
        firebase_storage.TaskState state = snapshot?.state;
        if (state == firebase_storage.TaskState.success) {}
        if (asyncSnapshot.hasError) {
          if (asyncSnapshot.error is firebase_core.FirebaseException &&
              (asyncSnapshot.error as firebase_core.FirebaseException).code ==
                  'canceled') {
            subtitle = const Text('Upload canceled.');
          } else {
            // ignore: avoid_print
            print(asyncSnapshot.error);
            subtitle = const Text('Something went wrong.');
          }
        } else if (snapshot != null) {
          progressPercent = _bytesTransferredDouble(snapshot);
          subtitle = Text('$state: ${_bytesTransferred(snapshot)} bytes sent');
        }

        return Dismissible(
          key: Key(task.hashCode.toString()),
          onDismissed: ($) => onDismissed(),
          child: ListTile(
            // title: Text('Upload Task #${task.hashCode}'),
            subtitle: subtitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state == firebase_storage.TaskState.running)
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: task.pause,
                  ),
                if (state == firebase_storage.TaskState.running)
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: task.cancel,
                  ),
                if (state == firebase_storage.TaskState.paused)
                  IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: task.resume,
                  ),
                if (state == firebase_storage.TaskState.success)
                  IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: onDownload,
                  ),
                if (state == firebase_storage.TaskState.success)
                  IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: onDownloadLink,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class UploadTaskListTile extends StatelessWidget {
//   const UploadTaskListTile(
//       {Key key, this.task, this.onDismissed, this.onDownload,this.onSuccessful})
//       : super(key: key);
//
//   final UploadTask task;
//   final VoidCallback onDismissed;
//   final VoidCallback onDownload;
//   final VoidCallback onSuccessful;
//
//   String get status {
//     String result;
//     if (task.isComplete) {
//       if (task.isSuccessful) {
//         result = 'Complete';
//       } else if (task.isCanceled) {
//         result = 'Canceled';
//       } else {
//         result = 'Failed ERROR: ${task.lastSnapshot.error}';
//       }
//     } else if (task.isInProgress) {
//       result = 'Uploading';
//     } else if (task.isPaused) {
//       result = 'Paused';
//     }
//     return result;
//   }
//
//   String _bytesTransferred(StorageTaskSnapshot snapshot) {
//     return '${(snapshot.bytesTransferred / 1024).toStringAsFixed(2)} / ${(snapshot.totalByteCount / 1024).toStringAsFixed(2)}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<StorageTaskEvent>(
//       stream: task.events,
//       builder: (BuildContext context,
//           AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
//         Widget subtitle;
//         if (asyncSnapshot.hasData) {
//           final StorageTaskEvent event = asyncSnapshot.data;
//           final StorageTaskSnapshot snapshot = event.snapshot;
//           subtitle = Text('$status: ${_bytesTransferred(snapshot)} KB sent');
//         } else {
//           subtitle = const Text('Starting...');
//         }
//         var event = asyncSnapshot?.data?.snapshot;
//         double progressPercent =
//         event != null ? event.bytesTransferred / event.totalByteCount : 0;
//         if(task.isSuccessful){
//           onSuccessful();
//         }
//         return task.isComplete
//             ? Container()
//             : Column(
//           children: <Widget>[
//             Dismissible(
//               key: Key(task.hashCode.toString()),
//               onDismissed: (_) => onDismissed(),
//               child: ListTile(
//                 title: Text('Upload Task #${task.hashCode}'),
//                 subtitle: subtitle,
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Offstage(
//                       offstage: !task.isInProgress,
//                       child: IconButton(
//                         icon: const Icon(Icons.pause),
//                         onPressed: () => task.pause(),
//                       ),
//                     ),
//                     Offstage(
//                       offstage: !task.isPaused,
//                       child: IconButton(
//                         icon: const Icon(Icons.file_upload),
//                         onPressed: () => task.resume(),
//                       ),
//                     ),
//                     Offstage(
//                       offstage: task.isComplete,
//                       child: IconButton(
//                         icon: const Icon(Icons.cancel),
//                         onPressed: () => task.cancel(),
//                       ),
//                     ),
//                     Offstage(
//                       offstage: !(task.isComplete && task.isSuccessful),
//                       child: IconButton(
//                         icon: const Icon(Icons.file_download),
//                         onPressed: onDownload,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             LinearProgressIndicator(
//               value: progressPercent,
//               backgroundColor: Colors.blue[100],
//             ),
//             //Text("${(progressPercent * 100).toStringAsFixed(2)} % "),
//           ],
//         );
//       },
//     );
//   }
// }
