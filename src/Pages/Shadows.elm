module Pages.Shadows exposing (..)

import Elements.Colors as Colors
import Elements.Inventory as Inventory exposing (Inventory)
import Elements.Navigation as Navigation
import Extras.Maybe
import Html exposing (Html, button, div, label, text)
import Html.Attributes exposing (disabled, id)
import Html.Events exposing (onClick)
import List.Extra


type alias Model =
    { inventory : Inventory
    , pressedSequence : List Button
    }


solutionSequence : List Button
solutionSequence =
    List.reverse [ F, A, D, E ]


type Button
    = A
    | B
    | C
    | D
    | E
    | F


showButton : Button -> String
showButton b =
    case b of
        A ->
            "A"

        B ->
            "B"

        C ->
            "C"

        D ->
            "D"

        E ->
            "E"

        F ->
            "F"


type Msg
    = ButtonPressed Button
    | Reload
    | Back


init : Inventory -> Model
init inventory =
    { inventory = inventory
    , pressedSequence = []
    }


navigationWiring : Navigation.Wiring Msg
navigationWiring =
    { reload = Reload
    , back = Back
    }


navigationColors : Colors.Navigation
navigationColors =
    { reload = Colors.darkGray
    , back = Colors.darkGray
    }


view : Model -> Html Msg
view model =
    let
        createButton =
            mkButton model.pressedSequence
    in
    div []
        [ Navigation.navigation navigationWiring
        , Inventory.view model.inventory
        , div [ id "shadowPuzzle" ]
            [ div [ id "shadowHint" ]
                [ label [] [ text "64222" ]
                , div [ id "shadowButtons " ]
                    [ div [ id "shadowButtonsRow1" ]
                        [ A, B, C ]
                        |> List.map createButton
                    ]
                , [ div [ id "shadowButtonsRow2" ]
                        [ D, E, F ]
                        |> List.map createButton
                  ]
                ]
            ]
        ]


isLast : a -> List a -> Bool
isLast x xs =
    Extras.Maybe.fold False ((==) x) (List.Extra.last xs)


mkButton : List Button -> Button -> Html Msg
mkButton pressed b =
    button
        [ onClick (ButtonPressed b)
        , disabled (not (isLast b pressed))
        ]
        [ label [] [ showButton b |> text ] ]
