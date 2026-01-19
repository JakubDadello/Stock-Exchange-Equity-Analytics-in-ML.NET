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
            IDataView predictions = model.Transform(testData);

            return ml.MulticlassClassification.Evaluate(
                predictions,
                labelColumnName: "Label",
                predictedLabelColumnName: "PredictedLabel");
        }
    }
}
