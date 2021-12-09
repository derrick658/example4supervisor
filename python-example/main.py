from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    out_put = 'Hello world!'
    print('Response is {}'.format(out_put))
    return "<h1>{}</h1>".format(out_put)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
