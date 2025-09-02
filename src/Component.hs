{-# LANGUAGE OverloadedStrings #-}

module Component (mkComponent) where

import Miso
import Miso.Lens
import Miso.Html.Element as H
import Miso.Html.Event as E
-- import Miso.Html.Property as P

import Model

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
-- component
-------------------------------------------------------------------------------

mkComponent :: App Model Action
mkComponent = component emptyModel updateModel viewModel

