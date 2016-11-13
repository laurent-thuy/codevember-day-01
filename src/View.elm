module View exposing (view)

import Model exposing (Model)
import VirtualDom exposing (Node)
import Update exposing (Msg(..), update)
import Graphics.Render exposing (group, svg, Form, Point)
import SvgComponents exposing (canvas, line)
import Randomization exposing (getPoints, getTurns)
import Random exposing (Seed)
import Time
import Directions exposing (Turn)


view : Model -> Node Msg
view model =
    canvas
        :: makeLines model.seed
        |> group
        |> svg 1000 1000


makeLine : List Turn -> Form Msg
makeLine turns =
    turns
        |> getPoints
        |> line


makeLines : Int -> List (Form Msg)
makeLines seed =
    getTurns (Random.initialSeed seed) [] 50
        |> List.map makeLine
