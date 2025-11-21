from fastapi import FastAPI
from typing import Optional, Literal

# For creating a reference model to avoid errors
from pydantic import BaseModel, Field

# for reading the saved model, scaler, columns etc
import joblib

# General packages for data manupilation
import pandas as pd
import numpy as npgit 


# Add Middle where

app = FastAPI(title="Crop Yield Prediction API")

# Load model, scaler, columns, category maps
model = joblib.load('best_model.pkl')
scaler = joblib.load('scaler.pkl')
ui_columns = joblib.load('UI_columns.pkl')
model_columns = joblib.load('model_columns.pkl')
model_dtypes = joblib.load('model_dtypes.pkl')


categorical_cols = ['region', 'crop_type', 'irrigation_type', 'fertilizer_type', 'crop_disease_status']


# Pydantic model for request
class CropData(BaseModel):
    region: str = Field(..., example= "East Africa")
    crop_type: str = Field(..., example= "Maize")
    soil_moisture: float = Field(..., alias="soil_moisture_%", le=100, ge=0, example=20.0)
    soil_pH: float = Field(..., ge=0, le=14, example=6.5)
    temperature_C: float = Field(..., example=28.0)
    rainfall_mm: float = Field(..., ge=0, example=100.0)
    humidity: float = Field(..., alias="humidity_%", ge=0, le=100, example=70.0)
    sunlight_hours: float = Field(..., ge=0, le=24, example=8.0)
    irrigation_type: str = Field(..., example="Manual")
    fertilizer_type: str = Field(..., example="Organic")
    pesticide_usage_ml: float = Field(..., ge=0, example=5.0)
    total_days: int = Field(..., ge=0, example=120)
    crop_disease_status: str = Field(..., example="Mild")



def process_input(data:CropData):
    # Convert to DataFrame
    df = pd.DataFrame([data.dict()])

    # Convert categorical cols to numeric
    df_encoded = pd.get_dummies(df, columns=categorical_cols)

    # Re arrange the columns and add missing columns
    for col in model_columns:
        if col not in df_encoded.columns:
            df_encoded[col] = 0

    # Re arrange the columns to match trained
    df_encoded = df_encoded[[col for col in model_columns]]  # reorder

    # Scale the data using the scaler used in training
    df_encoded_scaled = scaler.transform(df_encoded)

    return df_encoded_scaled



# Define a simple get method
@app.get("/")
async def read_root():
    return ("Crop Yield Prediction API, go to /prediction and and pass data for prediction")

# Prediction endpoint
@app.post("/predict")
def predict_crop_yield(data: CropData):
    df_input = process_input(data)
    prediction = model.predict(df_input)[0]
    return {"predicted_yield": float(prediction)}