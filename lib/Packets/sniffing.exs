defmodule Packets.Sniffing do

  def start() do
   Packets.open()
   |> Packets.receive()
   |> Packets.handle_cast()
  end
end
