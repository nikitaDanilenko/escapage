module Elements.Colors exposing (..)


type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


type alias Navigation =
    { reload : RGBA
    , back : RGBA
    }


darkGray : RGBA
darkGray =
    { red = 0.1
    , green = 0.1
    , blue = 0.1
    , alpha = 0.8
    }
