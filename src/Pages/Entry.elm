module Pages.Entry exposing (..)

import Elements.Inventory as Inventory exposing (Inventory)
import Html exposing (Html, div)
import Pages.Pages as Pages


type alias Model =
    { inventory : Inventory
    }


type Msg
    = ClickedPage Pages.Page


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedPage page ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div [] []


initialModel : Model
initialModel =
    { inventory = Inventory.empty
    }
