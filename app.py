from flask import Flask, request, send_file, session, render_template, jsonify, flash
import os
import json
from collections import defaultdict
from sqlalchemy.dialects import registry
registry.register("cockroachdb", "cockroachdb.sqlalchemy.dialect",
                  "CockroachDBDialect")
from history_actions import HistoryActions

app = Flask(__name__)
app.secret_key = "asdfasfdasfdsafasddfsadfasdfsadfdas"
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
LIMIT = 10
database = HistoryActions(os.environ['DATABASE_URL'])

userHistory = defaultdict(list)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/history', methods=['GET', 'POST'])
def history():
    ip = request.remote_addr
    if request.method == 'GET':
        res = userHistory[ip] if ip in userHistory else []
        return jsonify({ip: res, 'ip_address': ip}), 200
    elif request.method == 'POST':
        title = request.get_json().get('title', '')
        code = request.get_json().get('code', '')

        userHistory[ip].append([title, code])
        while len(userHistory[ip]) > LIMIT:
            userHistory[ip].pop(0)
        return jsonify(success=True), 200
if __name__ == '__main__':
    userHistory = defaultdict(list)
    app.run(debug=True) #debug=True so that caching doesn't occur