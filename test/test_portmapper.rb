require "test/unit"
require "portmapper"
require "porthelper"

class TestPortMapper < Test::Unit::TestCase

  include PortHelper

  def setup
    @p = PortMapper.new
  end

  def teardown
    reset_all
  end

  def test_portmapper_should_be_true_if_root
    u = `whoami`.chomp
    if u == 'root'
      assert @p
    else
      assert_equal @p, false
    end
  end
  
  def test_add_port
    @p.add(1231)
    assert is_open?(1231)
  end

  def test_drop_port
    @p.drop(1231)
    assert_equal is_open?(1231), false
  end

  def test_idempotency_of_add
    @p.add(4322)
    @p.add(4322)
    assert_equal how_many(4322), 1
  end

  def test_extensive_dropping
    rule('I', 54321)
    rule('I', 54321)
    rule('I', 54321)
    @p.drop(54321)
    assert_equal how_many(54321), 0
  end



end
