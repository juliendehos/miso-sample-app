{-# LANGUAGE OverloadedStrings #-}

module Component (mkComponent) where

import Miso
import Miso.Lens
import Miso.Html.Element as H
import Miso.Html.Event as E
import Miso.Html.Property as P

import Model

-------------------------------------------------------------------------------
-- actions
-------------------------------------------------------------------------------

data Action
  = ActionAddOne
  | ActionSubtractOne
  | ActionSayHelloWorld

-------------------------------------------------------------------------------
-- update
-------------------------------------------------------------------------------

updateModel :: Action -> Transition Model Action

updateModel ActionAddOne = 
  modelCounter += 1

updateModel ActionSubtractOne =
  modelCounter -= 1

updateModel ActionSayHelloWorld =
  io_ $ do
    consoleLog "Hello World"
    alert "Hello World"

-------------------------------------------------------------------------------
-- view
-------------------------------------------------------------------------------

viewModel :: Model -> View Model Action
viewModel m = 
  div_ []
    [ button_ [ onClick ActionAddOne ] [ "+" ]
    , text $ ms (m ^. modelCounter)
    , button_ [ onClick ActionSubtractOne ] [ "-" ]
    , p_ [] [ button_ [ onClick ActionSayHelloWorld ] [ "Alert Hello World!" ] ]
    , p_ [] [ a_ [ href_ "https://github.com/juliendehos/miso-sample-app" ] [ "source code" ] ]
    ]

-------------------------------------------------------------------------------
-- component
-------------------------------------------------------------------------------

mkComponent :: App Model Action
mkComponent = component mkModel updateModel viewModel

