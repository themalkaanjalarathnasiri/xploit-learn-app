import sys
import os
sys.path.append(os.path.abspath(os.path.dirname(__file__)))

from flask import Flask, request, jsonify
from flask_cors import CORS
from utils.scraper import MasterScraper

app = Flask(__name__)
CORS(app)

@app.route('/api/lab-recommendations', methods=['POST'])
def lab_recommendations():
    data = request.get_json()
    skill_level = data.get('skillLevel')
    topics = data.get('topics')

    scraper = MasterScraper()
    recommendations = scraper.get_recommendations(skill_level, topics)

    return jsonify(recommendations)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)