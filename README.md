# Polish-Equity-Analytics-.NET-LightGBM-Predictor

## Project Description
This project is an enterprise-grade evolution of the Polish-Equity-Analytics system (https://github.com/JakubDadello/Polish-Equity-Analytics.git) . It utilizes C# and ML.NET to analyze financial data from 370 Polish listed companies (GPW).

The system incorporates sector-specific characteristics to support investment decision-making by classifying companies into three investment tiers: Low, Medium, and High.

### Key Features
Technology Shift: Transitioned from Python to the .NET 8 ecosystem for better performance and enterprise integration.

Advanced Modeling: Replaced Random Forest with LightGBM to enhance predictive accuracy on complex financial tabular data.

Sector-Aware Intelligence: Models financial indicators (e.g., P/E, ROE, Liquidity) while accounting for the unique nature of different industry sectors.

Investment Grading: Automated assignment of investment levels based on robust multi-class classification.

## Repository Structure
- `PolishEquity.Analytics.Api/` - raw and labeled datasets (see `data/README.md`)
- `PolishEquity.Analytics.Schemas/` - SQL scripts 
- `PolishEquity.Analytics.Trainer/` - Jupyter notebooks for preprocessing and modeling experiments
- `CRISP-DM.md` - detailed methodology workflow

## How to Run

To run this project locally, you can use either Docker (recommended) or a standard Python environment.

### Using Docker 
* **Docker Compose:**
  ```bash
  docker-compose up --build

* **Build the image:**
  ```bash
  docker build -t polish-equity-analytics .
* **Run the container:**
  ```bash
  docker run -p 8000:8000 polish-equity-analytics

### Using Python (Local Environment)
* **Install requirements:**
  ```bash
  pip install -r requirements.txt
* **Launch FastAPI server:**
  ```bash
  uvicorn src.main:app --host 0.0.0.0 --port 8000
  

## Tech Stack

- Language: Python 3.11
- Libraries: Scikit-learn, Pandas, NumPy, Matplotlib, TensorFlow (MLP)
- Tools: Power BI, SQL (Data Extraction), Canva (Presentation)
- Backend & Deployment: FastAPI, Pydantic, Docker, Uvicorn, Joblib

For the full CRISP-DM methodology, see [CRISP-DM.md](CRISP-DM.md)

