module Models.LinearRegression where

import Conduit
import Types.LinearRegressionUtils

-- | Given the size of the input features, and the learning rate alpha,
--   performs Linear Regression on incoming data stream.
linearRegression :: Int -> LearningRate -> ConduitM (Feature, Label) o IO Hypothesis 
linearRegression n alpha =
    loop (initialHypothesis (n+1)) alpha 
  where
    loop model alpha = do
        mx <- await
        case mx of
            Nothing -> return model
            Just (x_i, y_i) -> 
                let oldError   = costFunction model (x_i, y_i)
                    newModel   = trainHypothesis alpha model (x_i, y_i)
                    newError   = costFunction newModel (x_i, y_i)
                    deltaError = abs (newError - oldError)
                    threshold  = 0.000001
                  in case deltaError <= threshold of
                         True  -> return newModel
                         False -> do
                             loop newModel alpha
