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

export const getAllAttemptedUsers = functions.https.onRequest(
    async (request, response) => {
        try {
            const snapshotss = await admin
                .firestore()
                .doc("Gigs/krJmz1qVWH9ExokJGBVD/")
                .get();

            const attempData = snapshotss.data();
            if (attempData) {
                const attempUsers = attempData.attemptedUsers;

                const promises: any[] = [];
                attempUsers.forEach((singleUser: any) => {
                    const userInUsersDocument = admin
                        .firestore()
                        .doc(`Users/${singleUser.uid}`)
                        .get();
                    promises.push(userInUsersDocument);
                });

                const reply = await Promise.all(promises);

                // console.log("reply = " + reply);
                // response.send("reply = " + reply);

                const results: any[] = [];
                if (reply) {
                    reply.forEach((snap) => {
                        const data = snap.data();
                        results.push(data);
                    });
                }
                console.log(results);
                response.send(results);
            } else {
                console.log("Error");
                response.status(500).send("No Data");
            }
        } catch (error) {
            console.log("Error");
            response.status(500).send(error);
        }
    }
);

void async function calculateHeuristic(user: any) {};
