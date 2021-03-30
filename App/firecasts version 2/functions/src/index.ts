import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

// export const helloWorld = functions.https.onRequest((request, response) => {
//     functions.logger.info("Hello Demon lord!", { structuredData: true });
//     console.log("Console log hello");
//     response.send("Hello from Pain!");
// });

// export const getGigInfo = functions.https.onRequest(
//     async (request, response) => {
//         try {
//             const snapshotss = await admin
//                 .firestore()
//                 .doc("Gigs/UpTzbCY8JsWBuTHqWl8K/Tasks/FHia6YicE6m9RCag0wr6/")
//                 .get();
//             const data = snapshotss.data();
//             console.log("Data loading !!");
//             console.log(data);
//             response.send(data);
//         } catch (error) {
//             console.log("Error");
//             response.status(500).send(error);
//         }
//     }
// );

// distance = 500
// level = 200 (1-10) for inactivit level goes down
// rating = 100
// misconduct = 0 to negative
// marital status = 50
// employmentStatus = 50 ? push notification send
// household income = 50
// education = 50
// total = 1000

exports.onGigUpdatessssss = functions.firestore
    .document("Gigs/{gigId}")
    .onUpdate(async (change, context) => {
      // Get an object representing the current document
      try {
        const newValue = change.after.data();
        if (newValue) {
          console.log(newValue.description);
          // ...or the previous value before this update
          // const previousValue = change.before.data();

          // if (
          //     newValue.attemptedUsers.length ==
          //     previousValue.attemptedUsers.length
          // ) {
          //     console.log("Data is same");
          // }
          const updatedText = "The descption has changed!!!";

          if (newValue.description === updatedText) {
            console.log("Data is same!!");
            return null;
          } else {
            return change.after.ref.update({
              description: updatedText,
            });
            // return await admin
            //     .firestore()
            //     .doc("Gigs/LNEYY0maGLXeMCFFe1tK")
            //     .update({ description: updatedText });
          }
        } else {
          console.log("NO DATA");
          return null;
        }
      } catch (error) {
        console.log(error);
        return null;
      }
    });

