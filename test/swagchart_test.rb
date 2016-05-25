require 'test_helper'
require 'time'

class TestSwagchart < Minitest::Test
  include Swagchart::Helper

  def test_no_random_exceptions
    assert chart(:line_chart, [{y: 23, x: 42}, {y: 666, x: 999}])
    assert chart(:line_chart, [[23, 42], [666, 999]], columns: ['x', 'y'])
    assert chart(:line_chart, [[23, 42], [666, 999]], columns: ['x', 'y'], style: 'width:100%;')
    assert chart(:bar_chart, [['x', 'y'],[23, 42], [666, 999]])
    assert chart('GeoMap', [{'Country'=>'Germany', 'Population'=>8600000}, {'Country'=>'France', 'Population'=>6500000}])
  end

  # def test_annotations
  #   c = chart(
  #     :line_chart,
  #     [[0, nil, nil, 5], [1, 'foo', 'Foobar', 2], [2, nil, nil, 6], [3, 'bar', 'Barfoo', 3], [4, nil, nil, 8]],
  #     #[{y: 0, x: 5}, {y: 1, x: 2}, {y: 2, x: 6}, {y: 3, x: 3}, {y: 4, x: 8}],
  #     columns: ['y', {type: 'string', role: 'annotation'}, {type: 'string', role: 'annotationText'}, 'foo'],
  #     options: {annotations: {style: 'line'}}
  #   )
  #   c = "<script type='text/javascript' src='http://www.google.com/jsapi'></script>\n#{c}"
  #   File.write('/tmp/chart.html', c)
  #   `see /tmp/chart.html`
  # end

  # def test_normal_chart
  #   c = chart(
  #     :line_chart,
  #     [{y: 1, x: 2},{y: 2, x: 7},{y: 3, x: 4}],
  #   )
  #   c = "<script type='text/javascript' src='http://www.google.com/jsapi'></script>\n#{c}"
  #   File.write('/tmp/chart.html', c)
  #   `see /tmp/chart.html`
  # end

  # not relevant anymore since it's parsed in JS

  # def test_time_object_literals
  #   t = Time.parse('2014-12-24 13:37:04')
  #   raw_chart = chart(:line_chart, [[t, 42], [t+3600, 999]], columns: ['x', 'y'])
  #   assert raw_chart.include?('new Date(2014,11,24,13,37,4)') #month starts at 0 in js
  #   assert raw_chart.include?('new Date(2014,11,24,14,37,4)')
  # end

  # def test_date_object_literals
  #   d1, d2 = Date.new(2014, 12, 24), Date.new(2014, 12, 31)
  #   raw_chart = chart(:line_chart, [[d1, 42], [d2, 999]], columns: ['x', 'y'])
  #   assert raw_chart.include?('new Date(2014,11,24)')
  #   assert raw_chart.include?('new Date(2014,11,31)')
  # end

  # def test_datetime_object_literals
  #   dt = Time.parse('2014-12-24 13:37:04').to_datetime
  #   raw_chart = chart(:line_chart, [[dt, 42]], columns: ['x', 'y'])
  #   assert raw_chart.include?('new Date(2014,11,24,13,37,4)')
  # end

  # def test_chart_output
  #   puts chart('GeoMap', [{'Country'=>'Germany', 'Population'=>8600000}, {'Country'=>'France', 'Population'=>6500000}], columns: ['x', 'y'], :hAxis => {title: 'Year'}, style:'width:100%;')
  #   puts chart(:line_chart, [[23, 42], [666, 999]], columns: ['x', 'y'])
  # end

end
