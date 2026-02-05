# Polish-Equity-Analytics-.NET-LightGBM-Predictor

## Project Description
This project is an enterprise-grade evolution of the Polish-Equity-Analytics system (https://github.com/JakubDadello/Polish-Equity-Analytics.git). It utilizes C# and ML.NET to analyze financial data from 370 Polish listed companies (GPW).

The system incorporates sector-specific characteristics to support investment decision-making by classifying companies into three investment rating: Low, Medium, and High.

### Key Features
1. Technology Shift: Transitioned from Python to the .NET 10 ecosystem for better performance and enterprise integration.

2. Advanced Modeling: Replaced Random Forest with LightGBM (Gradient Boosting Machine) to enhance predictive accuracy on complex financial tabular data.

3. Sector-Aware Intelligence: Models financial indicators (e.g., net_profit, ROA) while accounting for the unique nature of different industry sectors.

4. Investment Grading: Automated assignment of investment rating based on robust multi-class classification.

## Repository Structure
- `PolishEquity.Analytics.Api/` - Model Serving & Inference: ASP.NET Core Web API providing real-time investment grading predictions via REST endpoints.
- `PolishEquity.Analytics.Schemas/` - Data Contracts: Shared Class Library containing strictly typed input/output models used across the entire solution. see [Schemas.cs](PolishEquity.Analytics.Schemas/Schemas/Schemas.cs)
- `PolishEquity.Analytics.Trainer/` - ML Pipeline: Console application dedicated to Data Preprocessing, LightGBM Model Training, and Evaluation. see [PolishEquity.Analytics.Trainer/README.md](PolishEquity.Analytics.Trainer/README.md)
- `CRISP-DM.md` - detailed methodology workflow

## How to Run

To run this project locally, you can use either Docker (recommended) or the .NET SDK.

### Using Docker 
* **Docker Compose:**
  ```bash
  docker-compose up --build

* **Build the image:**
  ```bash
  docker build -t pqa_dotnet_api -f PolishEquity.Analytics.Api/Dockerfile .
* **Run the container:**
  ```bash
  docker run -d -p 8001:8080 --name pqa_dotnet_container pqa_dotnet_api

### Using ASP.NET Core (Local Environment)

* **Launch ASP.NET Core binding to all interfaces:**
  ```bash
  dotnet run --urls "http://0.0.0.0:8000"

## Tech Stack

- Language & Runtime: C# 13/ .NET 10 SDK
- Machine Learning Framework: ML.NET (Microsoft.ML)
- Data Preprocessing: LINQ, Microsoft.Data.Analysis
- API Framework: ASP.NET Core 
- Backend & Deployment: Docker 

Consistent with the research conducted in the Polish-Equity-Analytics project (https://github.com/JakubDadello/Polish-Equity-Analytics.git), this repository maintains the same data processing standards. The documentation aligns with the original project's structure but is adapted for the ML.NET ecosystem. Detailed process descriptions are available in [CRISP-DM.md](CRISP-DM.md).
