module Start exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Html exposing (Html, div)
import Url exposing (Protocol(..), Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = \model -> { title = titleFor model, body = [ view model ] }
        }


type alias Model =
    { key : Nav.Key
    , page : Page
    }


type Page
    = Void


type Msg
    = ClickedLink UrlRequest
    | ChangedUrl Url


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    stepTo url { key = key, page = Void }


view : Model -> Html Msg
view model =
    case model.page of
        Void ->
            div [] []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink unknown ->
            ( model, Cmd.none )

        ChangedUrl unknown ->
            ( model, Cmd.none )


titleFor : Model -> String
titleFor model =
    case model.page of
        Void ->
            "Janet?"


stepTo : Url -> Model -> ( Model, Cmd Msg )
stepTo url model =
    ( model, Cmd.none )
