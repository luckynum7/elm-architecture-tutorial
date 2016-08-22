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
            increment model 2

        Decrement ->
            decrement model 1

        TimelyIncrement time ->
            let
                tick =
                    floor time % 3
            in
                if tick == 0 then
                    increment model 1
                else
                    model


increment : Model -> Int -> Model
increment num delta =
    Basics.min (num + delta) Constants.maximum


decrement : Model -> Int -> Model
decrement num delta =
    Basics.max (num - delta) Constants.minimum



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second TimelyIncrement



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle model ] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


countStyle : Model -> Attribute msg
countStyle model =
    let
        color =
            if model == Constants.maximum then
                "#ff3300"
            else if model == Constants.minimum then
                "#0033ff"
            else
                ""
    in
        style
            [ ( "font-size", "20px" )
            , ( "font-family", "monospace" )
            , ( "display", "inline-block" )
            , ( "width", "50px" )
            , ( "text-align", "center" )
            , ( "color", color )
            ]
