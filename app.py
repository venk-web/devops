from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    # HTML with inline CSS for 3D text styling and an image
    html_content = '''
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body {
                background-color: blue;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                color: white;
                font-family: "Lucida Handwriting", cursive;
                font-size: 2em;
                text-align: center;
            }
            span {
                color: white;
                text-shadow: 
                    1px 1px 2px black, 
                    2px 2px 4px black, 
                    3px 3px 8px black;
            }
            img {
                border-radius: 50%;
                width: 150px;
                height: 150px;
                margin-top: 20px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.5);
            }
        </style>
    </head>
    <body>
        <div>Na life kadu, <span>Mana life</span>!</div>
        <img src="/static/your_image.jpg" alt="Your Picture">
    </body>
    </html>
    '''
    return html_content

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
