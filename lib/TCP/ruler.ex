defmodule TCP.Ruler do
 alias TCP.Ruler

 defstruct [
    :ip,
    :port,
    :dest_ip,
    :protocol,
    :action
 ]  
 
 def newRule(ip, port, dest_ip, protocol, action) do
   newrule = %Ruler{ip: ip, port: port, dest_ip: dest_ip, protocol: protocol, action: action}
   IO.write(newrule)
 end
end
