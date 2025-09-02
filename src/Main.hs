{-# LANGUAGE OverloadedStrings #-}

import Miso
import Miso.Lens
import Miso.Lens.TH
import Miso.Html.Element as H
import Miso.Html.Event as E

-------------------------------------------------------------------------------
-- model
-------------------------------------------------------------------------------

newtype Model = Model
  { _modelCounter :: Int
  } deriving (Show, Eq)

makeLenses ''Model

emptyModel :: Model
emptyModel = Model 0

-------------------------------------------------------------------------------
-- actions
-------------------------------------------------------------------------------

data Action
  = AddOne
  | SubtractOne
  | SayHelloWorld
  deriving (Show, Eq)

-------------------------------------------------------------------------------
-- update
-------------------------------------------------------------------------------

updateModel :: Action -> Transition Model Action
updateModel action = 
  case action of
    AddOne        -> modelCounter += 1
    SubtractOne   -> modelCounter -= 1
    SayHelloWorld -> io_ $ do
      consoleLog "Hello World"
      alert "Hello World"

-------------------------------------------------------------------------------
-- view
-------------------------------------------------------------------------------

viewModel :: Model -> View Model Action
viewModel m = div_ []
  [ button_ [ onClick AddOne ] [ "+" ]
  , text $ ms (m ^. modelCounter)
  , button_ [ onClick SubtractOne ] [ "-" ]
  , button_ [ onClick SayHelloWorld ] [ "Alert Hello World!" ]
  ]

-------------------------------------------------------------------------------
-- main
-------------------------------------------------------------------------------

main :: IO ()
main = run $ startComponent $ component emptyModel updateModel viewModel

#ifdef WASM
foreign export javascript "hs_start" main :: IO ()
#endif

