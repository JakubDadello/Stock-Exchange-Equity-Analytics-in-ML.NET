using Microsoft.Extensions.ML;
using Schemas;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddPredictionEnginePool<ModelInput, ModelOutput>()
    .FromFile("models/LightGBM_model.zip");

var app = builder.Build();

app.MapPost("/predict", (PredictionEnginePool<ModelInput, ModelOutput> predictionEnginePool, ModelInput input) =>
{
    if (input == null)
    {
        return Results.BadRequest("Input data cannot be null.");
    }

    ModelOutput prediction = predictionEnginePool.Predict(input);

    return Results.Ok(prediction);
});

app.Run();