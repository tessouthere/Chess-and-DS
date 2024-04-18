
import streamlit as st
import pandas as pd
import plotly.express as px
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split


red = pd.read_csv('winequality-red.csv',sep=';')
white = pd.read_csv('winequality-white.csv',sep=';')
meta = pd.read_csv('MetaData.csv')
red['Color'] = 'Red'
white['Color'] = 'White'
data = pd.concat([red, white])
data = pd.DataFrame(data[['Color','fixed acidity', 'volatile acidity', 'citric acid', 'residual sugar',
                          'chlorides', 'free sulfur dioxide', 'total sulfur dioxide', 'density',
                          'pH', 'sulphates', 'alcohol', 'quality']])

st.title("Wine Quality Viewer")

tab1, tab2, tab3, tab4, tab5, tab6, tab7 = st.tabs(['MetaData', 'Data', 'Color', 'Quality', 'Scatter', 'Box', 'Classification'])

with tab1:
    st.header('Meta Data')
    st.dataframe(meta)

chem_data = pd.DataFrame(data[['Color','fixed acidity', 'volatile acidity', 'citric acid', 'residual sugar',
                               'chlorides', 'free sulfur dioxide', 'total sulfur dioxide', 'density',
                               'pH', 'sulphates']])
alc_data = pd.DataFrame(data[["Color","alcohol"]])
qual_data = pd.DataFrame(data[['Color','quality']])
with tab2:
    st.header('Data Set Viewer')
    choose_view = st.radio(
        "Choose DataSet View",
        ["Chemical", "Alcohol", "Quality", "All"])
    if choose_view == "Chemical":
        st.dataframe(chem_data)
    elif choose_view == "Alcohol":
        st.dataframe(alc_data)
    elif choose_view == "Quality":
        st.dataframe(qual_data)
    else:
        st.dataframe(data)

color = pd.Series(data['Color'])
color_counts = color.value_counts().reset_index().rename(columns={"Color": "Color", "count": "Number of Wines"})
with tab3:
    st.header('Color Distribution')
    st.bar_chart(color_counts, x="Color", y='Number of Wines')

quality = pd.Series(data['quality'])
quality_counts = quality.value_counts().reset_index().rename(columns={'quality':"Quality Rating", 'count':"Number of Wines"})
with tab4:
    st.header('Quality Distribution')
    st.bar_chart(quality_counts, x="Quality Rating", y='Number of Wines')

with tab5:
    st.header('Scatter Plots')
    st.write('Choose two features to compare with a scatterplot.')

    fa_check = st.checkbox("Fixed Acidity")
    va_check = st.checkbox("Volatile Acidity")
    ca_check = st.checkbox("Citric Acid")
    rs_check = st.checkbox("Residual Sugar")
    ch_check = st.checkbox("Chlorides")
    fsd_check = st.checkbox("Free Sulfur Dioxide")
    tsd_check = st.checkbox("Total Sulfur Dioxide")
    d_check = st.checkbox("Density")
    ph_check = st.checkbox("pH")
    s_check = st.checkbox("Sulphates")

    checks_dict = {fa_check:data['fixed acidity'], va_check:data['volatile acidity'], ca_check:data['citric acid'], rs_check:data['residual sugar'], ch_check:data['chlorides'],
                   fsd_check:data['free sulfur dioxide'], tsd_check:data['total sulfur dioxide'], d_check:data['density'], ph_check:data['pH'], s_check:data["sulphates"]}
    scatter_data = pd.DataFrame()
    for check in checks_dict:
        if check:
            scatter_data[check] = checks_dict[check]
    st.scatter_chart(data = scatter_data)

with tab6:
    st.header('Box Plots')
    st.write("Choose which boxplot to display")
    choose_plot = st.radio(
        "Choose Column to Plot",
        ['Fixed Acidity', 'Volatile Acidity', 'Citric Acid', 'Residual Sugar',
         'Chlorides', 'Free Sulfur Dioxide', 'Total Sulfur Dioxide', 'Density',
         'pH', 'Sulphates', 'Alcohol'])
    if choose_plot == 'Fixed Acidity':
        fig = px.box(data, y='fixed acidity')
        st.plotly_chart(fig)
    elif choose_plot == 'Volatile Acidity':
        fig = px.box(data, y='volatile acidity')
        st.plotly_chart(fig)
    elif choose_plot == 'Citric Acid':
        fig = px.box(data, y='citric acid')
        st.plotly_chart(fig)
    elif choose_plot == 'Residual Sugar':
        fig = px.box(data, y='residual sugar')
        st.plotly_chart(fig)
    elif choose_plot == 'Chlorides':
        fig = px.box(data, y='chlorides')
        st.plotly_chart(fig)
    elif choose_plot == 'Free Sulfur Dioxide':
        fig = px.box(data, y='free sulfur dioxide')
        st.plotly_chart(fig)
    elif choose_plot == 'Total Sulfur Dioxide':
        fig = px.box(data, y='total sulfur dioxide')
        st.plotly_chart(fig)
    elif choose_plot == 'Density':
        fig = px.box(data, y='density')
        st.plotly_chart(fig)
    elif choose_plot == 'pH':
        fig = px.box(data, y='pH')
        st.plotly_chart(fig)
    elif choose_plot == "Sulphates":
        fig = px.box(data, y='sulphates')
        st.plotly_chart(fig)
    else:
        fig = px.box(data, y='alcohol')
        st.plotly_chart(fig)

data = pd.get_dummies(data)
X = data.drop('quality', axis = 1)
y = data['quality']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

model = RandomForestClassifier()
model.fit(X_train, y_train)

global_importances = pd.Series(model.feature_importances_, index=X_train.columns)

from sklearn.metrics import classification_report
report = classification_report(y_test, model.predict(X_test), output_dict=True)
report_df = pd.DataFrame(report).transpose()

with tab7:
    st.header('Classification')
    st.write('Classification Report')
    st.dataframe(report_df)
    st.write("Feature Importances")
    st.bar_chart(global_importances)

