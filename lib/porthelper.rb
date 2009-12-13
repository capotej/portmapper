module PortHelper
  #low level iptables interface
  def port_list
    ports = `iptables -L INPUT -vn`.map do |x|
      x.split(':').last.chomp.gsub(' ','').to_i
    end
  end

  def is_open?(prt)
    ports = port_list
    if ports.include?(prt)
      true
    else
      false
    end
  end

  def how_many(prt)
    port_list.select { |x| x == prt }.size
  end

  def rule(action, prt)
    `iptables -#{action} INPUT -p tcp --dport #{prt.to_i} -j ACCEPT`
  end

  def reset_all
    `iptables -F`
  end
 
end
