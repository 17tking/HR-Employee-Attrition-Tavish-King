![image](https://github.com/user-attachments/assets/3f3d0b56-0ecb-4573-a63a-dfc79786f8e0)
# HR-Employee Attrition and Analysis

Employee attrition occurs when workers leave an organization without immediate replacements. High attrition often results from factors like low pay, poor work-life balance, ineffective management, and lack of career growth. Understanding who leaves and why is key to reducing turnover, as high attrition increases costs, knowledge loss, and staff burnout. Organizations can improve retention by using data-driven insights from surveys and exit interviews to address root causes and enhance workplace policies.

## Data Source

**🔗 to Dataset**: [IBM HR Analytics Employee Attrition and Performance-Kaggle](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset/data)

This is a fictional data set created by IBM data scientists. It includes the data of nearly 1500 employees and 35 variables. The dataset contains information on employee demographics, income, job satisfaction, job information, and whether or not the employee attrited.

**Disclosure**: This data is intended for research purposes and data practice. Models designed from this data are not designed to predict future attrition X number of months from now. The primary goal is research, data exploration, and inference, rather than developing a predictive model for future attrition. Typically, machine learning workflows involve splitting data into training and testing sets to evaluate how well a model generalizes. However, in this case, the objective is not to predict employee attrition a specific number of months from now but rather to understand the key factors associated with attrition and their relative importance.

## Project Scope

This analysis covers **4** key areas:

### 1. **Data Preparation (SQL & R)**

-   Using SQL and R to inspect, clean, and prepare the dataset for analysis

### 2. **Exploratory Data Analysis (SQL & R)**

-   Perform initial EDA in SQL with the string and binary variables\
-   Create visualizations in R to uncover relationships in the data with the numeric, binary, and string variables

### 3. **Modeling and Analysis (R)**

#### **Logistic Regression**

-   Applied generalized linear regression (logistic regression) to identify factors influencing employee attrition (binary outcome: stayed vs. quit)
-   Checked model assumptions
-   Constructed predictive probability plots to assess the variables individual contribution to attrition
-   Examined odds ratios (ORs) to quantify how each factor affects the likelihood of an employee leaving
-   Included demographic, job-related, and satisfaction-related variables to understand their impact

#### **Model Evaluation**

-   Using metrics such as **accuracy**, **Tjur's R^2^**, **Precision**, **Recall**, and the **F1-score** to evaluate how well our model performed and what can be done for future models.

### 4. **Conclusion and Company Insights**

-   Wrapping up the project with real-world, real-business strategies on the most influential factors from this analysis to help combat the negative impacts employee attrition can have on a company

# Want to see the full analysis? [Click Here!]()
