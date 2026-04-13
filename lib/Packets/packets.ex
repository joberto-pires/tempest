defmodule Packets do
  @moduledoc """
  Packets:
  Estrutura de dados para o protocolo de transferencia de pacotes.
  funcoes:
   - escuta uma determinada porta.
   - recebe pacotes de um cliente e logga os dados recebidos.

  """
  require Logger
  use GenServer

  defstruct [
    :socket,
    :client,
    :port,
    :data
  ]

  def open() do
    domain = 17
    protocol = 0x0003
    <<protocol_host::big-unsigned-integer-size(16)>> = <<protocol::native-unsigned-integer-size(16)>>
    {:ok, socket} = :socket.open(domain, :raw, protocol_host)
    socket
  end

  def receive(socket) do
    case :socket.recvfrom(socket, 1500, :nowait) do
      {:ok, {source, data}} -> 
        GenServer.cast(self(), {:socket_data, source, data})

      {:select, _select_info} ->
        :ok
      {:error, reason} ->
        GenServer.cast(self(), {:socket_error, reason})

    end
  end

  def handle_cast({:socket_data, source, data}, socket) do
    IO.puts("We have a new packet from #{source}")
    Packets.receive(socket)
    {:noreply, socket}
  end

  def handle_cast({:socket_error, reason}, socket) do
    IO.inspect(reason, "something went wrong")
    {:noreply, socket}
  end

  def handle_info({:"$socket", socket, :select, _select_handle}, socket) do
   IO.puts("new data is availiable") 
   Packets.receive(socket)
   {:noreply, socket}
  end

end
