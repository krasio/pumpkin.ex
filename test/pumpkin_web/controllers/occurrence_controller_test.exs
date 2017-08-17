defmodule PumpkinWeb.OccurenceControllerTest do
  use PumpkinWeb.ConnCase, async: true

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @create_attrs %{data: %{}, message: "some message", occurred_at: ~N[2010-04-17 14:00:00.000000]}
  @invalid_attrs %{data: nil, message: nil, occurred_at: nil}

  describe "create/2" do
    test "renders occurrence when data is valid", %{conn: conn} do
      conn = post(conn, occurrence_path(conn, :create), occurrence: @create_attrs)
      response =  json_response(conn, 201)

      assert %{"id" => id, "message" => _, "occurred_at" => _, "data" => _} = response

      location = occurrence_path(conn, :show, id)
      assert [location] = get_resp_header(conn, "location")
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, occurrence_path(conn, :create), occurrence: @invalid_attrs)
      response = json_response(conn, 422)

      assert response["errors"] != %{}
      assert [] = get_resp_header(conn, "location")
    end
  end
end
