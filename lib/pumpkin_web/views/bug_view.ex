defmodule PumpkinWeb.BugView do
  use PumpkinWeb, :view

  def started_at(dt) do
    [date, time] = split(dt)
    "Started at #{time} on #{date}"
  end

  def last_seen_at(dt) do
    [date, time] = split(dt)
    "Last seen at #{time} on #{date}"
  end

  defp split(dt) do
    time = Ecto.DateTime.cast!(dt) |> Ecto.DateTime.to_time |> Ecto.Time.to_string
    date = Ecto.DateTime.cast!(dt) |> Ecto.DateTime.to_date |> Ecto.Date.to_string
    [date, time]
  end
end
