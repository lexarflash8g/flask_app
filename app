"""
The requirements for this script are listed in the requirements.txt file.
They may be installed using the command "pip install -r requirements.txt"
"""
# stdlib

# 3rd party
import json
import flask
from flaskext.mysql import MySQL

app = flask.Flask(__name__)
# Set the secret key to some random bytes. Keep this really secret in production!
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

mysql = MySQL()

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'joy'
app.config['MYSQL_DATABASE_PASSWORD'] = 'joy'
app.config['MYSQL_DATABASE_DB'] = 'Strings'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


@app.route('/')
def hello():
    """
    Dummy Method
    """
    return "Hello World!"


@app.route('/json-get')
def json_get():
    """
    dummy method 1
    """
    return json.dumps({'hello': 'again'})


@app.route('/string', methods=["GET", "POST"])
def get_and_set_string():
    """
    Dummy method 2
    """
    conn = mysql.connect()
    cursor = conn.cursor()
    if flask.request.method == 'GET':
        key = flask.request.args.get('string', '')
        cursor.execute("SELECT * FROM Strings.Store WHERE string_key = %s;", (key))
        tmp = cursor.fetchall() or (('No results found for string {}'.format(key),),)
        results = ''
        for tup in tmp:
            results += ','.join([str(s) for s in tup]) + '\n'
    else:
        data = flask.request.get_json() or {}
        key = data.get('key')
        value = data.get('value')
        meta = data.get('meta')
        rows = cursor.execute(('INSERT INTO Strings.Store(string_key, string_value, string_meta)'
                               ' VALUES(%s, %s, %s);'),
                              (key, value, meta))
        conn.commit()
        if rows == 1:
            results = 'Stored {} {} {}'.format(key, value, meta)
        else:
            results = "There was some error"

    return results


if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)

