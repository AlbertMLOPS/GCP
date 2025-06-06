from flask import Flask, request
app = Flask(__name__)

@app.route("/")
def main():
    return 'Modelo de ejemplo MLOps'

#@app.route("/train_pipeline")
#def train_pipeline():
#    from pipeline.train_pipeline import compile_pipeline, run_pipeline
#    compile_pipeline()
#    run_pipeline()
#    return 'Ejecución Correcta!'

@app.route("/train_pipeline")
def train_pipeline():
    try:
        from pipeline.train_pipeline import compile_pipeline, run_pipeline
        compile_pipeline()
        run_pipeline()
        return 'Ejecución Correcta!'
    except Exception as e:
        return f"Error en /train_pipeline: {str(e)}", 500

@app.route("/predict_pipeline")
def predict_pipeline():
    from pipeline.predict_pipeline import compile_pipeline, run_pipeline
    compile_pipeline()
    run_pipeline(scheduled=True)
    return 'Ejecución Correcta!'

@app.route("/on_demand_predict_pipeline")
def on_demand_predict_pipeline():
    from pipeline.predict_pipeline import compile_pipeline, run_pipeline
    compile_pipeline()
    run_pipeline(scheduled=False)
    return 'Ejecución Correcta!'

@app.route("/monitoring")
def monitoring():
    from pipeline.monitoring_prediction import all_models
    render_ = all_models()
    
    return render_