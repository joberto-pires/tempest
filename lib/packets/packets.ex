defmodule Packets do
  @moduledoc """
  Packets:
  Estrutura de dados para o protocolo de transferencia de pacotes.
  funcoes:
   - escuta uma determinada porta.
   - recebe pacotes de um cliente e logga os dados recebidos.

  """
  require Logger

  defstruct [
    :id,
    :data
  ]
  

  def listen(port \\ 80)
  def listen(port) do
    opts = [:binary, active: false, packet: :raw, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(port, opts)
    accpet(socket)

  end

  def accpet(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info("Client connected: #{inspect(client)}")
    parse(client)
    accpet(socket)
  end

  @doc """
    Retorna os dados recebidos de um cliente.
  """
  def parse(client) do
    {:ok, data} = :gen_tcp.recv(client, 0)
    Logger.info("Data received: #{inspect(data)}")
  end
end
