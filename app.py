from flask import Flask, request, send_file, session, render_template, jsonify, flash, session
import os
import json
from collections import defaultdict
from sqlalchemy.dialects import registry
registry.register("cockroachdb", "cockroachdb.sqlalchemy.dialect",
                  "CockroachDBDialect")
import firebase_admin
from firebase_admin import credentials, db
from history_actions import HistoryActions

app = Flask(__name__)
app.secret_key = "asdfasfdasfdsafasddfsadfasdfsadfdas"
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
LIMIT = 10
database = HistoryActions(os.environ['DATABASE_URL'])
cred = credentials.Certificate(json.loads(os.environ['FIREBASE_KEY']))
firebase_admin.initialize_app(cred)

userHistory = defaultdict(list)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/history', methods=['GET', 'POST'])
def history():
    ip = request.environ['REMOTE_ADDR']
    print("ip====",ip)
    if request.method == 'GET':
        try:
            res = db.reference('/ip').get()
        except:
            res = []
        return jsonify({'ip_address': res}), 200
    elif request.method == 'POST':
        title = request.get_json().get('title', '')
        code = request.get_json().get('code', '')
        #session["ip"].append({'title': title, 'code': code})
        #userHistory["ip"].append({'title': title, 'code': code})
        db.reference('/ip').update({'title': title, 'code': code})
        sz = len(db.reference("/ip").get())
        if sz > LIMIT:
            diff = sz - LIMIT
            keys = db.reference("/ip").get(shallow=True)
            for v in keys:
                if diff == 0: break
                db.reference("/ip/" + v).delete()
        return jsonify(success=True), 200
if __name__ == '__main__':
    app.run(debug=True) #debug=True so that caching doesn't occur