module Elements.Inventory exposing (..)

import Elements.Colors exposing (RGBA)
import Elements.DarkMode exposing (DarkMode(..))
import Elements.Unlockable exposing (Unlockable, unlockable)
import Html exposing (Html, button, div, label, text)
import Html.Attributes exposing (id)
import Ionicon


type alias Inventory =
    { darkMode : DarkMode
    }


updateDarkMode : Inventory -> DarkMode -> Inventory
updateDarkMode inventory darkMode =
    { inventory | darkMode = darkMode }


empty : Inventory
empty =
    { darkMode = DarkMode (unlockable "darkMode")
    }


type alias DarkModeFunctions model msg =
    { activate : model -> Cmd msg
    , deactivate : model -> Cmd msg
    }


type alias Functions model msg =
    { darkModeFunction : DarkModeFunctions model msg
    }


type alias Icon msg =
    Int -> RGBA -> Html msg


view : Inventory -> Html msg
view inventory =
    div [ id "inventory" ]
        [ label [] [ Ionicon.alert 80 { red = 1, green = 0, blue = 1, alpha = 1 } ]
        ]
