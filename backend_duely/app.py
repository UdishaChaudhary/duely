from flask import Flask, jsonify, request
from collections.abc import MutableMapping  # Correct import for Python 3.10+
import pymongo
from urllib.parse import quote_plus
import certifi
import os

# Initialize the Flask application
app = Flask(__name__)

password = quote_plus('duely341521')

# Connect to MongoDB
client = pymongo.MongoClient(f'mongodb+srv://udishachaudhary99:{password}@duelycluster.71cjgsv.mongodb.net/?retryWrites=true&w=majority&appName=DuelyCluster', tls=True, tlsCAFile=certifi.where())
db = client['tasks_db']
tasks_collection = db['tasks']


databases = client.list_database_names()
print("Databases:", databases)


@app.route('/add-task', methods=['POST'])
def add_task():
    task_data = request.get_json()
    if not task_data:
        return jsonify({"error": "No data provided"}), 400

    try:
        result = tasks_collection.insert_one(task_data)
        task_data["_id"] = str(result.inserted_id)
        return jsonify({"message": "Task added successfully", "task": task_data})
    except Exception as e:
        print(f"Error inserting data: {e}")
        return jsonify({"error": "Failed to add task"}), 500

@app.route('/homepage', methods=['POST'])
def homepage():
    data = request.json
    email = data.get('email')

    if not email:
        return jsonify({'error': 'Email is required'}), 400

    tasks = list(tasks_collection.find({'user_id': email}))

    for task in tasks:
        task['_id'] = str(task['_id'])

    return jsonify({'tasks': tasks}), 200

if __name__ == "__main__":
    #app.run(debug=True)
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)