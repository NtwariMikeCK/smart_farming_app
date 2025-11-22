# 🌱 Smart Farming Sensor Analysis & Yield Prediction

> **Empowering farmers with AI-driven insights for optimized crop yield prediction**

Modern agriculture demands data-driven decision-making to maximize productivity, reduce waste, and optimize resource usage. This project integrates **IoT sensor data** with **machine learning models** to predict crop yields based on environmental conditions, enabling farmers to make informed decisions for better harvest outcomes.

---

## 🎯 Problem Statement

Traditional farming methods often rely on intuition and experience, which can lead to:
- Inefficient resource utilization (water, fertilizers)
- Unpredictable crop yields
- Lack of real-time decision support

**Solution:** A machine learning-powered system that analyzes real-time sensor data to predict crop yields, helping farmers optimize their farming practices and improve productivity.

---

## Links

Youtube video: [Link](https://youtu.be/DVCbxtO0bIA)

## 📊 Dataset

**Source:** [Dataset Link](https://www.kaggle.com/datasets/atharvasoundankar/smart-farming-sensor-data-for-yield-prediction/data)

The dataset contains environmental and soil sensor readings from smart farming systems:

| Feature | Description | Unit |
|---------|-------------|------|
| `soil_moisture` | Moisture level in soil | % |
| `temperature` | Environmental temperature | °C |
| `humidity` | Ambient humidity | % |
| `light_intensity` | Solar radiation levels | Lux |
| `crop_yield` | Target variable - harvested amount | kg/hectare |
| `ETC` | Others |

---

## ✨ Features

### 🤖 Machine Learning
- Multiple regression models (Linear, Decision Tree, Random Forest)
- Comprehensive data preprocessing and feature engineering
- Model comparison and optimization
- Performance visualization (loss curves, scatter plots, heatmaps)

### 🌐 REST API
- FastAPI-based prediction endpoint
- Input validation with Pydantic models
- Interactive Swagger UI documentation
- Scalable and production-ready deployment

### 📱 Mobile Application
- Cross-platform Flutter app (iOS & Android)
- Intuitive single-screen interface
- Real-time yield predictions
- Error handling and user feedback

---

## 🛠 Technologies Used

### Backend & ML
- **Python 3.8+** - Core programming language
- **scikit-learn** - Machine learning models
- **pandas & numpy** - Data manipulation
- **matplotlib & seaborn** - Visualizations
- **FastAPI** - REST API framework
- **uvicorn** - ASGI server

### Mobile
- **Flutter 3.0+** - Cross-platform framework
- **Dart** - Programming language
- **http** - API communication

### DevOps
- **Git & GitHub** - Version control
- **Google Collab** - Exploratory analysis

---

## 🏗 Project Architecture

```
┌─────────────────┐
│  IoT Sensors    │
│  (Simulated)    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐      ┌──────────────────┐
│  Flutter App    │─────▶│   FastAPI        │
│  (Mobile UI)    │      │   (Prediction)   │
└─────────────────┘      └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │  ML Model (.pkl) │
                         │  (Trained Model) │
                         └──────────────────┘
```

---

## 📦 Installation & Setup

### Prerequisites
- Python 3.8 or higher
- Flutter SDK 3.0+
- Git

### 1️⃣ Clone Repository
```bash
git clone https://github.com/NtwariMikeCK/smart_farming_app.git
cd smart-farming-app
```

### 2️⃣ Set Up Python Environment
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 3️⃣ Set Up Flutter App
```bash
cd flutter_app
flutter pub get
```

---

## 🚀 Usage

### Train the Model
```bash
# Open Jupyter Notebook
jupyter notebook

# Navigate to notebooks/analysis.ipynb
# Run all cells to train and save the model
```

### Run the API Server
```bash
cd api
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Access Swagger UI: `http://localhost:8000/docs`

### Run the Mobile App
```bash
cd flutter_app
flutter run
```

---

## 📈 Model Performance

### Models Evaluated
1. **Linear Regression**
2. **Decision Tree Regressor**
3. **Random Forest Regressor**

### Best Model: [Random Forest]


### Visualizations

*Correlation Heatmap*
![Heatmap](<img width="1037" height="969" alt="correlation_heatmap" src="https://github.com/user-attachments/assets/2ff58403-5297-472e-8cc4-bf61f3a42833" />
)

*Training Loss Curve*
![Loss Curve](docs/images/loss_curve.png)

*Training Loss Curve*
![Loss Curve](<img width="989" height="590" alt="training loss curve" src="https://github.com/user-attachments/assets/615bdd9d-fced-4aa7-b194-3455f5d09fa1" />
)

---

## 📱 Mobile App

### Screenshots

| Home Screen | Prediction Result |
|------------|-------------------|
| ![Home](<img width="1080" height="2400" alt="Screenshot_1763750535" src="https://github.com/user-attachments/assets/1bf0eaef-c345-4437-b8f0-dbcb12bfc709" />)

 | ![Result](<img width="1080" height="2400" alt="Screenshot_1763750559" src="https://github.com/user-attachments/assets/9c4dff66-e2bf-4697-9fa0-acafa26e9e46" />) | 

### Features
- ✅ Input validation with real-time feedback
- ✅ Loading indicators during API calls
- ✅ Error handling with user-friendly messages
- ✅ Clean and intuitive UI design

---

## 🎥 Demo Video

📺 **Watch Full Demo:** [YouTube Link]

**Video Contents:**
- ✅ Model training and performance analysis
- ✅ API prediction demonstration (Swagger UI)
- ✅ Mobile app functionality walkthrough
- ✅ End-to-end system integration

**Duration:** 5 minutes

---

## 📁 Repository Structure

```
smart-farming-ml/
│
├── 📁 api/                  # FastAPI backend
│   ├── lr_env
│   ├── app.py
│   ├── requirements.txt
│   └── model_utils.py
│   ├── best_model.pkl
│   ├── scaler.pkl
│   ├── UI_columns.pkl
│   ├── model_columns.pkl
│
├── 📁 flutter_app/          # Mobile application
│   ├── lib/
│   ├── pubspec.yaml
│   └── README.md
│
├── 📁 Linear_regression/            # Jupyter notebooks
│   └── multivariate.ipynb
└── README.md
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👤 Author

**[Your Name]**
- 🎓 Student ID: [Your ID]
- 📧 Email: k.ntwari@alustudent.com
- 🐙 GitHub: [@yourusername](https://github.com/NtwariMikeCK)

---

## 📞 Support

If you encounter any issues or have questions:
- 🐛 Open an issue on GitHub
- 📧 Email: ntwarikevin95@gmail.com

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

Made with ❤️ for sustainable farming

</div>
