module Hub exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Html exposing (Html, div)
import Pages.Entry as Entry
import Pages.Shadows as Shadows
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
    | Shadows Shadows.Model


type Msg
    = ClickedLink UrlRequest
    | ChangedUrl Url
    | EntryMsg Entry.Msg
    | ShadowsMsg Shadows.Msg


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

        Shadows shadows ->
            Html.map ShadowsMsg (Shadows.view shadows)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let nothing = (model, Cmd.none)
    in case msg of
        ClickedLink unknown ->
            nothing

        ChangedUrl unknown ->
            nothing

        EntryMsg entryMsg ->
            case model.page of
                Entry entry ->
                    stepEntry model (Entry.update entryMsg entry)

                _ ->
                    nothing

        ShadowsMsg shadowsMsg ->
            case model.page of
                Shadows shadows ->
                    stepShadows model (Shadows.update shadowsMsg shadows)

                _ -> nothing



stepEntry : Model -> ( Entry.Model, Cmd Entry.Msg ) -> ( Model, Cmd Msg )
stepEntry = stepWith Entry EntryMsg

stepShadows : Model -> (Shadows.Model, Cmd Shadows.Msg) -> (Model, Cmd Msg)
stepShadows = stepWith Shadows ShadowsMsg

stepWith :  (page -> Page) -> (msg -> Msg) -> Model -> (page, Cmd msg) -> (Model, Cmd Msg)
stepWith mkPage mkMsg model (page, pageMsg) =
    ( { model | page = mkPage page}, Cmd.map mkMsg pageMsg)

titleFor : Model -> String
titleFor model =
    case model.page of
        Void ->
            "Janet?"

        Entry entry ->
            "Entry"

        Shadows shadows ->
            "Shadows"



stepTo : Url -> Model -> ( Model, Cmd Msg )
stepTo url model =
    ( model, Cmd.none )
