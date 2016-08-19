--TODO: Add a button to pause the clock, turning the Time subscription off


module Main exposing (..)

import Html exposing (Html)
import Html.App as Html
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        second' =
            floor model // 1000 % 60

        angle =
            -- degrees 270.0, turns 0.75
            turns (toFloat second' / 60 - 0.25)

        handX =
            toString (50 + 40 * cos angle)

        handY =
            toString (50 + 40 * sin angle)

        minute' =
            floor model // 60000 % 60

        angle' =
            turns (toFloat minute' / 60 - 0.25)

        handX' =
            toString (50 + 35 * cos angle')

        handY' =
            toString (50 + 35 * sin angle')
    in
        svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
            , line [ x1 "50", y1 "50", x2 handX', y2 handY', stroke "#0219a3" ] []
            ]
