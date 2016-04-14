# Swagchart

Get your swag on with this incredibly easy to use wrapper around [Googles Chart API](https://developers.google.com/chart/).

In case you haven't noticed, Swagchart is just an acronym for **S**.imple **W**.rapper **A**.round **G**.oogle **Chart**.

Swagchart is highly inspired by [Chartkick](https://github.com/ankane/chartkick) but making use of Googles new ChartWrapper class which allows a more flexible and direct interaction.

You can still create beautiful Javascript charts with one line of Ruby. In fact now you can pretty much use all the fancy chart types from [Googles Chart API](https://developers.google.com/chart/interactive/docs/gallery).

Works with Rails, Sinatra and most browsers (including IE 6).

## Usage examples

Line chart

```erb
<%= chart :line_chart, User.group_by_day(:created_at).count %>
```

Pie chart

```erb
<%= chart 'PieChart', Goal.group(:name).count %>
```

~~Keep in mind that camelize is only available with activesupport. Use the camelized chart names ... i.e. "LineChart" instead of "line_chart"~~

:thought_balloon: ... Note to self: Include more examples ...



### Data

Pass data as a Array, Hash or "DataTable"

```erb
<%= chart :pie_chart, [["Football", 10], ["Basketball", 5]] %>
```

```erb
<%= chart :pie_chart, {"Football" => 10, "Basketball" => 5} %>
```

```erb
<%= chart :pie_chart, [["Sport", "Popularity"], ["Football", 10], ["Basketball", 5]] %>
```

Multiple series just work automatically

```erb
<%= chart :line_chart, [[1,2,4],[2,3,8],[3,4,16],[4,5,32]], columns: ['x', 'Series 1', 'Series 2'] %>
```

No need to define columns if you don't want to

```erb
<%= chart :line_chart, [[1,2,4],[2,3,8],[3,4,16],[4,5,32]] %>
```

:sparkles: Now brand new: Instead of actual data you can just provide an URL from where the data will be retrieved via an Ajax Get request

```erb
<%= chart :line_chart, '/api/line-chart-data' %>
```

If you want to use times or dates, do so. They have to be a time or date object!


```erb
<%= line_chart({20.day.ago => 5, Time.at(1368174456) => 4, Time.parse("2013-05-07 00:00:00 UTC") => 7, Date.new(1999,12,24) => 9}) %>

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
