from base_chatbot import query
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.json.ensure_ascii = False  # to solve utf8 problem

@app.route("/question", methods=["GET"])
def query_api():
    get_question = request.args.get("query", "")
    answer = query(get_question)
    return answer

user = {}
@app.route('/complaint/submit', methods=["POST"])
def submit():
    if request.is_json:
        data = request.get_json()
        if "name" and "surname" and "no" and "title" and "complaint" and "email" and "date" in data:
            user["name"] = data["name"]
            user["surname"] = data["surname"]
            user["no"] = data["no"]
            user["title"] = data["title"]
            user["complaint"] = data["complaint"]
            user["email"] = data["email"]
            user["date"] = data["date"]
            return jsonify({"user": user, "message": "Şikayetiniz alınmıştır, teşekkürler!"})
        else:
            return jsonify({"error": "Eksik bilgi!"}), 400
    else:
        return jsonify({"error": "Hatalı istek!"}), 400


@app.route('/complaint/user')
def get_user():
    return jsonify({"user": user})

if __name__ == '__main__':
    app.run(debug=True)

