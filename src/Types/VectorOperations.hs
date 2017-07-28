module Types.VectorOperations where

import qualified Data.Vector as V

-- | Calculate the dot product of two vectors.
(<.>) :: V.Vector Float -> V.Vector Float -> Float
v1 <.> v2 = V.sum $ V.zipWith (*) v1 v2

-- | Calculate the sum of two vectors.
(<+>) :: V.Vector Float -> V.Vector Float -> V.Vector Float
v1 <+> v2 = V.zipWith (+) v1 v2

-- | Calculate the difference of two vectors.
(<->) :: V.Vector Float -> V.Vector Float -> V.Vector Float
v1 <-> v2 = V.zipWith (-) v1 v2

-- | Scalar multiplication.
(^*) :: Float -> V.Vector Float -> V.Vector Float
c ^* v = V.map (*c) v
