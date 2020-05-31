module Hub exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Html exposing (Html, div)
import Pages.Entry as Entry
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
    | Entry Entry.Model


type Msg
    = ClickedLink UrlRequest
    | ChangedUrl Url
    | EntryMsg Entry.Msg


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let (entry, msg) = Entry.init
    in stepTo url { key = key, page = Entry entry }


view : Model -> Html Msg
view model =
    case model.page of
        Void ->
            div [] []

        Entry entry ->
            Html.map EntryMsg (Entry.view entry)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink unknown ->
            ( model, Cmd.none )

        ChangedUrl unknown ->
            ( model, Cmd.none )

        EntryMsg entryMsg ->
            case model.page of
                Entry entry ->
                    stepEntry model (Entry.update entryMsg entry)

                _ ->
                    ( model, Cmd.none )


stepEntry : Model -> ( Entry.Model, Cmd Entry.Msg ) -> ( Model, Cmd Msg )
stepEntry model ( entry, cmd ) =
    ( { model | page = Entry entry }, Cmd.map EntryMsg cmd )


titleFor : Model -> String
titleFor model =
    case model.page of
        Void ->
            "Janet?"

        Entry entry ->
            "Entry"


stepTo : Url -> Model -> ( Model, Cmd Msg )
stepTo url model =
    ( model, Cmd.none )
