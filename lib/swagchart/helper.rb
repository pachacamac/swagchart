require 'json'
require 'time'
require 'erb'
require 'securerandom'

module Swagchart
  module Helper
    def default_chart_options(opts = nil)
      @default_chart_options ||= {}
      return @default_chart_options unless opts
      @default_chart_options = opts
    end

    def chart(type, data, opts = {}, &block)
      opts[:options] ||= {}
      opts[:options] = default_chart_options.merge(opts[:options])
      @google_visualization_included ||= false
      type = camelize(type.to_s)
      data = data.to_a if data.is_a?(Hash)
      if opts[:columns]
        opts[:columns] = opts[:columns].split(',').map(&:strip) if opts[:columns].is_a?(String)
        data.unshift opts[:columns]
      end
      chart_id = ERB::Util.html_escape(opts.delete(:chart_id) || "chart_#{SecureRandom.uuid}")
      style = 'height:320px;' # dirty hack right here .. you can override that with your style though
      style << ERB::Util.html_escape(opts.delete(:style)) if opts[:style]
      html = ''
      unless @google_visualization_included # we only need to include this once
        html << jsapi_includes_template
        @google_visualization_included = true
      end
      options = opts.delete(:options) || {}
      html << chart_template(id: chart_id, type: type, style: style, options: options, data: data, columns: opts[:columns])
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    private

    def camelize(str)
      str.split('_').each(&:capitalize!).join('')
    end

    def autocast_data_template(opts = {})
      js = ''
      js << 'if(Array.isArray(data) && !Array.isArray(data[0])){'
      js << 'var keys=[], vals=[], row=[]; for(var k in data[0]){keys.push(k)}; for(var d in data){row=[]; for(var k in keys){row.push(data[d][keys[k]])}; vals.push(row)}; vals.unshift(keys); data = vals;'
      js << '}'
      js << 'else{data.unshift(Array(data[0].length).join(".").split("."));}' unless opts[:columns]
      js << "for(var i=0;i<data.length;i++){for(var j=0;j<data[i].length;j++){if(typeof data[i][j] === 'string'){"
      js << 'var pd = Date.parse(data[i][j]); if(!isNaN(pd)){data[i][j] = new Date(pd)};'
      js << '}}};console.log(data);'
      js
    end

    def chart_template(opts = {})
      html = "<div id='#{opts[:id]}' style='#{opts[:style]}'>Loading...</div>"
      html << '<script type="text/javascript">'
      html << 'google.setOnLoadCallback(function(){'
      chart_js = chart_js_template(opts)
      html << (opts[:data].is_a?(String) ? async_ajax_load_wrapper(opts[:data], chart_js) : chart_js)
      html << '});</script>'
      html
    end

    def chart_js_template(opts = {})
      js = ''
      js << "var data = #{opts[:data].to_json};" unless opts[:data].is_a?(String)
      js << autocast_data_template(opts)
      js << 'var dt = google.visualization.arrayToDataTable(data);'
      js << "new google.visualization.#{opts[:type]}(document.getElementById('#{opts[:id]}')).draw(dt, #{opts[:options].to_json});"
      js
    end

    def async_ajax_load_wrapper(url, js_code)
      js = 'var xhr = new XMLHttpRequest();'
      js << 'xhr.onreadystatechange = function(){'
      js << 'if(xhr.readyState === 4) { if(xhr.status>=200 && xhr.status<400){'
      js << 'var data = JSON.parse(xhr.responseText);'
      js << js_code
      js << "}else{ console.log('Could not load data from #{url}. Status ' + xhr.status); }}};"
      js << "xhr.open('GET', '#{url}'); xhr.send(null);"
      js
    end

    def jsapi_includes_template
      html =  "<script type='text/javascript'>"
      html << "google.load('visualization', '1');"
      html << "google.load('visualization', '1', {packages: ["
      html << "'corechart', 'geochart', 'map', 'treemap', 'annotatedtimeline','sankey', 'orgchart', 'calendar', 'gauge', 'timeline'"
      html << ']});'
      html << '</script>'
      html
    end
  end
end
