from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    # HTML with inline CSS for 3D text styling
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
            span {
                color: white;
                text-shadow: 
                    1px 1px 2px black, 
                    2px 2px 4px black, 
                    3px 3px 8px black;
            }
        </style>
    </head>
    <body>
        Hello, <span>Viraja</span>!
    </body>
    </html>
    '''
    return html_content

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
