import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();



// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   console.log("Console log hello");
//   response.send("Hello from Firebase HA ha !");
// });

export const getSingleGigInfo = functions.https.onRequest((request, response) => {
  admin.firestore().doc('Gigs/A1vk0mCKxrIVPPmuyfEs').get()
  .then(snapshot=>{
    const data = snapshot.data()
    response.send(data)
  })
  .catch(error=>{
    console.log("Error")
    response.status(500).send(error)
  })
});
