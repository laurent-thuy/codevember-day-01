module SvgComponents exposing (canvas, line)

import VirtualDom exposing (Node)
import Update exposing (Msg(..))
import Graphics.Render exposing (solid, solidFill, rectangle, Form, polyline, Point)
import Color


canvas : Form Msg
canvas =
    rectangle 1000 1000
        |> solidFill Color.black


line : List Point -> Form Msg
line points =
    polyline points
        |> solid 1 Color.darkOrange
