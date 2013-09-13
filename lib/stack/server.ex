defmodule Stack.Server do
  use GenServer.Behaviour
  
  #----------------------
  # Public
  #

  def start_link(stack) do
    :gen_server.start_link( { :local, :stack }, __MODULE__, stack, [] )
  end

  def pop do
    :gen_server.call(:stack, :pop)
  end
  
  def top do
    :gen_server.call(:stack, :top)
  end
  
  def push(thingy) do
    :gen_server.cast(:stack, { :push, thingy })
  end

  def info do
    :sys.get_status :stack
  end

  #---------------------
  # Private
  # 

  def init(stack) do
    { :ok, stack }
  end
  
  def handle_call(:pop, _from, stack) do
    [head|tail] = stack
    { :reply, head, tail } 
  end

  def handle_call(:top, _from, stack)  do
    [head|_] = stack
    { :reply, head, stack}
  end

  def handle_cast({ :push, thingy }, stack) do
    { :noreply, [thingy|stack] }
  end

  def format_status(_reson, [ _pdict, state]) do
    [ data: [{'State', "Stack is currently '#{inspect state}'"}]]
  end
end
