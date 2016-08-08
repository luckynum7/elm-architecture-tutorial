module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Regex exposing (..)


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
    , age : String
    }


model : Model
model =
    Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = age }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput { type' = "text", name = "Name", mesg = Name }
        , viewInput { type' = "password", name = "Password", mesg = Password }
        , viewInput { type' = "password", name = "Re-enter Password", mesg = PasswordAgain }
        , viewInput { type' = "text", name = "Age", mesg = Age }
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if not (contains (regex "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).{8,}$") model.password) then
                ( "orange", "Password must contains at least one lower case character, one upper case character, one digital number, with at least 8 characters." )
            else if model.password /= model.passwordAgain then
                ( "red", "Passwords do not match!" )
            else if not (contains (regex "^[1-9][0-9]{0,2}$") model.age) then
                ( "purple", "Age must be a number, and at most have three digitals" )
            else
                ( "green", "OK" )
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
