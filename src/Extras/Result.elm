module Extras.Result exposing (..)

fold : b -> (a -> b) -> Result e a -> b
fold dft f = Result.map f >> Result.withDefault dft