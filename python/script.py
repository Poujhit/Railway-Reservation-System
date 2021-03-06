import firebase_admin
import schedule
import time
import datetime
from firebase_admin import credentials, firestore

print('Railway Reservation Website Train Status Automation Started.')

cred = credentials.Certificate(
    'D:/flutter_app_folder/railway_reservation_website/python/api_key.json')

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
# i = 0

# alltrainId = ['0sayJZi4bChfx8Qwz4mF', '2nRqTzCkUd6vHiFcHNST', '5UalyEVIFK0QH2ttzIdj', '9USNnVWyvaTrU6wR9uQ2', 'EL1FmC9SJwTFKCXOk0Eh', 'LkeOFtjW0GKZTfoEQ9gY',
#               'QFZNRkMEZtJViarg3lXr', 'UXfEalFRnpcJFXthAadC', 'nAW5wCLS1r4VFKcBH1TI', 'psG2XRvblf6leRaxw019', 'rRMwrlaRDQsm50ExbDpn', 'v5d0wTmM6dBlfricsrjQ']

# while(i <= 6):
#     p = (datetime.datetime.now()+datetime.timedelta(days=i)).strftime("%d-%m-%Y")
#     for train_ids in alltrainId:
#         db.collection('train').document(train_ids).collection('trainStatus').document(p).set({
#             u'available_ac_seats': 10,
#             u'available_nor_seats': 15,
#             u'available_sleeper_seats': 10,
#             u'booked_ac_seats': 0,
#             u'booked_nor_seats': 0,
#             u'booked_sleeper_seats': 0,
#             u'date': p,
#         })
#         print('done')
#     i += 1
