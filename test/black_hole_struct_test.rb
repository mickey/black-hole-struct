require File.expand_path('../../lib/black_hole_struct', __FILE__)
require 'minitest/autorun'

class BlackHoleStructTest < Minitest::Test
  def setup
    @subject = BlackHoleStruct.new
  end

  def test_instanciate_without_arguments
    assert_instance_of BlackHoleStruct, @subject
  end

  def test_accessor
    @subject.theme = "white"
    assert_equal @subject.theme, "white"
    assert_equal @subject[:theme], "white"

    @subject[:theme] = "black"
    assert_equal @subject.theme, "black"
    assert_equal @subject[:theme], "black"
  end

  def test_missing_values
    assert_instance_of BlackHoleStruct, @subject.missing
  end

  def test_nested_accessor
    @subject.dashboard.theme = "white"
    assert_equal @subject.dashboard.theme, "white"
    assert_equal @subject[:dashboard][:theme], "white"

    @subject[:dashboards][:theme] = "black"
    assert_equal @subject.dashboards.theme, "black"
    assert_equal @subject[:dashboards][:theme], "black"
  end

  def test_equality
    @subject.dashboard.theme = "white"
    other = BlackHoleStruct.new
    other.dashboard.theme = "white"
    assert_equal @subject, other
    assert_equal @subject.eql?(other), true
  end

  def test_instanciate_with_arguments
    assert_raises ArgumentError do
      BlackHoleStruct.new(Array.new)
    end

    subject = BlackHoleStruct.new(theme: "white")
    assert_equal subject.theme, "white"

    subject = BlackHoleStruct.new(dashboard: {theme: "white"})
    assert_equal subject.dashboard.theme, "white"
  end

  def test_delete_field
    @subject.theme = "white"
    @subject.delete_field(:theme)
    assert_equal @subject.theme, BlackHoleStruct.new

    @subject.dashboard.theme = "white"
    @subject.delete_field(:dashboard)
    assert_equal @subject.dashboard, BlackHoleStruct.new
    assert_equal @subject.dashboard.theme, BlackHoleStruct.new

    assert_equal @subject.delete_field(:missing), BlackHoleStruct.new
  end

  def test_each_pair
    assert_kind_of Enumerator, @subject.each_pair

    @subject.theme = "white"
    assert_equal @subject.each_pair.to_a, [[:theme, "white"]]

    @subject.each_pair do |key, value|
      assert_equal key, :theme
      assert_equal value, "white"
    end
  end

  def test_to_h
    @subject.dashboard.theme = "white"
    @subject.host = "127.0.0.1"

    assert_equal @subject.to_h, {
      dashboard: {theme: "white"},
      host: "127.0.0.1"
    }
  end

  def test_merge
    @subject.theme = "white"
    @subject.merge!(size: 5)

    assert_equal @subject.to_h, {
      theme: "white", size: 5
    }
  end

  def test_inspect
    assert_equal @subject.inspect, '#<BlackHoleStruct>'
    @subject.theme = "white"
    assert_equal @subject.inspect, '#<BlackHoleStruct :theme="white">'
  end
end
