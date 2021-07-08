module Scenario exposing (..)

import Array exposing (Array)


type alias Scene =
    { path : String
    , message : String
    }


type alias Scenario =
    Array Scene


data : List Scene
data =
    [ { path = "./static/pet_omocha_inu.png", message = "いぬがいました" }
    , { path = "./static/animal_smile_inu.png", message = "わん" }
    , { path = "./static/pet_omocha_inu.png", message = "いきなり ほえました" }
    , { path = "./static/animal_smile_inu.png", message = "わん" }
    , { path = "./static/pet_omocha_inu.png", message = "もう いっかい ほえました" }
    , { path = "./static/building_hokenjo.png", message = "いぬは うられてしまいました" }
    , { path = "./static/gekijou_end_oshimai.png", message = "" }
    ]
