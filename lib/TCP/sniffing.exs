defmodule TCP.Sniffing do

  def start(port) do
    Packets.listen(port)
    
  end
end
