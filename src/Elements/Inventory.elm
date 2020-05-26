module Elements.Inventory exposing (..)

import Elements.Unlockable exposing (Unlockable, unlockable)


type alias Inventory =
    { darkMode : Unlockable String
    }


empty : Inventory
empty =
    { darkMode = unlockable "darkMode"
    }
