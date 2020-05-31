module Extras.Maybe exposing (..)

fold : b -> (a -> b) -> Maybe a -> b
fold dft f = Maybe.map f >> Maybe.withDefault dft