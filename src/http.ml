let port_with_default ?default uri =
  let default_port =
    match default with
    | None -> 80
    | Some x -> x
  in
  match Uri.port uri with
  | None -> default_port
  | Some x -> x

let dump_input input =
  let rec dump acc =
    try
      acc ^ "\r\n" ^ input_line input
      |> dump
    with End_of_file -> acc
  in
  dump ""

let send_command output str =
  output_string output (str ^ "\r\n");
  flush output

let get uri =
  let port = port_with_default ~default:80 uri
  and host = Uri.host_with_default ~default:"localhost" uri in
  let host_entry = Unix.gethostbyname host in
  let inet_addr = host_entry.Unix.h_addr_list.(0) in
  let sockaddr = Unix.(ADDR_INET (inet_addr, port)) in
  let (input, output) = Unix.open_connection sockaddr in
  "GET " ^ (Uri.path_and_query uri) |> send_command output;
  dump_input input