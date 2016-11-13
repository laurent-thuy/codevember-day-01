module Update exposing (Msg(..), update)

import Model exposing (Model)


type Msg
    = Seed Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Seed seed ->
            ( { model | seed = seed }, Cmd.none )
