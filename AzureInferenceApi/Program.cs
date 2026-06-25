using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.ML;
using Schemas;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices(services =>
    {
        services.AddApplicationInsightsTelemetryWorkerService();
        services.ConfigureFunctionsApplicationInsights();

        // Rejestracja Twojego modelu
        services.AddPredictionEnginePool<ModelInput, ModelOutput>()
            .FromFile("LightGBM_model.zip");
    })
    .Build();

host.Run();