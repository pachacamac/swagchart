# Swagchart

[![Gem Version](https://badge.fury.io/rb/swagchart.svg)](http://badge.fury.io/rb/swagchart) ![Installs](http://img.shields.io/gem/dt/swagchart.svg)

Get your swag on with this incredibly easy to use wrapper around [Googles Chart API](https://developers.google.com/chart/).

In case you haven't noticed, Swagchart is just an acronym for **S**.imple **W**.rapper **A**.round **G**.oogle **Chart**.

Swagchart is highly inspired by [Chartkick](https://github.com/ankane/chartkick) ~~but making use of Googles new ChartWrapper class which allows a more flexible and direct interaction.~~ (the code is still in there and you can enable it if you want to .. look at lib/swagchart/helper.rb .. but unfortunately ChartWrapper doesn't allow many charts so I switched back to the classic approach by default).

You can still create beautiful Javascript charts with one line of Ruby. In fact now you can pretty much use all the fancy chart types from [Googles Chart API](https://developers.google.com/chart/interactive/docs/gallery).

Works with Rails, Sinatra and most browsers (including IE 6).

## Usage examples

```ruby
chart :line_chart, [{y: 23, x: 42}, {y: 666, x: 999}]
chart :line_chart, [[23, 42], [666, 999]], columns: ['x', 'y']
chart :line_chart, [[23, 42], [666, 999]], columns: ['x', 'y'], style: 'width:100%;'
chart :line_chart, [[1,2,4],[2,3,8],[3,4,16],[4,5,32]]
chart :line_chart, User.group_by_day(:created_at).count
chart :bar_chart, [['x', 'y'],[23, 42], [666, 999]]
chart :pie_chart, Goal.group(:name).count
chart :geo_map, [{'Country'=>'Germany', 'Population'=>8600000}, {'Country'=>'France', 'Population'=>6500000}]
chart :line_chart,
      [[0, nil, nil, 5], [1, 'foo', 'Foobar', 2], [2, nil, nil, 6], [3, 'bar', 'Barfoo', 3], [4, nil, nil, 8]],
      columns: ['y', {type: 'string', role: 'annotation'}, {type: 'string', role: 'annotationText'}, 'foo'],
      options: {annotations: {style: 'line'}}
chart :pie_chart, '/api/pie-chart-data'

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "swagchart"
```

And add the javascript files to your views.  These files must be included **before** the helper methods.


```erb
<script type="text/javascript" src="//www.google.com/jsapi"></script>
```


## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- Report bugs
- Fix bugs and submit pull requests
- Write, clarify, or fix documentation
- Suggest or add new features
