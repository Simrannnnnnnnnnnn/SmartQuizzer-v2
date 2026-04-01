import os

class Config:
    
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'smart_quizzer_dev_key_99'
    MONGODB_URI = os.environ.get('MONGODB_URI')
    GROQ_API_KEY   = os.environ.get('GROQ_API_KEY')
    GEMINI_API_KEY = os.environ.get('GEMINI_API_KEY')
    UPLOAD_FOLDER    = os.environ.get('UPLOAD_FOLDER', '/tmp/uploads')
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024
    DEBUG = os.environ.get('FLASK_ENV') == 'development'
