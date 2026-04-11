defmodule TCP.Packets do
  @moduledoc """
  Packets:
  Estrutura de dados para o protocolo de transferencia de pacotes.
  funcoes:
   - escuta uma determinada porta.
   - recebe pacotes de um cliente e logga os dados recebidos.

  """
  require Logger

  defstruct [
    :socket,
    :client,
    :port,
    :data
  ]
  

  defp listen(port) do
    opts = [:binary, active: false, packet: :raw, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(port, opts)
    Logger.info("Port listening: #{inspect(port)}")
    accpet(socket)

  end

  def accpet(socket) do
    Logger.info("Active socket: #{inspect(socket)}")
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info("Client connected: #{inspect(client)}")
    parse(client)
    accpet(socket)
  end

  def parse(client) do
    {:ok, data} = :gen_tcp.recv(client, 0)
    Logger.info("Data received: #{inspect(data)}")
  end
end
