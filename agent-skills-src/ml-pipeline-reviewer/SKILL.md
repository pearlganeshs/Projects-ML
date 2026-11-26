---
name: ml-pipeline-reviewer
description: Reviews machine learning training, feature engineering, and inference pipelines for data leakage, reproducibility, performance bottlenecks, and production readiness. Use when reviewing ML code, notebooks, or MLOps workflows.
---

#### ML Pipeline Reviewer
Audit the provided machine learning pipeline, notebook, or training script across five core dimensions. Present findings grouped by severity (**Critical**, **Warning**, **Optimization**), citing exact file names, functions, or line numbers. 

#### 1. Data Leakage & Validation Integrity
* **Train/Test Split Order:** Verify that train_test_split or time-based splitting occurs *before* any scaling, imputation, feature selection, or target encoding.
* **Temporal Leakage:** For time-series or sequential data, ensure future timestamps do not leak into training features or cross-validation folds (flag standard K-Fold if TimeSeriesSplit is required).
* **Group Leakage:** Check if related records (e.g., same user_id or session_id) are split across both train and validation sets instead of using GroupKFold.

#### 2. Reproducibility & Determinism
* **Random Seeds:** Check that seeds are explicitly set and logged across Python (random), NumPy (np.random), and the ML framework (torch, tensorflow, scikit-learn, xgboost).
* **Data & Artifact Versioning:** Flag hardcoded local file paths or unversioned datasets; recommend parameterizing data URIs and logging model artifacts/metrics.
* **Environment Pinning:** Verify that dependencies and hardware assumptions (CPU vs. CUDA/MPS) are handled gracefully.

#### 3. Feature Engineering & Inference Parity (Training-Serving Skew)
* **Pipeline Encapsulation:** Ensure transformations are wrapped in serializable pipelines (e.g., sklearn.pipeline.Pipeline, Spark ML Pipeline, or a shared feature store) rather than ad-hoc pandas mutations that cannot be replicated at inference time.
* **Null & Unseen Category Handling:** Check how the pipeline handles NaN values, schema drift, or unseen categorical values during live inference.

#### 4. Compute & Memory Efficiency
* **Vectorization:** Flag row-by-row .iterrows() or Python for loops over DataFrames/tensors; suggest vectorized NumPy/Pandas/Polars operations.
* **Memory Footprint:** Identify unnecessary deep copies of large DataFrames, unchunked full-dataset loads when streaming/batching is needed, or suboptimal data types (float64 where float32 suffices).

#### 5. Output Format
1. **Executive Summary:** 2-3 sentences on overall production readiness.
2. **Critical Issues (Must Fix):** Data leakage, silent bugs, or inference blockers with corrected code snippets.
3. **Warnings & Optimizations:** Reproducibility gaps, memory improvements, and refactoring recommendations.
