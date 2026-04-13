using Microsoft.ML;
using DataOperations;     
using Training;     
using Evaluating; 

class Program
{
    public static void Main()
    {
        // 1. Initialize MLContext with a fixed seed for reproducibility
        var ml = new MLContext(seed: 42);

        // Define paths
        // In Docker, these should point to your shared volumes
        string dataPath = Path.Combine("Data", "initial_labeling_data.csv");
        string modelPath = Path.Combine("..", "StockExchangeEA.Api", "Models", "LightGBM_model.zip");

        Console.WriteLine("Loading data...");
        // 2. Load Data from CSV
        IDataView fullData = DataService.LoadData(ml, dataPath);

        // 3. Split data (80% training, 20% test)
        var split = ml.Data.TrainTestSplit(fullData, testFraction: 0.2);
        IDataView trainingData = split.TrainSet;
        IDataView testData = split.TestSet;

        Console.WriteLine("Training LightGBM model...");
        // 4. Train the base model (C# Expert)
        ITransformer model = BoosterTrainer.Train(ml, trainingData);

        // 5. Evaluation 
        Console.WriteLine("Evaluating Model...");
        var metrics = Evaluator.EvaluateModel (ml, model, testData);

        Console.WriteLine($"MacroAccuracy:{metrics.MacroAccuracy: 0.###}");
        Console.WriteLine($"MicroAccuracy:{metrics.MicroAccuracy: 0.###}");
        Console.WriteLine($"LogLoss:{metrics.LogLoss: 0.###}");

        // 6. Save the trained ML.NET model
        Directory.CreateDirectory(Path.GetDirectoryName(modelPath)!);
        ml.Model.Save(model, trainingData.Schema, modelPath);
        Console.WriteLine($"Model saved to: {modelPath}");
    }
}