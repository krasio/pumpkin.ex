defmodule PumpkinWeb.OccurenceControllerTest do
  use PumpkinWeb.ConnCase, async: true

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @create_attrs %{data: %{}, message: "Ooops, something went wrong!", occurred_at: ~N[2010-04-17 14:25:34.000000]}
  @invalid_attrs %{data: nil, message: nil, occurred_at: nil}

  describe "create/2" do
    test "renders occurrence when data is valid", %{conn: conn} do
      conn = post(conn, occurrence_path(conn, :create), occurrence: @create_attrs)
      response =  json_response(conn, 201)
      %{"id" => id} = response

      # Example response from the Rails app
      # {"id"=>"4e6c2d86-44b2-4194-8107-8be8376f5af3",
      # "environment_id"=>"Normal",
      # "bug_id"=>nil,
      # "occurred_at"=>"2011-01-01T00:00:00.000Z",
      # "message"=>"Extremely normal",
      # "data"=>{}}

      assert %{
        "id" => id,
        "message" => "Ooops, something went wrong!",
        "occurred_at" => "2010-04-17T14:25:34.000000",
        "data" => %{}
      } == response

      location = occurrence_path(conn, :show, id)
      assert [location] == get_resp_header(conn, "location")
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, occurrence_path(conn, :create), occurrence: @invalid_attrs)
      response = json_response(conn, 422)

      assert response["errors"] != %{}
      assert [] = get_resp_header(conn, "location")
    end
  end
end
