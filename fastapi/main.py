import requests
from fastapi import FastAPI, Response

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Hello, World!"}

@app.get("/generate")
def generate(prompt: str):
    response = requests.post(
        "http://localhost:8080/api/generate",
        json={
            "prompt": prompt,
            "model": "llama3.2:3b",
            "stream": False
        }
    )

    # Check if the request was successful
    if response.status_code == 200:
        return Response(content=response.content, media_type="application/json")
    else:
        return Response(
            content=f"Error: {response.status_code} - {response.text}",
            media_type="application/json",
            status_code=response.status_code
        )
