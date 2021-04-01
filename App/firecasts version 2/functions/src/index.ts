import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// distance = 500
// level = 200 (1-10) for inactivit level goes down
// rating = 100
// misconduct = 0 to negative
// marital status = 50
// employmentStatus = 50 ? push notification send
// household income = 50
// education = 50
// current number of task = 300


exports.onAttemptedUsersUpdate = functions.firestore
    .document("Gigs/{gigId}")
    .onUpdate(async (change, context) => {
    // Get an object representing the current document
      try {
        const gigDataBefore = change.before.data();
        const gigDataAfter = change.after.data();
        const gigId = context.params.gigId;

        if (gigDataAfter) {
          console.log(gigDataAfter.description);
          console.log(`Now in gig = ${gigId}`);

          if (
            gigDataAfter.attemptedUsers.length ==
          gigDataBefore.attemptedUsers.length
          ) {
            console.log("The attempted users are the same");
            return null;
          }

          const attempData = gigDataAfter;
          if (attempData) {
            const attempUsers = attempData.attemptedUsers;
            const filteredUsers: any[] = [];
            attempUsers.forEach((singleUser: any) => {
              if (firstFilteringBasedOnBasicInfo(singleUser)) {
                filteredUsers.push(singleUser);
              }
            });
            const scores: number[] = [];
            const promises: any[] = [];
            let i = 0;
            filteredUsers.forEach((singleUser: any) => {
              console.log("User Email  = " + singleUser.email);
              scores[i] = calcuateScoresBasedOnDistance(singleUser);
              console.log(
                  "Distance score = " +
              calcuateScoresBasedOnDistance(singleUser)
              );
              scores[i] += calcuateScoresBasedOnUserLevel(singleUser);
              console.log(
                  "User Level score = " +
              calcuateScoresBasedOnUserLevel(singleUser)
              );

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
            i = 0;
            const results: any[] = [];
            if (reply) {
              reply.forEach((snap) => {
                const singleUserFullData = snap.data();

                scores[i] += calcuateHeuristicScore(singleUserFullData);
                console.log(`Heuristic score =
                 ${calcuateHeuristicScore(singleUserFullData)}`);

                results.push(singleUserFullData);
                i++;
              });
            }
            console.log(`results = ${results} and scores = ${scores}`);
            const highestScoreIndex = calculateTheBestScoreIndex(scores);
            console.log(scores);
            console.log(`results = ${results[highestScoreIndex]};
            and scores = ${scores[highestScoreIndex]}`);
            // response.send(`results = ${results[highestScoreIndex]}
            // and scores = ${scores[highestScoreIndex]}`);

            return await change.after.ref.update({
              assignedUser: filteredUsers[highestScoreIndex],
            });
          // return await admin
          //     .firestore()
          //     .doc("Gigs/LNEYY0maGLXeMCFFe1tK")
          //     .update({ description: updatedText });
          } else {
            console.log("No Data in function");
            return null;
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

// export const getAllAttemptedUsers = functions.https.onRequest(
//     async (request, response) => {
//       try {
//         const snapshotss = await admin
//             .firestore()
//             .doc("Gigs/PFPLTSAtQzW3o8hbocom/")
//             .get();

//         const attempData = snapshotss.data();
//         if (attempData) {
//           const attempUsers = attempData.attemptedUsers;
//           const filteredUsers: any[] = [];
//           attempUsers.forEach((singleUser: any) => {
//             if (firstFilteringBasedOnBasicInfo(singleUser)) {
//               filteredUsers.push(singleUser);
//             }
//           });
//           const scores: number[] = [];
//           const promises: any[] = [];
//           let i = 0;
//           filteredUsers.forEach((singleUser: any) => {
//             console.log("User Email  = " + singleUser.email);
//             scores[i] = calcuateScoresBasedOnDistance(singleUser);
//             console.log(
//                 "Distance score = " +
//             calcuateScoresBasedOnDistance(singleUser)
//             );
//             scores[i] += calcuateScoresBasedOnUserLevel(singleUser);
//             console.log(
//                 "User Level score = " +
//             calcuateScoresBasedOnUserLevel(singleUser)
//             );

//             const userInUsersDocument = admin
//                 .firestore()
//                 .doc(`Users/${singleUser.uid}`)
//                 .get();

//             promises.push(userInUsersDocument);
//             i++;
//           });

//           const reply = await Promise.all(promises);

//           // console.log("reply = " + reply);
//           // response.send("reply = " + reply);
//           i = 0;
//           const results: any[] = [];
//           if (reply) {
//             reply.forEach((snap) => {
//               const singleUserFullData = snap.data();

//               scores[i] += calcuateHeuristicScore(singleUserFullData);
//               console.log(`Heuristic score =
//                  ${calcuateHeuristicScore(singleUserFullData)}`);

//               results.push(singleUserFullData);
//               i++;
//             });
//           }
//           const highestScoreIndex = calculateTheBestScoreIndex(scores);
//           console.log(scores);
//           console.log(`results = ${results[highestScoreIndex]};
//           and scores = ${scores[highestScoreIndex]}`);
//           // response.send(`results = ${results[highestScoreIndex]}
//           // and scores = ${scores[highestScoreIndex]}`);

//           await admin
//               .firestore()
//               .doc("Gigs/PFPLTSAtQzW3o8hbocom")
//               .update({assignedUser: filteredUsers[highestScoreIndex]});
//           response.send(filteredUsers[highestScoreIndex]);
//         } else {
//           console.log("Error");
//           response.status(500).send("No Data");
//         }
//       } catch (error) {
//         console.log("Error");
//         response.status(500).send(error);
//       }
//     }
// );

/**
   * filter based on distance form the user
   * @param {any} user Any user of userminimum typr.
   * @return {bool} true if distance is greater than 15 km else false
   */
function firstFilteringBasedOnBasicInfo(user: any): boolean {
  if (user.distance < 15.0 && user.numberOfCurrentGigs<=3) {
    return true;
  } else {
    return false;
  }
}


/**
   * calcuate Scores Based On User Distance
   * @param {any} singleUser Any user of UserMinimum type.
   * @return {number} the score based on User Distance
   */
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


/**
   * calcuate heuristic score based on user data
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the heuristic score based on user data
   */
function calcuateHeuristicScore(singleUserFullData: any): number {
  let score = 0;
  score += calcuateScoresBasedOnCurrentGigs(
      singleUserFullData
  );
  console.log(
      "User Current gigs score = " +
      calcuateScoresBasedOnCurrentGigs(
          singleUserFullData
      )
  );
  score += calcuateScoresBasedOnUserRating(
      singleUserFullData
  );
  console.log(
      "User Rating score = " +
    calcuateScoresBasedOnUserRating(
        singleUserFullData
    )
  );
  score += calcuateScoresBasedOnUserMaritalStatus(
      singleUserFullData
  );
  console.log(
      "User Marital Status score = " +
    calcuateScoresBasedOnUserMaritalStatus(
        singleUserFullData
    )
  );

  score += calcuateScoresBasedOnUserEmploymentStatus(
      singleUserFullData
  );
  console.log(
      "User employment status score = " +
    calcuateScoresBasedOnUserEmploymentStatus(
        singleUserFullData
    )
  );
  score += calcuateScoresBasedOnUserHouseholdIncome(
      singleUserFullData
  );
  console.log(
      "User Household income score = " +
    calcuateScoresBasedOnUserHouseholdIncome(
        singleUserFullData
    )
  );

  score += calcuateScoresBasedOnUserEducationLevel(
      singleUserFullData
  );
  console.log(
      "User educational level score = " +
    calcuateScoresBasedOnUserEducationLevel(
        singleUserFullData
    )
  );
  return score;
}

/**
   * calcuate Scores Based On
   * The number of gigs the user is currently doing
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on
   * The number of gigs the user is currently doing
   */
function calcuateScoresBasedOnCurrentGigs(singleUserFullData: any): number {
  return 100* (3-singleUserFullData.currentGigs.length);
}


/**
   * calcuate Scores Based On User Level
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on User Level
   */
function calcuateScoresBasedOnUserLevel(singleUserFullData: any): number {
  return 200 * (singleUserFullData.level / 10);
}

/**
   * calcuate Scores Based On User Rating
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on User Rating
   */
function calcuateScoresBasedOnUserRating(singleUserFullData: any): number {
  return 100 * (singleUserFullData.rating / 10);
}

/**
   * calcuate Scores Based On User MaritalStatus
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on User MaritalStatus
   */
function calcuateScoresBasedOnUserMaritalStatus(
    singleUserFullData: any
): number {
  if (singleUserFullData.maritalStatus === "Not set") {
    return 50 * (0 / 4);
  } else if (singleUserFullData.maritalStatus === "Single") {
    return 50 * (3 / 4);
  } else if (singleUserFullData.maritalStatus === "Married") {
    return 50 * (4 / 4);
  } else if (singleUserFullData.maritalStatus === "Widowed") {
    return 50 * (2 / 4);
  } else if (singleUserFullData.maritalStatus === "Divorced") {
    return 50 * (2 / 4);
  } else if (singleUserFullData.maritalStatus === "Separated") {
    return 50 * (2 / 4);
  } else {
    return 50 * (1 / 4);
  }
}

/**
   * calcuate Scores Based On User EmploymentStatus
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on User EmploymentStatus
   */
function calcuateScoresBasedOnUserEmploymentStatus(
    singleUserFullData: any
): number {
  if (singleUserFullData.employmentStatus === "Not set") {
    return 50 * (0 / 5);
  } else if (singleUserFullData.employmentStatus === "Employed full time") {
    return 50 * (2 / 5);
  } else if (singleUserFullData.employmentStatus === "Employed part time") {
    return 50 * (3 / 5);
  } else if (singleUserFullData.employmentStatus === "Self-employed") {
    return 50 * (3 / 5);
  } else if (singleUserFullData.employmentStatus === "Military") {
    return 50 * (2 / 5);
  } else if (singleUserFullData.employmentStatus === "Student") {
    return 50 * (4 / 5);
  } else if (singleUserFullData.employmentStatus === "Retired") {
    return 50 * (4 / 5);
  } else if (singleUserFullData.employmentStatus === "Homemaker") {
    return 50 * (4 / 5);
  } else if (singleUserFullData.employmentStatus === "Unemployed") {
    return 50 * (5 / 5);
  } else {
    return 50 * (1 / 5);
  }
}

/**
   * calcuate Scores Based On User HouseholdIncome
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on User HouseholdIncome
   */
function calcuateScoresBasedOnUserHouseholdIncome(
    singleUserFullData: any
): number {
  if (singleUserFullData.householdIncome === "Not set") {
    return 50 * (0 / 7);
  } else if (singleUserFullData.householdIncome === "Less than 20,000 bdt") {
    return 50 * (7 / 7);
  } else if (singleUserFullData.householdIncome === "20,000 to 39,999 bdt") {
    return 50 * (5 / 7);
  } else if (singleUserFullData.householdIncome === "40,000 to 59,999 bdt") {
    return 50 * (4 / 7);
  } else if (singleUserFullData.householdIncome === "60,000 to 79,999 bdt") {
    return 50 * (3 / 7);
  } else if (singleUserFullData.householdIncome === "80,000 to 99,999 bdt") {
    return 50 * (2 / 7);
  } else {
    return 50 * (1 / 7);
  }
}

/**
   * calcuate Scores Based On User Education Level
   * @param {any} singleUserFullData Any user of userAccount type.
   * @return {number} the score based on User Education Level
   */
function calcuateScoresBasedOnUserEducationLevel(
    singleUserFullData: any
): number {
  if (singleUserFullData.educationLevel === "Not set") {
    return 50 * (0 / 10);
  } else if (
    singleUserFullData.educationLevel === "Less than high school diploma"
  ) {
    return 50 * (3 / 10);
  } else if (
    singleUserFullData.educationLevel === "High school degree or equivalent"
  ) {
    return 50 * (4 / 10);
  } else if (
    singleUserFullData.educationLevel === "Some college, no degree"
  ) {
    return 50 * (5 / 10);
  } else if (
    singleUserFullData.educationLevel === "Current college student"
  ) {
    return 50 * (6 / 10);
  } else if (singleUserFullData.educationLevel === "Associate degree") {
    return 50 * (7 / 10);
  } else if (singleUserFullData.educationLevel === "Bachelor's degree") {
    return 50 * (8 / 10);
  } else if (singleUserFullData.educationLevel === "Master's degree") {
    return 50 * (9 / 10);
  } else if (singleUserFullData.educationLevel === "Professional degree") {
    return 50 * (9 / 10);
  } else if (singleUserFullData.educationLevel === "Doctorate") {
    return 50 * (10 / 10);
  } else if (singleUserFullData.educationLevel === "Post-Doctorate") {
    return 50 * (10 / 10);
  } else {
    return 50 * (2 / 4);
  }
}


/**
   * calcuate the index of the highest score
   * @param {number[]} scores scores array
   * @return {number} index of the highest score
   */
function calculateTheBestScoreIndex(
    scores: number[]
): number {
  let index = 0;
  let maxi = -1;
  for (let i = 0; i < scores.length; i++) {
    if (scores[i] > maxi) {
      maxi = scores[i];
      index = i;
    }
  }
  return index;
}


