module Main exposing (..)

import Html exposing (Html, Attribute, button, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { content : String
    }


model : Model
model =
    Model ""



-- UPDATE


type Msg
    = Change String
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

        Reset ->
            { model | content = "" }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , button [ onClick Reset ] [ text "reset" ]
        , div [] [ text (String.reverse model.content) ]
        ]
