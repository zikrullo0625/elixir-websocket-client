defmodule WebsocketClient do
  use WebSockex

  def start_link(url) do
    WebSockex.start_link(url, __MODULE__, %{})
  end

  def send_message(pid, msg) do
    WebSockex.cast(pid, {:send, msg})
  end

  def handle_connect(_conn, state) do
    IO.puts("✅ Connected to WebSocket!")
    {:ok, state}
  end

  def handle_frame({:text, msg}, state) do
    IO.puts("💬 Received: #{msg}")
    {:ok, state}
  end

  def handle_cast({:send, msg}, state) do
    {:reply, {:text, msg}, state}
  end
end
