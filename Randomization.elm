module Randomization exposing (getTurns, getPoints, seedCmd)

import Random exposing (Generator, generate, int, minInt, maxInt, step, Seed)
import Random.Extra exposing (frequency, constant)
import Directions exposing (Dir(..), Turn(..))
import Update exposing (Msg(..))
import Model exposing (Model)
import Graphics.Render exposing (Point)


-- init


seedGenerator : Generator Int
seedGenerator =
    int minInt maxInt


seedCmd : Cmd Msg
seedCmd =
    generate Seed seedGenerator



-- turn generators


turnGen : Generator Turn
turnGen =
    frequency
        [ ( 2, constant No )
        , ( 1, constant Left )
        , ( 1, constant Right )
        ]


turnListGen : Generator (List Turn)
turnListGen =
    Random.list 50 turnGen


getTurns : Seed -> List (List Turn) -> Int -> List (List Turn)
getTurns seed paths numPaths =
    case numPaths <= 0 of
        True ->
            paths

        False ->
            let
                ( turns, nextSeed ) =
                    step turnListGen seed
            in
                getTurns nextSeed (turns :: paths) (numPaths - 1)



-- points


type alias PointAcc =
    ( Point, Dir, List Point )


pointAcc : PointAcc
pointAcc =
    ( ( 0, 0 ), North, [] )


pointAccFn : Turn -> PointAcc -> PointAcc
pointAccFn dirChange accumulator =
    let
        ( point, dir, points ) =
            accumulator

        newDir : Dir
        newDir =
            getNewDir dir dirChange

        newPoint : Point
        newPoint =
            getNewPoint point newDir
    in
        ( newPoint, newDir, newPoint :: points )


getNewDir : Dir -> Turn -> Dir
getNewDir dir dirChange =
    case ( dir, dirChange ) of
        ( _, No ) ->
            dir

        ( North, Right ) ->
            East

        ( North, Left ) ->
            West

        ( South, Right ) ->
            West

        ( South, Left ) ->
            East

        ( East, Right ) ->
            South

        ( East, Left ) ->
            North

        ( West, Right ) ->
            North

        ( West, Left ) ->
            South


stepSize : Float
stepSize =
    15


getNewPoint : Point -> Dir -> Point
getNewPoint point dir =
    let
        ( x, y ) =
            point
    in
        case dir of
            North ->
                ( x, y + stepSize )

            South ->
                ( x, y - stepSize )

            East ->
                ( x + stepSize, y )

            West ->
                ( x - stepSize, y )


getPoints : List Turn -> List Point
getPoints turns =
    List.foldl pointAccFn pointAcc turns
        |> (\( _, _, points ) -> points)
