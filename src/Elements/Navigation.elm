module Elements.Navigation exposing (..)

import Elements.Colors as Colors
import Html exposing (Html, div, label)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Ionicon


type alias Wiring msg =
    { reload : msg
    , back : msg
    }


navigation : Wiring msg -> Colors.Navigation -> Int -> Html msg
navigation wiring colors size =
    div [ id "navigation" ]
        [ label [ onClick wiring.back ] [ Ionicon.arrowLeftA size colors.back ]
        , label [ onClick wiring.reload ] [ Ionicon.refresh size colors.reload ]
        ]
