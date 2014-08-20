open Core.Std
open Async.Std

let query_uri query =
  let base_uri =
    Uri.of_string "http://api.openweathermap.org/data/2.5/weather" in
  Uri.add_query_param base_uri ("q", [query])

let get_weather place =
  Cohttp_async.Client.get (query_uri place)
  >>= fun (_, body) ->
  body |> Cohttp_async.Body.to_pipe |> Pipe.to_list 
  >>| fun strings ->
  (place, String.concat strings |> Response_j.response_of_string)

let print_weather weather =
  let print = List.iter ~f:print_endline in
  match weather.Response_j.weather_main with
  | "Clouds" -> print Art.cloudy
  | "Clear" -> print Art.sunny
  | "Rain" -> print Art.rainy
  | "Fog" -> print Art.foggy
  | str -> print_endline str

let print_weather_response response =
  match response.Response_j.weather with
  | [] -> invalid_arg "expected non empty weather list"
  | head :: _ ->
    print_endline response.Response_j.name;
    print_weather head

let () =
  Command.async_basic
    ~summary:"Retrieve weather from openweathermap.org."
    Command.Spec.(
      empty
      +> anon (sequence ("place" %: string))
    )
  (fun place_list () ->
    Deferred.all_unit (List.map place_list ~f:(fun place ->
      get_weather place >>| fun (_, response) ->
        print_weather_response response)))
  |> Command.run
