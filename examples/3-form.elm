module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


model : Model
model =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ -- input [ type' "text", placeholder "Name", onInput Name ] []
          -- , input [ type' "password", placeholder "Password", onInput Password ] []
          -- , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
          viewInput { type' = "text", name = "Name", mesg = Name }
        , viewInput { type' = "password", name = "Password", mesg = Password }
        , viewInput { type' = "password", name = "Re-enter Password", mesg = PasswordAgain }
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if model.password == model.passwordAgain then
                ( "green", "OK" )
            else
                ( "red", "Passwords do not match!" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]



-- ViewInput


type alias ViewInput =
    { type' : String
    , name : String
    , mesg : String -> Msg
    }


viewInput : ViewInput -> Html Msg
viewInput viewInput =
    div []
        [ span [] [ text viewInput.name ]
        , input [ type' viewInput.type', placeholder viewInput.name, onInput viewInput.mesg ] []
        ]
