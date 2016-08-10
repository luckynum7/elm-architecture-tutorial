-- TODO: Instead of showing an image of a die face, use the elm-lang/svg library to draw it yourself.
-- TODO: After you have learned about tasks and animation, have the die flip around randomly before they settle on a final value.


module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { diceFace : Int
    , otherFace : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1 1, Cmd.none )



-- UPDATE


type Msg
    = Roll
    | NewFace ( Int, Int )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, generate NewFace (pair (int 1 6) (int 1 6)) )

        NewFace ( newFace, otherFace ) ->
            ( Model newFace otherFace, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.diceFace) ]
        , div [ toStyle model.diceFace ] []
        , h1 [] [ text (toString model.otherFace) ]
        , div [ toStyle model.otherFace ] []
        , button [ onClick Roll ] [ text "Roll" ]
        ]


toStyle : Int -> Attribute msg
toStyle face =
    -- 2,-213, -428, -643, -858, -1073 | 217 - 215 * n(1-6)
    let
        x =
            toString (217 - 215 * face)
    in
        style
            [ ( "background", "url(\"/dice.png\") " ++ x ++ "px -215px no-repeat" )
            , ( "height", "210px" )
            , ( "width", "210px" )
            ]
