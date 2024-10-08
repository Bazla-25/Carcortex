import os
import psycopg2
from psycopg2.extras import RealDictCursor
from langchain.sql_database import SQLDatabase
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Load database configuration from environment variables with a default for the port
db_config = {
    'dbname': os.getenv('DB_NAME'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'host': os.getenv('DB_HOST'),
    'port': os.getenv('DB_PORT', '5432')  # Default to 5432 if not set
}

# Ensure the port is an integer
db_config['port'] = int(db_config['port'])

# Create a connection string for SQLDatabase
conn_str = f"postgresql+psycopg2://{db_config['user']}:{db_config['password']}@{db_config['host']}:{db_config['port']}/{db_config['dbname']}"

# Instantiate the SQLDatabase
db = SQLDatabase.from_uri(conn_str)

def get_db_connection():
    """Create a new database connection."""
    return psycopg2.connect(
        dbname=db_config['dbname'],
        user=db_config['user'],
        password=db_config['password'],
        host=db_config['host'],
        port=db_config['port'],
        cursor_factory=RealDictCursor
    )

import re

def execute_sql_query(sql_query):
    # Use a regular expression to extract the SQL query from the input
    cleaned_query = re.search(r'(?i)(SELECT.*?;)', sql_query, re.DOTALL)
    
    if cleaned_query:
        cleaned_query = cleaned_query.group(1)  # Get the matched query

        with db.connect() as connection:  # Assuming `db` is your database connection object
            result = connection.execute(cleaned_query)
            return result.fetchall()
    else:
        raise ValueError("Invalid SQL query provided.")

# Test the database connection and perform a simple query
# try:
#     query = "SELECT id FROM car LIMIT 1;"
#     connection = get_db_connection()
#     result = execute_sql_query(query)

#     if result:
#         print("Database connection successful! Test query result:", result)
#     else:
#         print("Test query failed. No results returned.")

# except Exception as e:
#     print(f"Error connecting to the database: {e}")

