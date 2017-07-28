module Types.LinearRegressionUtils where

import qualified Data.Vector as V
import Types.VectorOperations

-- | Type of input independent variables. 
type Feature = V.Vector Float

-- | Type of input dependent variables.
type Label = Float

-- | Vector of parameters for Linear Regression model.
type Hypothesis = V.Vector Float

-- | Starting point of hypothesis, given dimension of vector.
initialHypothesis :: Int -> Hypothesis
initialHypothesis = flip V.replicate 0

-- | The step size of Stochastic Gradient Descent.
type LearningRate = Float

-- | Cost function we want to minimize.
costFunction :: Hypothesis -> (Feature, Label) -> Float
costFunction theta (x_i, y_i) = 
  let x_i' = V.cons 1 x_i in
    0.5 * (y_i - theta <.> x_i')^2

-- | Given a training example, where the first element is the
--   label, and the rest of the vector is the feature, update 
--   the hypothesis.
trainHypothesis :: LearningRate -> Hypothesis -> (Feature, Label) -> Hypothesis
trainHypothesis alpha theta (x_i, y_i) =
  let x_i' = V.cons 1 x_i in
     theta <+> ((alpha * (y_i - (theta <.> x_i'))) ^* x_i')
 
-- | Given a new feature, find it's label using the
--   Linear Regression hypothesis vector.
applyHypothesis :: Hypothesis -> V.Vector Float -> Float
applyHypothesis theta x = theta <.> (V.cons 1 x)
