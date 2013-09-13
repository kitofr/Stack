defmodule Stack.Supervisor do
  use Supervisor.Behaviour

  def start_link(initial_stack) do
    :supervisor.start_link(__MODULE__, initial_stack)
  end

  def init(initial_stack) do
    child_processes = [ worker(Stack.Server, [initial_stack]) ]
    supervise child_processes, strategy: :one_for_one
  end
  
end

