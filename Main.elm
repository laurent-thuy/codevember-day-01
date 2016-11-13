module Main exposing (..)

import Html.App as App
import Randomization exposing (seedCmd)
import Model exposing (Model)
import Update exposing (Msg(..), update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( { seed = 0 }, seedCmd )


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
        }
