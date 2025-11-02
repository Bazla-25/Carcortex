# Carcortex

Carcortex is a small FastAPI-based service that converts natural-language questions about cars into SQL queries using a local LLM helper module. It includes a lightweight web frontend served from the `static/` folder and several API endpoints you can call from tools or scripts.

This repository is intended as a developer-focused demo and prototyping playground for building natural-language → SQL tooling around a car dataset.

## Key files and structure

- `main.py` — FastAPI application and HTTP endpoints (serves `static/index.html`).
- `llama_llm.py` — module that converts user questions into SQL queries (LLM interface / prompt logic).
- `DbConnection.py` — (database connection helper; used if you want to run the generated SQL against a DB).
- `data/` — contains the example dataset and DB export files:
	- `cars_data(DATABASE)(in).csv` — CSV of car data used for experimentation.
	- `DB_file.sql` — SQL dump / schema helper.
- `static/index.html` — tiny frontend to ask questions from a browser.
- `requirements.txt` — Python dependencies for running the app.

## Features

- Convert natural-language car questions into SQL queries using `llama_llm.py`.
- Three API styles are exposed so you can call the service from a browser, form, or programmatically:
	- POST `/ask` — JSON body {"question": "..."}
	- POST `/ask-form` — form body `question` (useful for HTML forms)
	- GET `/ask-query?question=...` — query parameter
- Serves a simple HTML page at `/` for quick manual testing.

## Requirements

- Python 3.8+ (3.10/3.11 recommended)
- See `requirements.txt` for exact packages. Install into a venv.

## Quick start (development)

Open PowerShell, create a virtual environment, install dependencies, and run the app with Uvicorn:

```powershell
# from project root (Windows PowerShell)
python -m venv .venv; .\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# start the FastAPI app (reload mode for development)
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Open http://localhost:8000 in your browser to access the frontend.

## API usage examples

1) POST JSON to `/ask` (curl):

```bash
curl -X POST "http://localhost:8000/ask" -H "Content-Type: application/json" -d '{"question":"Show me cars with mpg > 30"}'
```

2) POST form to `/ask-form` (HTML form or curl):

```bash
curl -X POST "http://localhost:8000/ask-form" -F "question=Which cars have 4 cylinders and cost less than 20000?"
```

3) GET with query parameter to `/ask-query`:

```bash
curl "http://localhost:8000/ask-query?question=List%20cars%20with%20automatic%20transmission"
```

4) Python request example:

```python
import requests

resp = requests.post('http://localhost:8000/ask', json={'question': 'Which cars have rear-wheel drive?'})
print(resp.json())
```

The endpoints return a JSON object with an `answer` field containing the generated SQL string (or an error message).

## Notes on `llama_llm.py` and running queries

- `llama_llm.py` is responsible for converting natural-language input into SQL. By default the project returns the generated SQL string rather than executing it.
- If you want to execute generated SQL against a local database, inspect `DbConnection.py` and wire the SQL with proper parameterization and sanitization. Be careful: executing generated SQL carries risk — always validate and parameterize queries in production.

## Data

The repository includes a sample CSV (`data/cars_data(DATABASE)(in).csv`) and a SQL file (`data/DB_file.sql`). These are provided for local experimentation and to help you craft prompts and tests.

## Development tips

- Add unit tests for `llama_llm.py` prompts and expected SQL outputs.
- If you integrate a real LLM or external API, move keys and credentials into environment variables and never commit them.
- Consider adding a Dockerfile and Compose configuration if you plan to run a database and the app together.

## Troubleshooting

- If the server fails to start, check Python version and that the virtual environment is active.
- If requests time out, confirm the app is running on the expected port and that no firewall blocks it.

## Contributing

Contributions are welcome. Open an issue or submit a pull request with tests and a short description of your change.

## License

This project is provided under the MIT License (or choose your preferred license). See `LICENSE` if present.

## Contact

If you want help extending this project (database integration, better prompt engineering, etc.), open an issue or reach out to the repository owner.

---

Happy prototyping!