let () =
  let response =
    "http://api.openweathermap.org/data/2.5/weather?q=Paris,fr"
    |> Uri.of_string 
    |> Http.get in
  print_endline response
