require "porthelper"

class PortMapper
  #high level object
  include PortHelper

  VERSION = "0.0.1"

  def initialize
    user = `whoami`.chomp
    unless user == 'root'
      false
    end
  end
  
  def add(prt)
    unless is_open?(prt)
      rule('I', prt)
    end
  end
  
  def drop(prt)
    how_many(prt).times do
      rule('D', prt)
    end
  end
  


end
