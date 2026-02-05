using Microsoft.ML;
using Microsoft.ML.Data;

namespace Evaluating
{
    public static class Evaluator
    {
        public static MulticlassClassificationMetrics EvaluateModel(
            MLContext ml,
            ITransformer model,
            IDataView testData)
        {
            // Apply the trained model to the test dataset to generate predictions
            IDataView predictions = model.Transform(testData);

            // Compute performance metrics by comparing predictions 
            return ml.MulticlassClassification.Evaluate(
                predictions,
                labelColumnName: "Label",
                predictedLabelColumnName: "PredictedLabel");
        }
    }
}
