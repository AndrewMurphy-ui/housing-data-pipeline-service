from fastapi import FastAPI

app = FastAPI(title="Housing Data Pipeline Service")

@app.get("/health")
def health():
    return {"status": "ok"}

