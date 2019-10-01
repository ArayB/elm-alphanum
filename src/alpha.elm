module Main exposing (Model, Msg(..), init, main, update, view, viewInput)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { input : String
    , output : String
    , offset : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Input String
    | Offset String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }
                |> updateOutput

        Offset offset ->
            { model | offset = offset }
                |> updateOutput


updateOutput : Model -> Model
updateOutput model =
    let
        output =
            model.input
                |> String.split ","
                |> List.map (\x -> numberToLetter x model.offset)
                |> String.join ""
    in
    { model | output = output }


numberToLetter : String -> String -> String
numberToLetter numberString offset =
    let
        alphaList =
            [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" ]

        offsetVal =
            case String.toInt offset of
                Just val ->
                    val

                Nothing ->
                    0

        shiftedList =
            shiftList offsetVal alphaList

        alpha =
            Array.fromList shiftedList

        num =
            String.toInt (String.trim numberString)
    in
    case num of
        Just val ->
            case Array.get (val - 1) alpha of
                Just letter ->
                    letter

                Nothing ->
                    numberString

        Nothing ->
            numberString


shiftList offset list =
    let
        shiftedList =
            case offset > 0 of
                True ->
                    leftShiftList offset list

                False ->
                    rightShiftList offset list
    in
    shiftedList


rightShiftList offset list =
    case offset == 0 of
        True ->
            list

        False ->
            let
                head =
                    List.reverse list |> List.take 1

                tail =
                    List.reverse list |> List.drop 1

                shifted =
                    List.reverse (tail ++ head)

                newOffset =
                    offset + 1
            in
            rightShiftList newOffset shifted


leftShiftList offset list =
    case offset == 0 of
        True ->
            list

        False ->
            let
                head =
                    List.take 1 list

                tail =
                    List.drop 1 list

                shifted =
                    tail ++ head

                newOffset =
                    offset - 1
            in
            leftShiftList newOffset shifted



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h1 [] [ text "Number to Alpha converter" ] ]
        , div [] [ text "Input comma separated numbers to convert" ]
        , input [ placeholder "1,2,3", value model.input, onInput Input ] []
        , div [] [ text "Offset the conversion (e.g. offsetting by 1 would have an input of '1' become 'b' instead of 'a' )" ]
        , input [ placeholder "0", value model.offset, onInput Offset ] []
        , div [] [ text "Output string:" ]
        , div [] [ text model.output ]
        ]
