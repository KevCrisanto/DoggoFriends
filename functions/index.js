const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.onLikeDog = functions.firestore
    .document('/likes/{likeId}')
    .onCreate(event => {
        let dogId, userId;
        [dogId, userId] = event.params.likeId.split(':');

        const db = admin.firestore();
        const dogRef = db.collection('dogs').doc(dogId);
        db.runTransaction(t => {
            return t.get(dogRef)
                .then(doc => {
                    t.update(dogRef, {
                        like_counter: (doc.data().like_counter || 0) + 1
                    });
                })
        }).then(result => {
            console.log('Increased aggregate dog like counter.');
        }).catch(err => {
            console.log('Failed to increase aggregate dog like counter.', err);
        });
    });

exports.onUnlikeDog = functions.firestore
    .document('/likes/{likeId}')
    .onDelete(event => {
        let dogId, userId;
        [dogId, userId] = event.params.likeId.split(':');

        const db = admin.firestore();
        const dogRef = db.collection('dogs').doc(dogId);
        return db.runTransaction(t => {
            return t.get(dogRef)
                .then(doc => {
                    t.update(dogRef, {
                        like_counter: (doc.data().like_counter || 0) - 1
                    });
                })
        }).then(result => {
            console.log('Decreased aggregate dog like counter.');
        }).catch(err => {
            console.log('Failed to decrease aggregate dog like counter.', err);
        });
    });
