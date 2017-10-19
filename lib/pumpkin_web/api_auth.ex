defmodule PumpkinWeb.ApiAuth do
  import Plug.Conn
  @realm ~s(Basic realm="Pumpkin API")

  def init(opts), do: opts

  def call(conn, correct_auth) do
    case get_req_header(conn, "authorization") do
      [attempted_auth] -> verify(conn, attempted_auth, correct_auth)
      _                -> unauthorized(conn)
    end
  end

  defp verify(conn, attempted_auth, [token: token]) do
    case token do
      ^attempted_auth -> conn
      _               -> unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_resp_header("www-authenticate", @realm)
    |> send_resp(401, "unauthorized")
    |> halt()
  end
end
