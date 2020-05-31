module Elements.Inventory exposing (..)

import Elements.Unlockable exposing (Unlockable, unlockable)
import Html exposing (Html, button, div, label, text)
import Html.Attributes exposing (id)
import Ionicon

type alias Inventory =
    { darkMode : DarkMode
    }

type DarkMode = DarkMode (Unlockable String)

empty : Inventory
empty =
    { darkMode = DarkMode (unlockable "darkMode")
    }

type alias DarkModeFunctions model msg = {
    activate : model -> Cmd msg,
    deactivate : model -> Cmd msg
    }

type alias Functions model msg = {
    darkModeFunction : DarkModeFunctions model msg
    }

type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


type alias Icon msg =
    Int -> RGBA -> Html msg



view : Inventory -> Html msg
view inventory =
    div [ id "inventory" ]
        [ button [] [text "click?"],
          label [] [Ionicon.alert 80 {red = 1, green = 0, blue = 1, alpha = 1}]]
