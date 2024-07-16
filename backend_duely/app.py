from flask import Flask, jsonify, request
from collections.abc import MutableMapping  # Correct import for Python 3.10+
import pymongo
from urllib.parse import quote_plus
import certifi
import os
import numpy as np
import copy  # Import copy module for deep copy

# Initialize the Flask application
app = Flask(__name__)

password = quote_plus('duely341521')

# Connect to MongoDB
client = pymongo.MongoClient(
    f'mongodb+srv://udishachaudhary99:{password}@duelycluster.71cjgsv.mongodb.net/?retryWrites=true&w=majority&appName=DuelyCluster',
    tls=True,
    tlsCAFile=certifi.where()
)
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
        print(task_data)
        task_data["task_id"] = np.random.randint(1000, 9999)  # Generate a random 4-digit number
        task_data["status"] = "unfinished"
        
        participants = task_data.get("participants", [])
        if participants != [""]:
            print(participants)
            for participant_name in participants:
                replicate_task = copy.deepcopy(task_data)
                replicate_task["user_id"] = participant_name
                id = tasks_collection.insert_one(replicate_task)

        result = tasks_collection.insert_one(task_data)
        task_data["_id"] = str(result.inserted_id)
        return jsonify({"message": "Task added successfully", "task": task_data})
    except Exception as e:
        print(f"Error inserting data: {e}")
        return jsonify({"error": "Failed to add task"}), 500
    
@app.route('/homepage', methods=['POST'])
def homepage():
    data = request.get_json()
    if not data or 'email' not in data:
        return jsonify({'error': 'Email is required'}), 400

    email = data.get('email')
    tasks = list(tasks_collection.find({'user_id': email}))

    for task in tasks:
        task['_id'] = str(task['_id'])

    return jsonify({'tasks': tasks}), 200

@app.route('/mark_done', methods=['POST'])
def mark_done():
    data = request.get_json()
    print(data)    
    if not data or 'taskId' not in data:
        return jsonify({'error': 'Task ID is required'}), 400
    
    task_id = int(data.get('taskId'))
    print(task_id)
    email = data.get('email')
    print(email)
    try:
        result = tasks_collection.update_one(
            {'task_id': int(task_id), 'user_id': email},
            {'$set': {'status': 'done'}}
        )
        print(result.matched_count)

        if result.matched_count == 0:
            return jsonify({'error': 'Task not found or not owned by user'}), 404

        return jsonify({'message': 'Task marked as done successfully'}), 200
    except Exception as e:
        print(f"Error updating task status: {e}")
        return jsonify({'error': 'Failed to mark task as done'}), 500

if __name__ == "__main__":
    #app.run(debug=True)
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)