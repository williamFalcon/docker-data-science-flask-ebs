from flask import Flask, Response

import json
application = Flask(__name__)

@application.route("/status")
def status():
    data = {'status': 'ok'}
    js = json.dumps(data)
    resp = Response(js, status=200, mimetype='application/json')
    return resp

if __name__ == "__main__":
    application.run(host='0.0.0.0')