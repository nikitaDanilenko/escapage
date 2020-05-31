module Elements.DarkMode exposing (..)

import Basics.Extra exposing (flip)
import Elements.Unlockable as Unlockable exposing (Unlockable)

type DarkMode
    = DarkMode (Unlockable String)

map : (Unlockable String -> Unlockable String) -> DarkMode -> DarkMode
map f dm = case dm of
    DarkMode unlockable -> f unlockable |> DarkMode

unlock : DarkMode -> DarkMode
unlock = map (flip Unlockable.updateUnlocked True)

isUnlocked : DarkMode -> Bool
isUnlocked dm = case dm of
    DarkMode unlockable -> unlockable.unlocked
