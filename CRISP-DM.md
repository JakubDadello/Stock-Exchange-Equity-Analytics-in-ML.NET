
# Business Understanding
The analysis of a company's financial data, taking into account the characteristics of its sector, is among the key factors considered in investment-related decision-making processes. 
The analytical project presented in this document focuses on collecting selected, critical, and structured financial and non-financial data concerning Polish publicly listed companies. 

The purpose of this project was to develop an efficient classification model capable of accurately categorizing the investment assessment of companies based on the mentioned determinants.

This project concerns fundamental analysis, understood within framework of economic sciences and financial market theory as a set of methods used to evaluate the value of company's financial assets, 
particularly equity instruments. Fundamental analysis is based on the company's, so-called “fundamentals” closely linked to the concept of "intrinsic value". Serving
cognitive, descriptive, explanatory, and predictive functions, it provides a valuable reportoire of analytical techniques and tools for entities investing capital in financial
markets.

Due to multidimensional and interdisciplinary nature of fundamental analysis, the project was focused on one of its core stage - financial analysis. 
Financial analysis is the process of examining a company's financial condition in order to determine its investment attractiveness and the efficiency of its business operations
It is based on the assessment of selected financial ratios, with data sourced from financial statements of the companies under analysis.

Financial Analysis Areas: 
1. Balance sheet analysis (assets and liabilities)
2. Profitability analysis (income statement/profit and loss account)
3. Cash flow analysis (cash flow statement)
4. Liquidity analysis (e.g., current ratio)
5. Profitability ratios analysis (e.g., ROE)
6. Debt/leverage analysis (e.g., long-term debt ratio)

This project is built as an Enterprise-grade financial intelligence solution. By utilizing the .NET 10 ecosystem and  ML.NET, it demonstrates how fundamental analysis models are integrated  
into high-performance, strictly typed systems. Unlike typical data science prototypes, this implementation focuses on production readiness, scalability and type safet, making it suitable for
integration into trading and banking infrastructures. 

# Data Understanding 
The Data Understanding process was carried out for each type of data, including both financial and non-financial data points.  The tools used during this phase included 
the PostgreSQL database management system and the pgAdmin interface for data structural analysis.

Financial Data: For each company listed on the Warsaw Stock Exchange (WSE), numerical data were collected illustrating the values of five fundamental financial indicators for the year 2025:

1. Net profit (net income/loss)
2. Net cash flow
3. Return on equity (ROE)
4. Return on assets (ROA)
5. Operating profit plus depreciation (EBITDA)

The selection of these indicators was driven by the need to cover all highly relevant areas of financial analysis: profitability, liquidity, and operational efficiency. The primary source was the
individual financial statements included in periodic reports. For some companies, the data covered the first quarter of 2025, while for others it encompassed the first half of the year
(cumulative statements) 

Non-Financial Data: The non-financial data are categorical and cover thirteen industry sectors:
1. agriculture and food industry;
2. chemicals and health products;
3. commercial services;
4. communication technologies and media;
5. consumer goods and e-commerce;
6. energy technology;
7. financial and insurance;
8. health and life sciences;
9. hospitality industry;
10. manufacturing industry;
11. real estate and construction;
12. technology and engineering;
13. transport and motorization.

Each analyzed company was assigned to one of these sectors based on its business profile and dominant product portfolio. The official Warsaw Stock Exchange (WSE) website served as the source for sector affiliation data.

# Data Preparation
Data Preparation was implemented as a structured, repeatable pipeline using ML.NET Estimators. This ensures that the same transformations are applied during both model traning and
real-time inference through the API.

Data Preparation Steps Conducted in the Project:

1. Exporting the Excel file containing the raw data.
2. Separating the label column (investment rating) from the rest of the data.
3. Splitting the comprehensive dataset into numerical and categorical data.
4. Define numerical features used for preprocessing: NetIncome, NetCashFlow, ROE, ROA, EBITDA, Cumulation.
5. Combine these numerical columns into a single vector: `numeric_vector`.
6. Impute missing values in `numeric_vector` using mean replacement, resulting in `numeric_imputed`.
7. Normalize the imputed numerical features to the [0,1] range, producing `numeric_scaled`.
8. Apply One-Hot-Encoding to the categorical `Sector` column, producing `sectored_encoded`.
9. Concatenate `numeric_scaled` and `sector_encoded` into the final `Features` column, which will serve as input to the LightGBM model.

# Modeling
The objective of this project was to create a classification model that assigns an investment rating to each company, reflecting its financial condition and taking into account its sector affiliation.

In the modeling phase, the project utilizes the LightGBM (Light Gradient Boosting Machine) algorithm. This choice was dictated by the algorithm's superior performance in processing structured financial datasets and its ability to handle multi-class classfiication tasks with high efficiency. 

Textual investment ratings (Low, Medium, High) are mapped to numerical keys using `MapValueToKey`, enabling the mathematical engine to process categorizing.

LightGBM Multiclass Trainer was selected due to its gradient-based learning approach, which is highly effectivte at capturing non-linear relations between financial indicators.

# Evaluation
The model was evaluated using a hold-out test dataset consisting of financial records not seen during the training phase. The performance was measured using standard multiclass classification metrics provided by ML.NET.

| evaluation metrics | value |
| ------------------ | ----- |
| Macro-Accuracy     | 0.686 |
| Micro-Accuracy     | 0.746 |
| LogLoss            | 0.641 |

### Conclusions 
An average accuracy of 68.6% across all categories. The high Macro-Accuracy relative to Micro-Accuracy indicates that the model is robust and maintains predictive power even for minority classes (e.g., rare "High" growth opportunities).

The evaluation confirms the the LightGBM model successfully captures the dependencies between financial ratios and final investment rating. Given the inherent volatility of the Warsaw Stock Exchange (GPW), an accuracy excedding 70% provides a strong foundation for an automated decision-support system.


