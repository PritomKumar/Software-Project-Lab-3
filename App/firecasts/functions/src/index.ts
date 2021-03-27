import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();



// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello Demon lord!", {structuredData: true});
  console.log("Console log hello");
  response.send("Hello from Pain!");
});

export const getGigInfo = functions.https.onRequest(async (request, response) => {
  try {
    const snapshotss = await admin.firestore().doc('Gigs/UpTzbCY8JsWBuTHqWl8K/Tasks/FHia6YicE6m9RCag0wr6/').get();
    const data = snapshotss.data();
    console.log("Data loading !!");
    console.log(data);
    response.send(data);
  } catch (error) {
    console.log("Error")
    response.status(500).send(error)
  }
  

});


