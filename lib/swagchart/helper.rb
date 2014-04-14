require 'json'
require 'time'
require 'erb'

module Swagchart
  module Helper

    def chart(type, data, opts={}, &block)
      @google_visualization_included ||= false
      @chart_counter ||= 0
      type = type.to_s
      type = type.camelize if type.respond_to?(:camelize)
      opts[:columns] = opts[:columns].split(',').map(&:strip) if opts[:columns].is_a?(String)
      data = data.to_a if data.is_a?(Hash)
      if data.respond_to?(:first) && data.first.is_a?(Hash)
        data = hash_array_to_data_table(data)
        opts.delete(:columns)
      elsif data.respond_to?(:unshift) && data.respond_to?(:first)
        if opts[:columns]
          data.unshift opts.delete(:columns)
        elsif !data.first.find{|e| !e.is_a?(String) && !e.is_a?(Symbol) }
          # Do nothing! This should already be in a DataTable format.
          # First row seems to only define column names.
        else
          data.unshift Array.new(data.first.size, '')
        end
      end
      opts.delete(:columns)
      chart_id = ERB::Util.html_escape(opts.delete(:chart_id) || "chart_#{@chart_counter += 1}")
      style = 'height:300px;' #dirty hack right here .. you can override that with your style though
      style << ERB::Util.html_escape(opts.delete(:style)) if opts[:style]
      html = ''
      unless @google_visualization_included #we only need to include this once
        html << jsapi_includes_template
        @google_visualization_included = true
      end
      html << classic_template(id: chart_id, type: type, style: style, options: opts, data: data)
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    private

    def hash_array_to_data_table(ha)
      cols = ha.first.keys
      rows = ha.map{|r| cols.reduce([]){|s,e| s<<r[e]} }
      [cols, *rows]
    end

    # This finds and replaces some string representations of
    # Ruby objects to their JavaScript equivalents.
    # Yes it's dirty and using Ruby 2.x refinements to replace the
    # to_s methods of those objects only in this module would
    # be simply awesome, but refinements dont work in Ruby 1.x.
    # TODO: Check if refinements are available and do either the
    #       right or the dirty thing.
    def ruby_to_js_conversions(str)
      str.to_s.gsub(/["'](\d\d\d\d-\d\d-\d\d.*?)["']/){"new Date(Date.parse('#{$1}'))"}
      #drx = /#<Date: (\d\d\d\d)-(\d\d)-(\d\d).*?>/
      #dtrx= /#<DateTime: (\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d):(\d\d)\+\d\d:\d\d .*?>/
      #trx = /(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d) \+\d\d\d\d/
      #blk = ->(s){v=$~.captures.map(&:to_i); v[1]-=1; "new Date(#{v.join(',')})"}
      #str.to_s.gsub(dtrx, &blk).gsub(drx, &blk).gsub(trx, &blk)
    end

    def classic_template(opts={})
<<HTML
<div id='#{opts[:id]}' style='#{opts[:style]}'>Loading...</div>
<script type='text/javascript'>
google.setOnLoadCallback(function(){
  new google.visualization.#{opts[:type]}(document.getElementById('#{opts[:id]}')).draw(
    google.visualization.arrayToDataTable(
      #{ruby_to_js_conversions(opts[:data])}
    ), #{opts[:options].to_json});
});
</script>
HTML
    end

    def chartwrapper_template(opts={})
<<HTML
<div id='#{opts[:id]}' style='#{opts[:style]}'>Loading...</div>
<script type='text/javascript'>
  google.setOnLoadCallback(function(){
    new google.visualization.ChartWrapper({
      chartType: '#{opts[:type]}',
      containerId: '#{opts[:id]}',
      options: #{opts[:options].to_json},
      dataTable: #{ruby_to_js_conversions(opts[:data])}
    }).draw();
  });
</script>
HTML
    end

    def jsapi_includes_template
<<HTML
<script type='text/javascript'>
  google.load('visualization','1');
  google.load('visualization', '1', {packages: [
    'corechart','geomap', 'geochart', 'map', 'treemap', 'annotatedtimeline',
    'sankey', 'orgchart', 'calendar', 'gauge'
  ]});
</script>
HTML
    end
  end
end
