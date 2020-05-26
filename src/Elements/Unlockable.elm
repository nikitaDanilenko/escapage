module Elements.Unlockable exposing (..)


type alias Unlockable element =
    { element : element
    , unlocked : Bool
    }


unlockable : element -> Unlockable element
unlockable element =
    { element = element
    , unlocked = False
    }


updateUnlocked : Unlockable element -> Bool -> Unlockable element
updateUnlocked u unlocked =
    { u | unlocked = unlocked }
