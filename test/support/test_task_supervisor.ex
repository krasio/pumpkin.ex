defmodule Pumpkin.TestTaskSupervisor do
  def start_child(_, module, fun, args), do: apply(module, fun, args)
end
