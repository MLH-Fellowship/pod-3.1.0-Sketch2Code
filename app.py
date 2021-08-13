from flask import Flask, request, send_file, session, render_template, jsonify, flash
import os
import json

app = Flask(__name__)
app.secret_key = "asdfasfdasfdsafasddfsadfasdfsadfdas"
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True) #debug=True so that caching doesn't occur
