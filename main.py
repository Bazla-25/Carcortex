from fastapi import FastAPI, Query, Form
from pydantic import BaseModel
from llama_llm import generate_sql_query
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Car Questions API", description="Ask questions about cars")

# Allow CORS for frontend interaction
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.mount("/static", StaticFiles(directory="static"), name="static")

@app.get("/")
async def read_index():
    return FileResponse('static/index.html')

class Question(BaseModel):
    question: str

class Answer(BaseModel):
    answer: str

@app.post("/ask")
async def ask_question(question: Question):
    if question.question.lower() == "quit":
        return Answer(answer="Session ended. Goodbye!")
    
    # Generate an SQL query from the user's question
    sql_query = generate_sql_query(question.question)
    return Answer(answer=f"{sql_query}")

@app.post("/ask-form")
async def ask_question_form(question: str = Form(...)):
    if question.lower() == "quit":
        return {"answer": "Session ended. Goodbye!"}
    
    sql_query = generate_sql_query(question)
    return {"answer": f"{sql_query}"}

@app.get("/ask-query", response_model=Answer)
async def ask_question_query(question: str = Query(...)):
    if question.lower() == "quit":
        return Answer(answer="Session ended. Goodbye!")
    
    try:
        sql_query = generate_sql_query(question)
        print(sql_query)
        return Answer(answer=f"{sql_query}")
    except Exception as e:
        return Answer(answer=f"An error occurred: {str(e)}")
