const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification = functions.firestore
    .document('chats/{document}/messages/{document1}')
    .onCreate((snap, context) => {
        console.log('----------------start function--------------------')
        console.log(snap.data())
        admin
            .firestore()
            .collection('users')
            .get()
            .then(querySnapshot => {
                console.log(querySnapshot.size)
                querySnapshot.forEach(userTo => {
                    console.log(`Found user to: ${userTo.data()}`)
                })
            })
        return null
    })