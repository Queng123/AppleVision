from flask import Flask, send_from_directory

app = Flask(__name__)

HLS_FOLDER = "hls"

@app.route('/hls/<path:filename>')
def stream_video(filename):
    return send_from_directory(HLS_FOLDER, filename)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)