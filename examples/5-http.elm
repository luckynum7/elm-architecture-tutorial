-- TODO: Allow the user to modify the topic with a drop down menu

module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task


main =
    Html.program
        { init = init "cats"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    , error : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic "/waiting.gif" ""
    , getRandomGif topic
    )



-- UPDATE


type Msg
    = MorePlease
    | Topic String
    | FetchSucceed String
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        Topic topic ->
            ( { model | topic = topic }, Cmd.none )

        FetchSucceed newUrl ->
            ( Model model.topic newUrl "", Cmd.none )

        FetchFail httpError ->
            ( { model | error = explainError httpError }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , input [ type' "text", value model.topic, onInput Topic ] []
        , button [ onClick MorePlease ] [ text "More Please!" ]
        , br [] []
        , img [ src model.gifUrl ] []
        , div [] [ text model.error ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https//api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&rating=pg&tag=" ++ topic
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
    Json.at [ "data", "fixed_height_downsampled_url" ] Json.string



-- ExplainError


explainError : Http.Error -> String
explainError httpError =
    case httpError of
        Http.Timeout ->
            "Timeout!"

        Http.NetworkError ->
            "NetworkError!"

        Http.UnexpectedPayload payload ->
            "UnexpectedPayload!" ++ payload

        Http.BadResponse code message ->
            "BadResponse!" ++ toString code ++ ":" ++ message
