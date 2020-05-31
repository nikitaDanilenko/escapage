module Elements.Navigation exposing (..)

import Elements.Colors as Colors
import Html exposing (Html, div, label)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Ionicon


type alias Wiring msg =
    { reload : Cmd msg
    , back : Cmd msg
    }


navigation : Wiring msg -> Colors.Navigation -> Html msg
navigation wiring colors =
    div [ id "navigation" ]
        [ label [ onClick wiring.reload ] [ Ionicon.refresh 10 colors.reload ]
        , label [ onClick wiring.back ] [ Ionicon.arrowLeftA 10 colors.back ]
        ]
