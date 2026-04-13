using Microsoft.Extensions.ML;
using Schemas;

var builder = WebApplication.CreateBuilder(args);

// Register the ML.NET PredictionEnginePool
// Using PredictionEnginePool for thread-safe, scalable object pooling
// This is essential for high-concurrency environments like a web API
builder.Services.AddPredictionEnginePool<ModelInput, ModelOutput>()
    .FromFile("LightGBM_model.zip");

var app = builder.Build();

// Prediction Endpoint
// Minimal API endpoint for high-performance ML inference
app.MapPost("/predict", (PredictionEnginePool<ModelInput, ModelOutput> pool, ModelInput input) =>
{
    // English: Executing the model prediction using the pooled engine
    var predictions = pool.Predict(input);
    
    // Return the result with an HTTP 200 OK status
    return Results.Ok(predictions);
});

// Start the web application
// English: Listening on the port defined in Docker (8080)
app.Run();