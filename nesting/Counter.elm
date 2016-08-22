module Counter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Time exposing (second)
import String exposing (padLeft)


-- Project imports

import Constants


-- MODEL


type alias Model =
    { count : Int
    , incr : Int
    , decr : Int
    }


init : Int -> Model
init count =
    Model count 0 0



-- UPDATE


type Msg
    = Increment
    | Decrement



-- | TimelyIncrement Time.Time


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            increment model 2

        Decrement ->
            decrement model 1



-- TimelyIncrement time ->
--     let
--         tick =
--             floor time % 3
--     in
--         if tick == 0 then
--             increment model 1
--         else
--             model


increment : Model -> Int -> Model
increment model delta =
    let
        count =
            Basics.min (model.count + delta) Constants.maximum
    in
        { model | count = count, incr = model.incr + 1 }


decrement : Model -> Int -> Model
decrement model delta =
    let
        count =
            Basics.max (model.count - delta) Constants.minimum
    in
        { model | count = count, decr = model.decr + 1 }



-- SUBSCRIPTIONS
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Time.every second TimelyIncrement
-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ span [] [ text (viewClick model.decr) ]
        , button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle model ] [ text (toString model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        , span [] [ text (viewClick model.incr) ]
        ]


viewClick : Int -> String
viewClick num =
    padLeft 2 '0' (toString num)


countStyle : Model -> Attribute msg
countStyle model =
    let
        color =
            if model.count == Constants.maximum then
                "#ff3300"
            else if model.count == Constants.minimum then
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
