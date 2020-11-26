import firebase_admin
import datetime
from firebase_admin import credentials, firestore

print('Railway Reservation Website Train Status Automation Started.')

cred = credentials.Certificate(
    "./railway-reservation-website-firebase-adminsdk-etsuh-2ceafccb80.json")
my_app = firebase_admin.initialize_app(cred)

print('Finished Initialisation.')

db = firestore.client()

allTrain_collection = db.collection('train').get()

print('Got all Train Data')

print('Updating Starts now....')

for eachTrain in allTrain_collection:
    each_day_train_status = eachTrain.reference.collection('trainStatus').document(
        (datetime.datetime.now()+datetime.timedelta(days=6)).strftime("%d-%m-%Y")).get()
    if not each_day_train_status.exists:
        eachTrain.reference.collection('trainStatus').document(
            (datetime.datetime.now() - datetime.timedelta(days=1)).strftime("%d-%m-%Y")).delete()
        eachTrain.reference.collection('trainStatus').document((datetime.datetime.now()+datetime.timedelta(days=6)).strftime("%d-%m-%Y")).set({
            u'available_ac_seats': 10,
            u'available_nor_seats': 15,
            u'available_sleeper_seats': 10,
            u'date': (datetime.datetime.now()+datetime.timedelta(days=6)).strftime("%d-%m-%Y"),
            u'booked_ac_seats': 0,
            u'booked_nor_seats': 0,
            u'booked_sleeper_seats': 0,
        })
        print('done!')
    else:
        print('Train Status Up-to-Date')


## Dummy Script ##
# p = (datetime.datetime.now()+datetime.timedelta(days=0)).strftime("%d-%m-%Y")
# db.collection('train').document('v5d0wTmM6dBlfricsrjQ').collection('trainStatus').document(p).set({
#     u'available_ac_seats': 10,
#     u'available_nor_seats': 15,
#     u'available_sleeper_seats': 10,
#     u'booked_ac_seats': 0,
#     u'booked_nor_seats': 0,
#     u'booked_sleeper_seats': 0,
#     u'date': p,
# })
# print('done')