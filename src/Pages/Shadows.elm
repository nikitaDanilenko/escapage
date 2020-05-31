module Pages.Shadows exposing (..)

import Elements.Colors as Colors
import Elements.DarkMode as DarkMode
import Elements.Inventory as Inventory exposing (Inventory)
import Elements.Navigation as Navigation
import Extras.Result
import Hex
import Html exposing (Html, button, div, label, text)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Ionicon


type alias Model =
    { inventory : Inventory
    , pressedSequence : List Button
    }


updatePressedSequence : Model -> List Button -> Model
updatePressedSequence model pressedSequence =
    { model | pressedSequence = pressedSequence }


updateInventory : Model -> Inventory -> Model
updateInventory model inventory =
    { model | inventory = inventory }


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
        unsolved =
            div []
                [ Navigation.navigation navigationWiring navigationColors 80
                , Inventory.view model.inventory
                , div [ id "shadowPuzzle" ]
                    [ div [ id "shadowHint" ]
                        (computedInput solutionSequence ++
                         [ div [ id "shadowButtons " ]
                            [ div [ id "shadowButtonsRow1" ]
                                ([ A, B, C ]
                                    |> List.map mkButton
                                )
                            , div [ id "shadowButtonsRow2" ]
                                ([ D, E, F ]
                                    |> List.map mkButton
                                )
                            ]
                         ]
                            ++ computedInput model.pressedSequence
                        )
                    ]
                ]

        solved =
            div [] [ label [] [ Ionicon.checkmarkCircled 500 Colors.darkGray ] ]
    in
    if DarkMode.isUnlocked model.inventory.darkMode then
        solved

    else
        unsolved


computedInput : List Button -> List (Html Msg)
computedInput bs =
    let
        output =
            bs |> List.map showButton |> String.join "" |> String.toLower |> Hex.fromString |> Extras.Result.fold "" String.fromInt
    in
    if String.isEmpty output then
        []

    else
        [ label [] [ text output ] ]


solutionSequence : List Button
solutionSequence =
    [ F, A, D, E ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonPressed button ->
            let
                newSequence =
                    model.pressedSequence |> (\xs -> xs ++ [ button ])

                newModel =
                    if newSequence == solutionSequence then
                        DarkMode.unlock model.inventory.darkMode |> Inventory.updateDarkMode model.inventory |> updateInventory model

                    else
                        updatePressedSequence model newSequence
            in
            ( newModel, Cmd.none )

        Reload ->
            ( updatePressedSequence model [], Cmd.none )

        Back ->
            ( model, Cmd.none )


mkButton : Button -> Html Msg
mkButton b =
    button
        [ onClick (ButtonPressed b) ]
        [ label [] [ showButton b |> text ] ]
