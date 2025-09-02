
module Model where

-- import Miso
import Miso.Lens
import Miso.Lens.TH

newtype Model = Model
  { _modelCounter :: Int
  } deriving (Show, Eq)

makeLenses ''Model

emptyModel :: Model
emptyModel = Model 0

