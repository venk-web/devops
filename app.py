from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    # HTML with inline CSS for styling
    html_content = '''
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body {
                background-color: blue;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                color: white;
                font-family: "Lucida Handwriting", cursive;
                font-size: 2em;
            }
        </style>
    </head>
    <body>
        Hello, Sandi!
    </body>
    </html>
    '''
    return html_content

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
