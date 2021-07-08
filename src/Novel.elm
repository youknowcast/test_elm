module Novel exposing (..)

import Array exposing (Array, fromList, get)
import Browser
import Html exposing (Html, button, div, footer, header, img, input, text, textarea)
import Html.Attributes exposing (readonly, src, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Scenario exposing (Scenario, Scene, data)


type alias Model =
    { scenario : Scenario
    , current : Maybe Scene
    , index : Int
    , quickSave : Int
    }


init : Model
init =
    { scenario = fromList data
    , current = get 0 (fromList data)
    , index = 0
    , quickSave = 0
    }


type Msg
    = GoToNext
    | GoToBack
    | Save
    | Load


update :
    Msg
    -> Model
    -> Model
update msg model =
    case msg of
        GoToNext ->
            let
                next =
                    get (model.index + 1) model.scenario
            in
            { model
                | current = next
                , index = model.index + 1
            }

        GoToBack ->
            let
                prev =
                    get (model.index - 1) model.scenario
            in
            { model
                | current = prev
                , index = model.index - 1
            }

        Save ->
            { model | quickSave = model.index }

        Load ->
            let
                next =
                    get model.quickSave model.scenario
            in
            { model
                | current = next
                , index = model.quickSave
            }


getPath : Maybe Scene -> String
getPath current =
    case current of
        Just scene ->
            scene.path

        Nothing ->
            ""


getMessage : Maybe Scene -> String
getMessage current =
    case current of
        Just scene ->
            scene.message

        Nothing ->
            ""


view :
    Model
    -> Html Msg
view model =
    div []
        [ header [] []
        , div [ style "display" "flex" ]
            [ div [ style "display" "inline-flex" ]
                [ img [ src (getPath model.current) ] [] ]
            , div [ style "display" "inline-flex" ]
                [ div []
                    [ textarea [ readonly True, value (getMessage model.current) ] []
                    ]
                ]
            ]
        , div []
            [ div [] []
            , div []
                [ button [ onClick GoToNext ] [ text "NEXT" ]
                , button [ onClick GoToBack ] [ text "BACK" ]
                , button [ onClick Save ] [ text "QS" ]
                , button [ onClick Load ] [ text "QL" ]
                ]
            ]
        , footer [] []
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
