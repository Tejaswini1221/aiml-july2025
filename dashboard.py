import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import datetime

st.set_page_config(page_title="Credit Default Dashboard", layout="wide")

# -------------------------------
# Preprocessing
# -------------------------------
def preprocess(df: pd.DataFrame) -> pd.DataFrame:
    if df.empty:
        return df

    # Age
    df["AGE_YEARS"] = -df["DAYS_BIRTH"] / 365.25

    # Employment years (clip huge positives)
    df["EMPLOYMENT_YEARS"] = df["DAYS_EMPLOYED"].apply(
        lambda x: np.nan if x > 100000 else -x / 365.25
    )

    # Ratios
    df["DTI"] = df["AMT_ANNUITY"] / df["AMT_INCOME_TOTAL"]
    df["LOAN_TO_INCOME"] = df["AMT_CREDIT"] / df["AMT_INCOME_TOTAL"]
    df["ANNUITY_TO_CREDIT"] = df["AMT_ANNUITY"] / df["AMT_CREDIT"]

    # Income brackets safely
    try:
        df["INCOME_BRACKET"] = pd.qcut(
            df["AMT_INCOME_TOTAL"], q=4,
            labels=["Low","Mid-Low","Mid-High","High"],
            duplicates='drop'
        )
    except:
        df["INCOME_BRACKET"] = "Unknown"

    return df

# -------------------------------
# Page 1 — Overview & Data Quality
# -------------------------------
def page_overview(df):
    st.header("📊 Overview & Data Quality")
    st.markdown(f"**Report Generated:** {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

    if df.empty:
        st.warning("DataFrame is empty. Upload a valid CSV.")
        return

    # --- Basic KPIs ---
    col1, col2, col3 = st.columns(3)
    col1.metric("Total Applicants", f"{df['SK_ID_CURR'].nunique():,}" if 'SK_ID_CURR' in df.columns else "N/A")
    default_rate = df['TARGET'].mean() if 'TARGET' in df.columns else np.nan
    col2.metric("Default Rate (%)", f"{default_rate*100:.2f}%" if not np.isnan(default_rate) else "N/A")
    col3.metric("Repaid Rate (%)", f"{(1-default_rate)*100:.2f}%" if not np.isnan(default_rate) else "N/A")

    col4, col5, col6 = st.columns(3)
    col4.metric("Total Features", df.shape[1])
    
    # --- Missing Values ---
    missing_pct = df.isnull().mean() * 100
    avg_missing = missing_pct.mean()
    col5.metric("Avg Missing / Feature (%)", f"{avg_missing:.2f}%")
    col6.metric("Numerical Features", df.select_dtypes(include=['int64','float64']).shape[1])

    st.write("Missing Values (Top 20 columns)")
    top_missing = missing_pct.sort_values(ascending=False).head(20)
    if not top_missing.empty:
        fig, ax = plt.subplots(figsize=(10,5))
        top_missing.plot(kind="bar", ax=ax)
        ax.set_ylabel("% Missing")
        ax.set_xlabel("Feature")
        ax.set_title("Top 20 Missing Features")
        st.pyplot(fig)
    else:
        st.write("No missing values detected.")

    col7, col8 = st.columns(2)
    col7.metric("Categorical Features", df.select_dtypes(include=['object']).shape[1])
    col8.metric("Median Age (Years)", f"{df['AGE_YEARS'].median():.1f}" if 'AGE_YEARS' in df.columns else "N/A")

    # Target distribution (Pie Chart)
    if 'TARGET' in df.columns and not df['TARGET'].empty:
        st.subheader("Target Distribution")
        target_counts = df['TARGET'].value_counts()
        if not target_counts.empty:
            fig, ax = plt.subplots()
            ax.pie(target_counts, labels=["Repaid (0)", "Default (1)"], autopct='%1.1f%%', colors=["green","red"])
            ax.set_title("Target Distribution")
            st.pyplot(fig)

# -------------------------------
# Page 2 — Target & Risk Segmentation
# -------------------------------
def page_segmentation(df):
    st.header("🧩 Target & Risk Segmentation")
    if df.empty:
        st.warning("DataFrame is empty. Upload a valid CSV.")
        return

    col1, col2 = st.columns(2)
    col1.metric("Total Defaults", f"{df['TARGET'].sum():,}" if 'TARGET' in df.columns else "N/A")
    col2.metric("Default Rate (%)", f"{df['TARGET'].mean()*100:.2f}%" if 'TARGET' in df.columns else "N/A")

    # Pie charts for category distributions
    for col in ["CODE_GENDER","NAME_EDUCATION_TYPE","NAME_FAMILY_STATUS","NAME_HOUSING_TYPE"]:
        if col in df.columns:
            st.subheader(f"{col} Distribution")
            counts = df[col].value_counts()
            if not counts.empty:
                fig, ax = plt.subplots()
                ax.pie(counts, labels=counts.index, autopct='%1.1f%%')
                ax.set_title(f"{col} Distribution")
                st.pyplot(fig)

    # Avg values for defaulters
    if 'TARGET' in df.columns:
        def_cols = ['AMT_INCOME_TOTAL','AMT_CREDIT','AMT_ANNUITY','EMPLOYMENT_YEARS']
        for c in def_cols:
            if c in df.columns:
                st.metric(f"Avg {c} — Defaulters", f"{df.loc[df['TARGET']==1,c].mean():,.0f}")

# -------------------------------
# Page 3 — Demographics & Household Profile
# -------------------------------
def page_demographics(df):
    st.header("🏠 Demographics & Household Profile")
    if df.empty:
        st.warning("DataFrame is empty. Upload a valid CSV.")
        return

    if 'CODE_GENDER' in df.columns:
        st.subheader("% Male vs Female")
        counts = df['CODE_GENDER'].value_counts()
        fig, ax = plt.subplots()
        ax.pie(counts, labels=counts.index, autopct='%1.1f%%', colors=["lightblue","pink"])
        st.pyplot(fig)

    col1, col2, col3 = st.columns(3)
    col1.metric("Avg Age — Defaulters", f"{df.loc[df['TARGET']==1,'AGE_YEARS'].mean():.1f}" if 'TARGET' in df.columns else "N/A")
    col2.metric("Avg Age — Non-Defaulters", f"{df.loc[df['TARGET']==0,'AGE_YEARS'].mean():.1f}" if 'TARGET' in df.columns else "N/A")
    col3.metric("% With Children", f"{(df['CNT_CHILDREN']>0).mean()*100:.2f}%" if 'CNT_CHILDREN' in df.columns else "N/A")

    col4, col5, col6 = st.columns(3)
    col4.metric("Avg Family Size", f"{df['CNT_FAM_MEMBERS'].mean():.1f}" if 'CNT_FAM_MEMBERS' in df.columns else "N/A")
    if 'NAME_FAMILY_STATUS' in df.columns:
        counts = df['NAME_FAMILY_STATUS'].value_counts()
        st.subheader("% Married vs Single")
        fig, ax = plt.subplots()
        ax.pie(counts, labels=counts.index, autopct='%1.1f%%')
        st.pyplot(fig)

    if 'NAME_EDUCATION_TYPE' in df.columns:
        st.subheader("% Higher Education")
        counts = df['NAME_EDUCATION_TYPE'].value_counts()
        fig, ax = plt.subplots()
        ax.pie(counts, labels=counts.index, autopct='%1.1f%%')
        st.pyplot(fig)

    col7, col8, col9 = st.columns(3)
    col7.metric("% Living With Parents", f"{(df['NAME_HOUSING_TYPE']=='With parents').mean()*100:.2f}%" if 'NAME_HOUSING_TYPE' in df.columns else "N/A")
    col8.metric("% Currently Working", f"{df['OCCUPATION_TYPE'].notna().mean()*100:.2f}%" if 'OCCUPATION_TYPE' in df.columns else "N/A")
    col9.metric("Avg Employment Years", f"{df['EMPLOYMENT_YEARS'].mean():.1f}" if 'EMPLOYMENT_YEARS' in df.columns else "N/A")

# -------------------------------
# Page 4 — Financial Health & Affordability
# -------------------------------
def page_financials(df):
    st.header("💰 Financial Health & Affordability")
    if df.empty:
        st.warning("DataFrame is empty. Upload a valid CSV.")
        return

    col1, col2, col3 = st.columns(3)
    col1.metric("Avg Annual Income", f"{df['AMT_INCOME_TOTAL'].mean():,.0f}" if 'AMT_INCOME_TOTAL' in df.columns else "N/A")
    col2.metric("Median Annual Income", f"{df['AMT_INCOME_TOTAL'].median():,.0f}" if 'AMT_INCOME_TOTAL' in df.columns else "N/A")
    col3.metric("Avg Credit Amount", f"{df['AMT_CREDIT'].mean():,.0f}" if 'AMT_CREDIT' in df.columns else "N/A")

    col4, col5, col6 = st.columns(3)
    col4.metric("Avg Annuity", f"{df['AMT_ANNUITY'].mean():,.0f}" if 'AMT_ANNUITY' in df.columns else "N/A")
    col5.metric("Avg Goods Price", f"{df['AMT_GOODS_PRICE'].mean():,.0f}" if 'AMT_GOODS_PRICE' in df.columns else "N/A")
    col6.metric("Avg DTI", f"{df['DTI'].mean():.2f}" if 'DTI' in df.columns else "N/A")

    col7, col8, col9 = st.columns(3)
    col7.metric("Avg LTI", f"{df['LOAN_TO_INCOME'].mean():.2f}" if 'LOAN_TO_INCOME' in df.columns else "N/A")
    if 'TARGET' in df.columns:
        col8.metric("Income Gap (Non-def − Def)", f"{(df.loc[df['TARGET']==0,'AMT_INCOME_TOTAL'].mean() - df.loc[df['TARGET']==1,'AMT_INCOME_TOTAL'].mean()):,.0f}")
        col9.metric("Credit Gap (Non-def − Def)", f"{(df.loc[df['TARGET']==0,'AMT_CREDIT'].mean() - df.loc[df['TARGET']==1,'AMT_CREDIT'].mean()):,.0f}")

    st.metric("% High Credit (>1M)", f"{(df['AMT_CREDIT']>1e6).mean()*100:.2f}%" if 'AMT_CREDIT' in df.columns else "N/A")

# -------------------------------
# Page 5 — Correlations
# -------------------------------
def page_correlations(df):
    st.header("📈 Correlations & Drivers")
    if df.empty:
        st.warning("DataFrame is empty. Upload a valid CSV.")
        return

    numeric_cols = df.select_dtypes(include=['float64','int64']).columns
    corr = df[numeric_cols].corr()

    if 'TARGET' in numeric_cols:
        target_corr = corr['TARGET'].sort_values()
        st.subheader("Top 5 Positively Correlated with TARGET")
        st.write(target_corr.tail(5))
        st.subheader("Top 5 Negatively Correlated with TARGET")
        st.write(target_corr.head(5))

    st.subheader("Correlation Matrix (Numeric Features)")
    fig, ax = plt.subplots(figsize=(12,8))
    cax = ax.matshow(corr, cmap='coolwarm')
    plt.xticks(range(len(corr.columns)), corr.columns, rotation=90)
    plt.yticks(range(len(corr.columns)), corr.columns)
    fig.colorbar(cax)
    st.pyplot(fig)

# -------------------------------
# Main App
# -------------------------------
st.sidebar.title("Credit Default Dashboard")
uploaded_file = st.sidebar.file_uploader("Upload application_train.csv", type=["csv"], key="unique_file_uploader")

if uploaded_file is not None:
    df = pd.read_csv(uploaded_file)
    df = preprocess(df)

    page = st.sidebar.radio("Select Page",
        ["Overview & Data Quality", "Target & Risk Segmentation",
         "Demographics & Household", "Financial Health", "Correlations"]
    )

    if page == "Overview & Data Quality":
        page_overview(df)
    elif page == "Target & Risk Segmentation":
        page_segmentation(df)
    elif page == "Demographics & Household":
        page_demographics(df)
    elif page == "Financial Health":
        page_financials(df)
    elif page == "Correlations":
        page_correlations(df)
else:
    st.info("Please upload the application_train.csv file to start.")
