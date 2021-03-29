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

//distance = 500
//level = 200
//rating = 100
//misconduct = 0 to negative
//marital status = 50
//employmentStatus = 50 ? push notification send
//household income = 50
//education = 50
// total = 1000
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
                const filteredUsers: any[] = [];
                attempUsers.forEach((singleUser: any) => {
                    if (firstFilteringBasedOnBasicInfo(singleUser)) {
                        filteredUsers.push(singleUser);
                    }
                });
                var scores: number[] = [];
                const promises: any[] = [];
                var i = 0;
                filteredUsers.forEach((singleUser: any) => {
                    scores[i] = calcuateScoresBasedOnDistance(singleUser);
                    const userInUsersDocument = admin
                        .firestore()
                        .doc(`Users/${singleUser.uid}`)
                        .get();

                    promises.push(userInUsersDocument);
                    i++;
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

function firstFilteringBasedOnBasicInfo(user: any): boolean {
    if (user.distance < 15.0) {
        return true;
    } else {
        return false;
    }
}
function calcuateScoresBasedOnDistance(singleUser: any): number {
    if (singleUser.distance >= 0.0 && singleUser.distance <= 1.0) {
        return 500;
    } else if (singleUser.distance > 1.0 && singleUser.distance <= 2.0) {
        return 400 + 100 * (1 - (singleUser.distance - 1.0 / 1.0));
    } else if (singleUser.distance > 2.0 && singleUser.distance <= 3.5) {
        return 300 + 100 * (1 - (singleUser.distance - 2.0) / 1.5);
    } else if (singleUser.distance > 3.5 && singleUser.distance <= 5.0) {
        return 200 + 100 * (1 - (singleUser.distance - 3.5) / 1.5);
    } else if (singleUser.distance > 5.0 && singleUser.distance <= 8.0) {
        return 100 + 100 * (1 - (singleUser.distance - 5.0) / 3.0);
    } else if (singleUser.distance > 8.0 && singleUser.distance <= 11.0) {
        return 50 + 50 * (1 - (singleUser.distance - 8.0) / 3.0);
    } else if (singleUser.distance > 11.0 && singleUser.distance <= 15.0) {
        return 0 + 50 * (1 - (singleUser.distance - 11.0) / 4.0);
    } else {
        return 0.0;
    }
}
