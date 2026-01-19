# Polish-Equity-Analytics-.NET-LightGBM-Predictor

## Project Description
This project is an enterprise-grade evolution of the Polish-Equity-Analytics system (https://github.com/JakubDadello/Polish-Equity-Analytics.git). It utilizes C# and ML.NET to analyze financial data from 370 Polish listed companies (GPW).

The system incorporates sector-specific characteristics to support investment decision-making by classifying companies into three investment rating: Low, Medium, and High.

### Key Features
1. Technology Shift: Transitioned from Python to the .NET 9 ecosystem for better performance and enterprise integration.

2. Advanced Modeling: Replaced Random Forest with LightGBM (Gradient Boosting Machine) to enhance predictive accuracy on complex financial tabular data.

3. Sector-Aware Intelligence: Models financial indicators (e.g., net_profit, ROA) while accounting for the unique nature of different industry sectors.

4. Investment Grading: Automated assignment of investment levels based on robust multi-class classification.

## Repository Structure
- `PolishEquity.Analytics.Api/` - Model Serving & Inference: ASP.NET Core Web API providing real-time investment grading predictions via REST endpoints.
- `PolishEquity.Analytics.Schemas/` - Data Contracts: Shared Class Library containing strictly typed input/output models used across the entire solution.
- `PolishEquity.Analytics.Trainer/` - ML Pipeline: Console application dedicated to Data Preprocessing, LightGBM Model Training, and Evaluation.
- `CRISP-DM.md` - detailed methodology workflow

## How to Run

To run this project locally, you can use either Docker (recommended) or the .NET SDK.

### Using Docker 
* **Docker Compose:**
  ```bash
  docker-compose up --build

* **Build the image:**
  ```bash
  docker build -t polish-equity-api -f PolishEquity.Analytics.Api/Dockerfile .
* **Run the container:**
  ```bash
  docker run -d -p 8000:8000 --name polish-equity-container polish-equity-api

### Using Python (Local Environment)
* **Install requirements:**
  ```bash
  pip install -r requirements.txt
* **Launch FastAPI server:**
  ```bash
  uvicorn src.main:app --host 0.0.0.0 --port 8000
  
## Tech Stack

- Language & Runtime: C# 13/ .NET 10 SDK
- Machine Learning Framework: ML.NET (Microsoft.ML)
- Data Preprocessing: LINQ, Microsoft.Data.Analysis
- API Framework: ASP.NET Core 
- Backend & Deployment: Docker 

For the full CRISP-DM methodology, see [CRISP-DM.md](CRISP-DM.md) 

