# Data Science Scenarios and ML Algorithm Selection Guide

## Conversation Overview

**User Request:**

> Try to list 15 different popular scenarios in the Data Science world where different ML Algorithms are used listing the following columns against the scenarios in Tabular format and a goto for all the Data Scientists in their lifetime:
> 1. 15 different scenarios
> 2. a. ML Algorithms Evaluated (in parallel before selecting one)
> b. Type of Algorithm
> c. Pre-processing Steps involved
> d. Sensitivity to Feature Scaling
> e. Visualizations used
> f. Contamination values provided before training Algorithm
> g. Threshold setting based on statistical percentiles / cut-off
> h. Algorithm Evaluations Techniques
> i. Performance & Evaluations Parameters accounted
> j. Common Hyperparameters used
> k. When to Avoid this Algorithm
> 3. Target Label
> 4. Problem It Solves
> 5. Domain-Driven Estimation / Heuristics
> 6. Metrics used for Evaluation
> 7. Interpretation of the results
> 8. Common Applications
> 9. Example — like House Pricing / Customer Churn / Loan Defaulting / Fraud Detection / Employee attrition
> 
> 

---

## Response

Here is the comprehensive reference guide and cheat sheet covering 15 canonical machine learning scenarios across data science domains.

---

### The Ultimate Data Science ML Scenario Reference Table

# The Ultimate Data Science ML Scenario Reference Table

| # | Scenario & Example | Target Label | Problem It Solves | Evaluated Algorithms (Parallel) | Type of Algorithm | Key Pre-processing Steps | Sensitivity to Feature Scaling |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | **Customer Churn Prediction**<br>*(Telecom / SaaS)* | Binary (`1` = Churned, `0` = Retained) | Identifies subscribers likely to cancel service to target retention campaigns. | Logistic Regression, Random Forest, **XGBoost** | Supervised (Classification) | Encoding categoricals, imputing missing values, scaling (for LR). | **High** for LR; **None** for Tree-based (XGBoost/RF). |
| **2** | **Credit Loan Default Risk**<br>*(Banking / Fintech)* | Binary (`1` = Default, `0` = Paid) | Minimizes credit loss by predicting borrower default risk. | Logistic Regression, **LightGBM**, CatBoost | Supervised (Classification) | Weight of Evidence (WoE) encoding, quantile binning, SMOTE/class weights. | **High** for LR; **Low/None** for LightGBM/CatBoost. |
| **3** | **Real Estate House Pricing**<br>*(PropTech)* | Continuous (Price in USD) | Estimates fair market value based on property features and location. | Ridge Regression, Random Forest Regressor, **XGBoost Regressor** | Supervised (Regression) | Log-transforming target/price, target encoding zip codes, outlier filtering. | **High** for Ridge; **None** for XGBoost/RF. |
| **4** | **Credit Card Fraud Detection**<br>*(Financial Services)* | Binary (`1` = Fraud, `0` = Genuine) | Prevents unauthorized transactions in real time. | Logistic Regression, XGBoost, **Isolation Forest**, One-Class SVM | Unsupervised / Semi-Supervised (Anomaly Detection) | Robust scaling, removing PII, handling extreme skew ($< 0.1\%$ positive). | **High** for Isolation Forest / SVM / LR. |
| **5** | **Employee Attrition Risk**<br>*(Human Resources)* | Binary (`1` = Left, `0` = Stayed) | Identifies flight-risk employees for HR intervention. | Logistic Regression, **Random Forest**, Extra Trees | Supervised (Classification) | Ordinal encoding tenure/performance, balancing classes via SMOTE. | **High** for LR; **None** for Random Forest. |
| **6** | **E-Commerce Customer Segmentation**<br>*(Retail)* | None (Unlabeled Clusters) | Groups shoppers by RFM (Recency, Frequency, Monetary) behavior for targeted marketing. | **K-Means**, Agglomerative Clustering, DBSCAN | Unsupervised (Clustering) | Log-transforming RFM scores, outlier removal, Standardization. | **High** (Mandatory for distance-based clustering). |
| **7** | **E-Commerce Product Recommendations**<br>*(Retail / Media)* | Rating or Implicit Click (`0`/`1`) | Delivers personalized product feeds to boost conversion rates. | User-KNN, **SVD (Matrix Factorization)**, Neural Collaborative Filtering | Unsupervised / Self-Supervised | Constructing Sparse User-Item matrices, centering rating means. | **Low** (Operates on matrix entries/embeddings). |
| **8** | **Patient Disease Diagnosis**<br>*(Healthcare / Medical)* | Binary / Multi-class (Disease Type) | Aids clinicians in early diagnostic screening from biomarker data. | **Logistic Regression**, Support Vector Machine (SVM), Random Forest | Supervised (Classification) | Imputing missing lab values via KNNImputer, StandardScaler. | **High** for LR and Linear/RBF SVM. |
| **9** | **Customer Review Sentiment Analysis**<br>*(NLP / E-Commerce)* | Multi-class (`Positive`, `Neutral`, `Negative`) | Automatically monitors customer satisfaction from feedback. | **Multinomial Naive Bayes**, Logistic Regression, DistilBERT | Supervised (NLP / Text Classification) | Lowercasing, punctuation/stopword removal, TF-IDF vectorization. | **Low** for Naive Bayes; **High** for Logistic Regression. |
| **10**| **Retail Store Demand Forecasting**<br>*(Supply Chain)* | Continuous (Units Sold) | Optimizes inventory levels to prevent stockouts and overstock. | **Prophet**, ARIMA, XGBoost with Time-Features | Supervised (Time Series Forecasting) | Creating lag features, rolling statistics, Fourier terms for seasonality. | **High** for ARIMA/Prophet; **None** for XGBoost. |
| **11**| **High-Dimensional Data Compression**<br>*(Genomics / Image Analysis)* | None | Reduces thousands of input features into a compact, non-redundant space. | **PCA**, t-SNE, UMAP | Unsupervised (Dimensionality Reduction) | Mean-centering features, unit variance scaling (StandardScaler). | **Crucial** (Unscaled variance distorts principal components). |
| **12**| **Payroll Salary Anomaly Detection**<br>*(Enterprise Ops)* | Binary (`-1` = Anomaly, `1` = Normal) | Flags erroneous payroll entries before disbursement. | **Isolation Forest**, Local Outlier Factor (LOF), Elliptic Envelope | Unsupervised (Anomaly Detection) | Numeric scaling, filtering inactive employees, log transformation. | **Moderate** for Isolation Forest; **High** for LOF. |
| **13**| **Automated Spam Email Filtering**<br>*(Cybersecurity)* | Binary (`1` = Spam, `0` = Ham) | Filters malicious or promotional emails out of primary inboxes. | **Multinomial Naive Bayes**, SVM, Logistic Regression | Supervised (Text Classification) | Tokenization, lemmatization, stripping HTML tags, Bag-of-Words / TF-IDF. | **Low** for Naive Bayes; **High** for Linear SVM. |
| **14**| **Predictive Maintenance for Machinery**<br>*(Manufacturing)* | Time-To-Failure (Regression) / Binary Breakdown | Predicts equipment failure to schedule repairs before breakdowns occur. | Random Forest Regressor, **XGBoost**, LSTM | Supervised (Regression / Classification) | Time-window aggregation, sensor noise smoothing (Savitzky-Golay), FFT features. | **None** for Trees; **High** for LSTM / Neural Nets. |
| **15**| **Loan Application Automated Approval**<br>*(Fintech)* | Binary (`1` = Approved, `0` = Rejected) | Automates instant loan approvals while ensuring full regulatory compliance. | **Decision Tree**, Logistic Regression, XGBoost | Supervised (Classification) | Handling missing values, standardizing income attributes, target encoding. | **High** for LR; **None** for Decision Trees. |



---
### Deep-Dive Configuration, Evaluations & Governance

#### 1. Customer Churn Prediction

* **Domain Estimation / Heuristics:** Historical baseline churn rate sits around $2\% - 5\%$ per month.
* **Contamination / Percentile Threshold:** Set decision probability threshold at $0.35$ (lowered from $0.50$ to catch more churners).
* **Evaluations & Visualizations:** ROC-AUC Curve, Precision-Recall Curve, Cumulative Gain Charts, Confusion Matrix.
* **Evaluation Metrics:** ROC-AUC, Recall (Sensitivity), F1-Score.
* **Common Hyperparameters:** `n_estimators=300`, `max_depth=5`, `learning_rate=0.05`, `scale_pos_weight=4`.
* **Interpretation:** Predicts probability of churn; features like "contract length" and "support tickets" drive predictions.
* **When to Avoid:** Avoid XGBoost when extreme real-time latency ($<1\text{ms}$) or simple SQL-only deployment is required.

#### 2. Credit Loan Default Risk

* **Domain Estimation / Heuristics:** Target default rate is estimated at $3\% - 8\%$ based on economic cycles.
* **Contamination / Percentile Threshold:** Cutoff probability set at the $92\text{nd}$ percentile to cap total portfolio default risk.
* **Evaluations & Visualizations:** Gini Coefficient Chart, Kolmogorov-Smirnov (KS) Plot, Calibration Curves.
* **Evaluation Metrics:** Gini Score, ROC-AUC, Log-Loss, Precision at fixed Recall.
* **Common Hyperparameters:** `num_leaves=31`, `min_child_samples=50`, `colsample_bytree=0.8`, `is_unbalance=True`.
* **Interpretation:** Outputs a probability score mapped to credit scorecards; enforces monotonic constraints.
* **When to Avoid:** Avoid complex tree ensembles when local banking regulations require explicit mathematical formulas for credit denial.

#### 3. Real Estate House Pricing

* **Domain Estimation / Heuristics:** Price per square foot usually follows a log-normal distribution with an expected variance of $\pm 10\%$.
* **Contamination / Percentile Threshold:** Filter out upper/lower $1\%$ extreme property outliers prior to model training.
* **Evaluations & Visualizations:** Predicted vs. Actual Scatter Plots, Residual Plots, Feature Importance Plots.
* **Evaluation Metrics:** RMSE, MAE, MAPE, $R^2$.
* **Common Hyperparameters:** `subsample=0.8`, `max_depth=6`, `learning_rate=0.03`, `reg_alpha=1.0`.
* **Interpretation:** Feature attribution reveals how much specific features (e.g., extra bathroom) add to house valuation.
* **When to Avoid:** Avoid tree models when predicting prices outside the training set's geographical bounds (trees cannot extrapolate trends).

#### 4. Credit Card Fraud Detection

* **Domain Estimation / Heuristics:** Fraud represents approximately $0.05\% - 0.1\%$ of total daily transaction volume.
* **Contamination / Percentile Threshold:** Set `contamination=0.001` or set score threshold at the $99.9\text{th}$ percentile.
* **Evaluations & Visualizations:** Precision-Recall Curve (PR-AUC), Confusion Matrix, Anomaly Score Distribution Plot.
* **Evaluation Metrics:** PR-AUC, Recall at $99\%$ Precision, Cost-Weighted Error.
* **Common Hyperparameters:** `contamination=0.001`, `n_estimators=200`, `max_samples='auto'`, `bootstrap=False`.
* **Interpretation:** Identifies transaction entries situated in low-density feature space regions.
* **When to Avoid:** Avoid unsupervised isolation forests when abundant, reliably labeled historical fraud data exists.

#### 5. Employee Attrition Risk

* **Domain Estimation / Heuristics:** Expected annual turnover is $10\% - 15\%$ across general corporate departments.
* **Contamination / Percentile Threshold:** Classification threshold set to $0.40$ to increase sensitivity for high-performing employees.
* **Evaluations & Visualizations:** SHAP Waterfall Plots, Feature Importance Bars, Partial Dependence Plots (PDP).
* **Evaluation Metrics:** F1-Score, Balanced Accuracy, Precision, Recall.
* **Common Hyperparameters:** `n_estimators=200`, `max_depth=8`, `class_weight='balanced'`, `min_samples_leaf=4`.
* **Interpretation:** Displays top attrition drivers (e.g., overtime hours, distance from home) per department.
* **When to Avoid:** Avoid using sensitive demographic data as model inputs to prevent bias and ensure legal compliance.

#### 6. E-Commerce Customer Segmentation

* **Domain Estimation / Heuristics:** Expect 3 to 6 distinct persona clusters based on purchasing behavior.
* **Contamination / Percentile Threshold:** Outliers filtered at distance thresholds $> 3$ standard deviations from cluster centroids.
* **Evaluations & Visualizations:** Elbow Method Plot, Silhouette Plots, 2D PCA Cluster Plots.
* **Evaluation Metrics:** Silhouette Coefficient, Davies-Bouldin Index, Calinski-Harabasz Index.
* **Common Hyperparameters:** `n_clusters=4`, `init='k-means++'`, `n_init=10`, `max_iter=300`.
* **Interpretation:** Defines marketing segments (e.g., "High-Value Loyalists", "Dormant Bargain Hunters").
* **When to Avoid:** Avoid K-Means when clusters have arbitrary, non-spherical shapes or vary drastically in density (use DBSCAN instead).

#### 7. E-Commerce Product Recommendations

* **Domain Estimation / Heuristics:** Expect matrix sparsity $> 99\%$ across the catalog.
* **Contamination / Percentile Threshold:** Keep top $K=10$ recommendations per user session.
* **Evaluations & Visualizations:** Long-Tail Item Distribution Plots, Hit-Rate Curves.
* **Evaluation Metrics:** Precision@K, Recall@K, MAP@K, NDCG (Normalized Discounted Cumulative Gain).
* **Common Hyperparameters:** `n_factors=100`, `init_mean=0`, `lr_all=0.005`, `reg_all=0.02`.
* **Interpretation:** Decomposes user-item matrix into latent preference components.
* **When to Avoid:** Avoid collaborative filtering for brand-new items or users with zero historical interactions (Cold Start Problem).

#### 8. Patient Disease Diagnosis

* **Domain Estimation / Heuristics:** Disease prevalence in target screening population is estimated at $5\% - 12\%$.
* **Contamination / Percentile Threshold:** Set decision threshold low ($0.15$) to minimize dangerous False Negatives.
* **Evaluations & Visualizations:** ROC Curves, Confusion Matrices, Decision Boundary Plots.
* **Evaluation Metrics:** Sensitivity (Recall), Specificity, ROC-AUC, F2-Score.
* **Common Hyperparameters:** `C=1.0`, `penalty='l2'`, `solver='lbfgs'`, `class_weight='balanced'`.
* **Interpretation:** Coefficients directly indicate the odds ratio increase for disease per biomarker unit.
* **When to Avoid:** Avoid opaque black-box neural networks when medical auditability and clinical reasoning are mandatory.

#### 9. Customer Review Sentiment Analysis

* **Domain Estimation / Heuristics:** Reviews skew positive ($60\%$ positive, $25\%$ negative, $15\%$ neutral).
* **Contamination / Percentile Threshold:** Highest predicted class probability wins (`argmax`).
* **Evaluations & Visualizations:** Confusion Matrix Heatmap, Word Cloud per Sentiment Class, Top TF-IDF Feature Bars.
* **Evaluation Metrics:** Macro F1-Score, Accuracy, Precision, Recall.
* **Common Hyperparameters:** `alpha=1.0` (Additive Laplace Smoothing), `ngram_range=(1,2)`.
* **Interpretation:** Identifies word associations driving positive vs. negative sentiment labels.
* **When to Avoid:** Avoid Naive Bayes when sentiment heavily relies on sarcasm, complex context, or long-range language dependencies.

#### 10. Retail Store Demand Forecasting

* **Domain Estimation / Heuristics:** Demand exhibits weekly and annual seasonal cycles with $5\% - 10\%$ trend growth.
* **Contamination / Percentile Threshold:** Cap extreme demand spikes caused by short-term supply chain disruptions.
* **Evaluations & Visualizations:** Time Series Line Overlay (Actual vs. Forecast), Component Decomposition Plots (Trend/Seasonality).
* **Evaluation Metrics:** MAE, RMSE, WAPE (Weighted Absolute Percentage Error), SMAPE.
* **Common Hyperparameters:** `yearly_seasonality=True`, `weekly_seasonality=True`, `changepoint_prior_scale=0.05`.
* **Interpretation:** Separates baseline demand trends from holiday and seasonal effects.
* **When to Avoid:** Avoid classical time-series models when predicting demand for newly launched products without historical data.

#### 11. High-Dimensional Data Compression

* **Domain Estimation / Heuristics:** Aim to capture $> 85\%$ total dataset variance in fewer dimensions.
* **Contamination / Percentile Threshold:** Retain components up to the elbow point on the Scree Plot.
* **Evaluations & Visualizations:** Scree Plot (Explained Variance), Cumulative Variance Curves, 2D/3D Feature Projection Plots.
* **Evaluation Metrics:** Cumulative Explained Variance Ratio, Reconstruction Error.
* **Common Hyperparameters:** `n_components=0.90` (retains $90\%$ variance), `svd_solver='full'`.
* **Interpretation:** Transforms correlated input features into uncorrelated orthogonal components.
* **When to Avoid:** Avoid PCA when non-linear manifold relationships dominate the feature space (use t-SNE or UMAP instead).

#### 12. Payroll Salary Anomaly Detection

* **Domain Estimation / Heuristics:** Administrative payroll errors account for roughly $0.5\% - 1\%$ of processing runs.
* **Contamination / Percentile Threshold:** Hardcode `contamination=0.01` or flag scores below the $1\text{st}$ percentile.
* **Evaluations & Visualizations:** Boxplots, Scatter Plots with Highlighted Outliers, Anomaly Score Histograms.
* **Evaluation Metrics:** Precision at Top-K, Recall, Inspection Reduction Rate.
* **Common Hyperparameters:** `contamination=0.01`, `n_estimators=100`, `max_samples=0.8`.
* **Interpretation:** Isolates records with anomalous feature combinations (e.g., low pay grade with high overtime).
* **When to Avoid:** Avoid Isolation Forest when dataset size is extremely small ($<30$ total rows).

#### 13. Automated Spam Email Filtering

* **Domain Estimation / Heuristics:** Inbound spam/promotional rate averages $30\% - 50\%$ of overall email traffic.
* **Contamination / Percentile Threshold:** Decision threshold set at $0.80$ probability to prevent misclassifying legitimate emails.
* **Evaluations & Visualizations:** Confusion Matrix, Precision-Recall Curves, Feature Importance Tables.
* **Evaluation Metrics:** Precision (Crucial to avoid filtering good emails), Recall, Accuracy.
* **Common Hyperparameters:** `alpha=0.1`, `fit_prior=True`, `min_df=3`.
* **Interpretation:** Calculates word probability ratios between spam and legitimate message corpora.
* **When to Avoid:** Avoid simple bag-of-words Naive Bayes when spammers use adversarial techniques like text obfuscation.

#### 14. Predictive Maintenance for Machinery

* **Domain Estimation / Heuristics:** Equipment failures occur in $< 2\%$ of total runtime hours.
* **Contamination / Percentile Threshold:** Prediction threshold adjusted to alert maintenance $48$ hours before estimated failure.
* **Evaluations & Visualizations:** Sensor Time Series Plots, Survival Curves, Feature Importance Maps.
* **Evaluation Metrics:** Mean Absolute Error (in hours), Precision, Recall, False Alarm Rate.
* **Common Hyperparameters:** `n_estimators=500`, `max_depth=6`, `learning_rate=0.02`, `subsample=0.7`.
* **Interpretation:** Identifies critical sensor thresholds (e.g., vibration spikes + temp increases) preceding failure.
* **When to Avoid:** Avoid static models if sensor telemetry stream characteristics drift continuously over time.

#### 15. Loan Application Automated Approval

* **Domain Estimation / Heuristics:** Target automated approval rate is $60\%$ with an expected error rate under $2\%$.
* **Contamination / Percentile Threshold:** Probability cutoff strictly configured at $0.70$ for instant approvals.
* **Evaluations & Visualizations:** Decision Tree Flowcharts, Confusion Matrix, Feature Split Graphs.
* **Evaluation Metrics:** Accuracy, Precision, F1-Score, Model Fairness/Disparate Impact Metrics.
* **Common Hyperparameters:** `max_depth=4`, `criterion='gini'`, `min_samples_split=20`, `ccp_alpha=0.01`.
* **Interpretation:** Produces simple, human-readable logic rules (e.g., *IF Income > $50k AND Debt < 30% THEN Approve*).
* **When to Avoid:** Avoid single decision trees when high predictive accuracy on complex non-linear patterns is required.









**Data Scientist’s ML Algorithm Selection Cheat Sheet** covering 15 very common real-world scenarios.

The key idea is **not** “Which algorithm is best?” but:

> **Which algorithms should I evaluate in parallel, what preprocessing do they need, how do I evaluate them, and when should I avoid them?**

I’ve also explicitly marked where **contamination** and **thresholds** apply, because those are especially important in anomaly detection but **do not apply to ordinary supervised classification/regression in the same way**.

---

# 15 Common Data Science Scenarios — ML Algorithm Selection Guide

## Part 1 — Problem, Algorithms & Data Preparation

| #      | Scenario                           | ML Algorithms Evaluated in Parallel                                                  | Type of Algorithm                  | Pre-processing Steps                                                                | Feature Scaling Sensitivity                                |
| ------ | ---------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------- | ----------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **1**  | 🏠 House Price Prediction          | Linear Regression, Ridge, Lasso, Random Forest, XGBoost/Gradient Boosting            | Regression                         | Missing values, categorical encoding, outlier treatment, feature engineering        | **High** for Linear/Ridge/Lasso; **Low** for Tree/Boosting |
| **2**  | 👥 Customer Churn                  | Logistic Regression, Decision Tree, Random Forest, XGBoost, SVM                      | Classification                     | Missing values, categorical encoding, class imbalance handling, feature engineering | **High** for Logistic/SVM; **Low** for Trees               |
| **3**  | 💳 Loan Default                    | Logistic Regression, Random Forest, XGBoost, LightGBM, SVM                           | Classification                     | Missing values, encoding, imbalance treatment, outlier handling                     | **High** for Logistic/SVM; **Low** for Trees               |
| **4**  | 💰 Fraud Detection                 | Logistic Regression, Random Forest, XGBoost, Isolation Forest, Autoencoder           | Classification + Anomaly Detection | Scaling, imbalance handling, feature engineering, leakage prevention                | Depends on algorithm                                       |
| **5**  | 👩‍💼 Employee Attrition           | Logistic Regression, Decision Tree, Random Forest, XGBoost                           | Classification                     | Encoding, missing values, imbalance treatment, feature engineering                  | **High** for Logistic; **Low** for Trees                   |
| **6**  | 🏦 Credit Risk Scoring             | Logistic Regression, Random Forest, XGBoost, Gradient Boosting                       | Classification / Risk Scoring      | WOE/IV sometimes used, encoding, missing values, outlier treatment                  | Low–High depending on model                                |
| **7**  | 🛒 Customer Segmentation           | K-Means, Hierarchical Clustering, DBSCAN, Gaussian Mixture Model                     | Unsupervised Clustering            | Scaling, missing values, outlier treatment, dimensionality reduction                | **Very High** for K-Means/DBSCAN                           |
| **8**  | 🚨 Payroll/Sales Anomaly Detection | Isolation Forest, LOF, One-Class SVM, statistical IQR/Z-score                        | Anomaly Detection                  | Scaling where required, missing values, robust transformations                      | **High** for LOF/One-Class SVM; Low for Isolation Forest   |
| **9**  | 📈 Sales/Demand Forecasting        | ARIMA/SARIMA, Prophet, Random Forest, XGBoost, LSTM                                  | Time Series / Regression           | Date extraction, missing dates, lag features, rolling statistics                    | Usually low for tree models; depends on model              |
| **10** | 🏥 Disease Prediction              | Logistic Regression, Random Forest, XGBoost, SVM, Neural Network                     | Classification                     | Missing values, scaling, encoding, imbalance handling                               | **High** for SVM/Logistic/NN                               |
| **11** | 📧 Spam Detection                  | Naive Bayes, Logistic Regression, SVM, Random Forest                                 | Text Classification                | Tokenization, stop-word handling, TF-IDF/vectorization                              | Scaling usually not the main concern                       |
| **12** | 🎬 Recommendation System           | Collaborative Filtering, Matrix Factorization, Neural Networks, Content-Based Models | Recommendation / Ranking           | Missing interactions, normalization, embeddings/features                            | Depends on approach                                        |
| **13** | 🏭 Predictive Maintenance          | Logistic Regression, Random Forest, XGBoost, SVM, LSTM                               | Classification / Time Series       | Sensor cleaning, missing values, scaling, lag/rolling features                      | High for SVM/Logistic/LSTM                                 |
| **14** | 🛍️ Market Basket Analysis         | Apriori, FP-Growth, Association Rules                                                | Unsupervised Association Mining    | Transaction encoding, duplicate removal, basket creation                            | **Not applicable**                                         |
| **15** | 🖼️ Image Classification           | CNN, Transfer Learning, Vision Transformers                                          | Deep Learning / Classification     | Resize, normalization, augmentation, train/validation split                         | **Important**                                              |

---

# Part 2 — Contamination, Thresholds & Evaluation

| #      | Scenario               | Contamination Before Training     | Threshold / Cut-off                                             | Evaluation Techniques                            | Performance Parameters                                             |
| ------ | ---------------------- | --------------------------------- | --------------------------------------------------------------- | ------------------------------------------------ | ------------------------------------------------------------------ |
| **1**  | House Price            | **N/A**                           | Business/price-error tolerance                                  | Train/test split, K-fold CV                      | MAE, RMSE, R², MAPE                                                |
| **2**  | Customer Churn         | **N/A**                           | Probability threshold, e.g. 0.5 or business-optimized threshold | Stratified CV, holdout test                      | Precision, Recall, F1, ROC-AUC, PR-AUC                             |
| **3**  | Loan Default           | **N/A**                           | Default probability / risk cut-off                              | Stratified CV, calibration                       | Precision, Recall, F1, ROC-AUC, PR-AUC, calibration                |
| **4**  | Fraud Detection        | **Only for anomaly models**       | Fraud probability / anomaly score threshold                     | Time-based split, PR-AUC, cost-based validation  | Recall, Precision, F1, PR-AUC, fraud captured, false-positive rate |
| **5**  | Employee Attrition     | **N/A**                           | Attrition probability threshold                                 | Stratified CV, holdout                           | Precision, Recall, F1, ROC-AUC, PR-AUC                             |
| **6**  | Credit Risk            | **N/A**                           | Probability-of-default cut-off                                  | Cross-validation, calibration, backtesting       | AUC, KS, Gini, Brier score, Recall                                 |
| **7**  | Customer Segmentation  | Usually **N/A**                   | Cluster assignment / distance threshold                         | Silhouette, Davies-Bouldin, Calinski-Harabasz    | Silhouette score, cluster stability                                |
| **8**  | Anomaly Detection      | **Yes, if algorithm requires it** | Anomaly score / percentile / IQR threshold                      | Known-label validation if available; backtesting | Precision, Recall, F1, false-positive rate                         |
| **9**  | Demand Forecasting     | **N/A**                           | Prediction interval / business threshold                        | Rolling/Time-series CV                           | MAE, RMSE, MAPE, sMAPE, WAPE                                       |
| **10** | Disease Prediction     | **N/A**                           | Clinical probability threshold                                  | Stratified CV, external validation               | Sensitivity/Recall, Specificity, Precision, AUC                    |
| **11** | Spam Detection         | **N/A**                           | Spam probability threshold                                      | Stratified CV, holdout                           | Precision, Recall, F1, PR-AUC                                      |
| **12** | Recommendation         | **N/A**                           | Top-K / ranking threshold                                       | Offline validation + A/B testing                 | Precision@K, Recall@K, NDCG@K, MAP                                 |
| **13** | Predictive Maintenance | **N/A**                           | Failure probability / remaining-life threshold                  | Time-based validation                            | Recall, Precision, F1, lead time, false alarms                     |
| **14** | Market Basket          | **N/A**                           | Support/confidence/lift cut-offs                                | Rule validation / holdout transactions           | Support, Confidence, Lift                                          |
| **15** | Image Classification   | **N/A**                           | Class probability threshold                                     | Stratified split, cross-validation               | Accuracy, Precision, Recall, F1, ROC-AUC                           |

---

# Part 3 — Hyperparameters & When to Avoid

| #      | Scenario               | Common Hyperparameters                                              | When to Avoid / Be Careful                                                                                        |
| ------ | ---------------------- | ------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **1**  | House Price            | `n_estimators`, `max_depth`, `learning_rate`, `alpha`               | Avoid complex boosting when dataset is tiny and simple regression is sufficient                                   |
| **2**  | Customer Churn         | `max_depth`, `n_estimators`, `learning_rate`, `C`                   | Avoid relying only on accuracy when churn is rare                                                                 |
| **3**  | Loan Default           | `n_estimators`, `max_depth`, `learning_rate`, `class_weight`        | Avoid black-box models if strong regulatory/explainability requirements apply                                     |
| **4**  | Fraud Detection        | `contamination`, `n_estimators`, `max_samples`, `n_neighbors`       | Avoid unsupervised detection when good historical labels are available and a supervised model is more appropriate |
| **5**  | Employee Attrition     | `C`, `max_depth`, `n_estimators`, `learning_rate`                   | Avoid causal interpretation from a predictive model                                                               |
| **6**  | Credit Risk            | `C`, `max_depth`, `n_estimators`, `learning_rate`                   | Avoid poorly calibrated probabilities                                                                             |
| **7**  | Customer Segmentation  | `k`, `n_neighbors`, `eps`, `min_samples`                            | Avoid K-Means when clusters aren't roughly compact/spherical                                                      |
| **8**  | Anomaly Detection      | `contamination`, `n_estimators`, `max_samples`, `n_neighbors`, `nu` | Avoid blindly trusting anomaly scores without domain validation                                                   |
| **9**  | Demand Forecasting     | `p,d,q`, seasonality, `n_estimators`, `learning_rate`, lag length   | Avoid random train/test splitting because it causes temporal leakage                                              |
| **10** | Disease Prediction     | `C`, `kernel`, `max_depth`, `n_estimators`, network architecture    | Avoid optimizing solely for accuracy when false negatives are costly                                              |
| **11** | Spam Detection         | `alpha`, `C`, `ngram_range`, `max_features`                         | Avoid excessive feature dimensions without sufficient data                                                        |
| **12** | Recommendation         | Number of factors, regularization, learning rate, embedding size, K | Avoid offline metrics alone; user behavior must ultimately be validated                                           |
| **13** | Predictive Maintenance | `n_estimators`, `max_depth`, `learning_rate`, sequence length       | Avoid random splitting of time-dependent sensor data                                                              |
| **14** | Market Basket          | `min_support`, `min_confidence`, `min_lift`                         | Avoid generating huge numbers of weak rules                                                                       |
| **15** | Image Classification   | Learning rate, batch size, epochs, dropout, image size              | Avoid training large networks from scratch when data is limited                                                   |

---

# Part 4 — Target, Problem & Domain Heuristics

| #      | Scenario               | Target Label                  | Problem It Solves                     | Domain-Driven Heuristic / Estimation                                        |
| ------ | ---------------------- | ----------------------------- | ------------------------------------- | --------------------------------------------------------------------------- |
| **1**  | House Price            | `Price`                       | Estimate property value               | Location, area, bedrooms and comparable properties strongly influence price |
| **2**  | Customer Churn         | `Churn = 0/1`                 | Identify customers likely to leave    | Falling usage + complaints + contract expiry can indicate risk              |
| **3**  | Loan Default           | `Default = 0/1`               | Predict repayment risk                | Income, debt burden, credit history and repayment history matter            |
| **4**  | Fraud                  | `Fraud = 0/1` if labels exist | Detect suspicious transactions        | Unusual amount, location, frequency or merchant behavior                    |
| **5**  | Employee Attrition     | `Attrition = 0/1`             | Identify employees at risk of leaving | Tenure, role, compensation, workload and historical patterns                |
| **6**  | Credit Risk            | `Default = 0/1` / PD          | Estimate credit risk                  | Probability of default, exposure and repayment history                      |
| **7**  | Customer Segmentation  | **None**                      | Group similar customers               | Spending, frequency, recency and monetary value                             |
| **8**  | Anomaly Detection      | **Usually none**              | Find unusual observations             | Deviation from normal salary/transaction/operational patterns               |
| **9**  | Demand Forecasting     | `Future Sales`                | Predict future demand                 | Seasonality, trends, holidays and promotions                                |
| **10** | Disease Prediction     | `Disease = 0/1`               | Estimate disease risk                 | Symptoms, measurements, history and clinical variables                      |
| **11** | Spam                   | `Spam = 0/1`                  | Identify unwanted messages            | Words, phrases, sender behavior and message patterns                        |
| **12** | Recommendation         | User-item interaction         | Recommend relevant products/content   | Similar users/items and previous interactions                               |
| **13** | Predictive Maintenance | `Failure = 0/1` / RUL         | Predict equipment failure             | Vibration, temperature, pressure and operating hours                        |
| **14** | Market Basket          | **None**                      | Discover item relationships           | Items frequently bought together                                            |
| **15** | Image Classification   | Class label                   | Identify objects/classes              | Visual patterns learned from images                                         |

---

# Part 5 — Metrics, Interpretation & Applications

| #      | Scenario               | Metrics                                  | How to Interpret Results                                                                        | Common Applications           | Example                          |
| ------ | ---------------------- | ---------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------- | -------------------------------- |
| **1**  | House Price            | MAE, RMSE, R², MAPE                      | Lower error generally means predictions are closer to actual prices                             | Real estate valuation         | Predict house = ₹80L             |
| **2**  | Customer Churn         | Precision, Recall, F1, ROC-AUC, PR-AUC   | High recall finds more potential churners; precision controls unnecessary retention actions     | Telecom, SaaS                 | Predict customer will churn      |
| **3**  | Loan Default           | Recall, Precision, F1, AUC, PR-AUC       | High recall identifies more risky borrowers; threshold determines lending policy                | Banks, fintech                | Predict loan default             |
| **4**  | Fraud                  | Recall, Precision, PR-AUC, F1, cost      | Balance fraud caught against legitimate transactions blocked/flagged                            | Banking, payments             | Flag suspicious ₹5L transaction  |
| **5**  | Employee Attrition     | Recall, Precision, F1, AUC               | Identify employees requiring investigation/support; prediction isn't proof of future behavior   | HR analytics                  | Predict employee attrition risk  |
| **6**  | Credit Risk            | AUC, KS, Gini, Brier, calibration        | Measures ranking and reliability of predicted risk                                              | Banking, insurance            | Assign probability of default    |
| **7**  | Segmentation           | Silhouette, DBI, CH score                | Shows whether clusters are reasonably separated and cohesive                                    | Marketing                     | Premium/value/sensitive segments |
| **8**  | Anomaly Detection      | Precision, Recall, F1, alert rate        | High recall catches more anomalies; high precision reduces investigation workload               | Payroll, manufacturing, fraud | Detect ₹2L abnormal salary       |
| **9**  | Forecasting            | MAE, RMSE, MAPE, WAPE                    | Measures forecast error against actual future demand                                            | Retail, supply chain          | Forecast next month's sales      |
| **10** | Disease                | Sensitivity, Specificity, Precision, AUC | Sensitivity measures detection of actual positive cases; specificity measures correct negatives | Healthcare                    | Predict disease risk             |
| **11** | Spam                   | Precision, Recall, F1, PR-AUC            | High precision avoids deleting legitimate emails; high recall catches more spam                 | Email                         | Classify email as spam           |
| **12** | Recommendation         | Precision@K, Recall@K, NDCG@K, MAP       | Measures whether useful items appear near the top                                               | Netflix, Amazon, Spotify      | Recommend 10 products            |
| **13** | Predictive Maintenance | Recall, F1, false alarms, lead time      | Detect failures early without generating excessive false alarms                                 | Manufacturing, aviation       | Predict machine failure          |
| **14** | Market Basket          | Support, Confidence, Lift                | High lift indicates an association stronger than random co-occurrence                           | Retail                        | Bread → Butter                   |
| **15** | Image Classification   | Accuracy, Precision, Recall, F1, AUC     | Measures how accurately images are assigned to classes                                          | Healthcare, security, retail  | Cat vs dog classification        |

---

# The "Go-To" Algorithm Map

This is the part I'd recommend keeping as your **quick reference**.

| If your problem is...                | Start by evaluating...                                                                  |
| ------------------------------------ | --------------------------------------------------------------------------------------- |
| **Numerical value prediction**       | Linear/Ridge/Lasso + Random Forest + Gradient Boosting                                  |
| **Binary classification**            | Logistic Regression + Random Forest + Gradient Boosting                                 |
| **Highly imbalanced classification** | Logistic Regression + Random Forest + Gradient Boosting + PR-AUC                        |
| **Unknown/unlabelled anomalies**     | Isolation Forest + LOF + One-Class SVM + statistical baseline                           |
| **Customer grouping**                | K-Means + Hierarchical + DBSCAN                                                         |
| **Time-series forecasting**          | Naive baseline + ARIMA/SARIMA + tree-based lag model                                    |
| **Text classification**              | TF-IDF + Logistic Regression/SVM + Naive Bayes                                          |
| **Recommendation**                   | Popularity baseline + collaborative filtering + matrix factorization                    |
| **Images**                           | CNN/transfer learning + appropriate pretrained architecture                             |
| **Association discovery**            | Apriori + FP-Growth                                                                     |
| **High-dimensional data**            | Regularized linear models + tree ensembles + dimensionality reduction where appropriate |

---

# ⭐ The Most Important Decision Framework

When you receive **any new Data Science problem**, go through this checklist:

```text
                     BUSINESS PROBLEM
                            ↓
                   What am I predicting?
                            ↓
              ┌─────────────┴─────────────┐
              ↓                           ↓
          TARGET EXISTS              NO TARGET
              ↓                           ↓
        Supervised ML             Unsupervised ML
              ↓                           ↓
       Classification?          Clustering / Anomaly?
       Regression?               Association?
              ↓                           ↓
         Prepare data                 Prepare data
              ↓                           ↓
       Select 3–5 candidates        Select candidates
              ↓                           ↓
        Train in parallel            Train in parallel
              ↓                           ↓
       Cross-validation             Validation
              ↓                           ↓
      Compare performance + efficiency
              ↓
      ┌───────┴──────────────────┐
      ↓                          ↓
 Performance                 Business Cost
 accuracy/error              false positives
 precision/recall            false negatives
                              ↓
                       Interpretability
                              ↓
                         Scalability
                              ↓
                      Hyperparameter tuning
                              ↓
                       Final candidate
                              ↓
                    Business validation
                              ↓
                         Deployment
                              ↓
                       Monitor & retrain
```

## A crucial distinction: threshold vs contamination

These two concepts are often confused.

### **Contamination**

Mostly relevant to **anomaly-detection algorithms**.

For example:

```python
IsolationForest(contamination=0.04)
```

If you have 50 employees and believe approximately 2 are anomalous:

```text
2 / 50 = 0.04 = 4%
```

So `contamination=0.04` can be a starting assumption.

It is **not** a magical truth that the algorithm discovers automatically. If your estimate is wrong, the number of alerts can be inappropriate.

### **Threshold**

Usually applies to converting a model score/probability into a business decision.

For example:

```text
Predicted probability of churn = 0.73

Threshold = 0.50

0.73 > 0.50
       ↓
Flag as "high churn risk"
```

But `0.50` is not automatically optimal. You can choose the threshold based on **precision/recall, business costs, capacity for investigation, or statistical cut-offs**.

For anomaly scores, you can similarly establish thresholds using:

* 95th/99th percentile
* IQR
* Z-score
* Validation-set optimization
* Business tolerance limits

---

# 🧠 The Lifetime Data Scientist Rule

For almost every ML project, remember this sequence:

> **Baseline → Preprocess → Candidate Algorithms → Cross-Validate → Evaluate → Tune → Interpret → Business Validate → Deploy → Monitor**

And don't make this mistake:

> ❌ **"Random Forest gave 95% accuracy, so Random Forest is the best."**

Instead ask:

> **"What does the business need, what errors matter most, how does each candidate perform under the same validation procedure, how efficient is it, and can we trust and explain the resulting decisions?"**

That mindset is much closer to **real-world Data Science** than simply knowing which Python function calls which algorithm.
