module Counter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Time exposing (second)


-- Project imports

import Constants


-- MODEL


type alias Model =
    Int


init : Int -> Model
init count =
    count



-- UPDATE


type Msg
    = Increment
    | Decrement
    | TimelyIncrement Time.Time


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            Basics.min (model + 1) Constants.maximum

        Decrement ->
            Basics.max (model - 1) Constants.minimum

        TimelyIncrement time ->
            let
                tick =
                    floor time % 3
            in
                if tick == 0 then
                    Basics.min (model + 1) Constants.maximum
                else
                    model



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second TimelyIncrement



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle ] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


countStyle : Attribute msg
countStyle =
    style
        [ ( "font-size", "20px" )
        , ( "font-family", "monospace" )
        , ( "display", "inline-block" )
        , ( "width", "50px" )
        , ( "text-align", "center" )
        ]
