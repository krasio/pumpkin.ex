defmodule PumpkinWeb.OccurrenceView do
  use PumpkinWeb, :view
  alias PumpkinWeb.OccurrenceView

  def render("show.json", %{occurrence: occurrence}) do
    render_one(occurrence, OccurrenceView, "occurrence.json")
  end

  def render("occurrence.json", %{occurrence: occurrence}) do
    %{
      id: occurrence.id,
      environment_id: occurrence.environment_id,
      bug_id: occurrence.bug_id,
      message: occurrence.message,
      occurred_at: occurrence.occurred_at,
      data: occurrence.data
    }
  end
end
