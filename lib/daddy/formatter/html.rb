# coding: UTF-8

require 'erb'
require 'cucumber/formatter/ordered_xml_markup'
require 'cucumber/formatter/duration'
require 'cucumber/formatter/io'
require 'daddy/formatter/daddy_html'
require 'daddy/utils/string_utils'

module Daddy
  module Formatter
    class Html
      include ERB::Util # for the #h method
      include ::Cucumber::Formatter::Duration
      include ::Cucumber::Formatter::Io
      include Daddy::Formatter::DaddyHtml

      def initialize(runtime, path_or_io, options)
        @io = ensure_io(path_or_io, "html")
        @runtime = runtime
        @options = options
        @buffer = {}
        @builder = create_builder(@io)
        @feature_number = 0
        @scenario_number = 0
        @step_number = 0
        @header_red = nil
        @delayed_messages = []
        @img_id = 0
        @inside_outline = false
      end

      def before_features(features)
        @step_count = features.step_count

        @builder.declare!(:DOCTYPE, :html)

        @builder << '<html>'
          @builder.head do
          @builder.meta('http-equiv' => 'Content-Type', :content => 'text/html;charset=utf-8')
          @builder.title title
          inline_css
          inline_js
        end
        @builder << '<body>'
        @builder << "<!-- Step count #{@step_count}-->"
        @builder << '<div class="cucumber">'
        @builder.div(:id => 'cucumber-header') do
          @builder.div(:id => 'label') do
            @builder.h1(title)
          end
          @builder.div(:id => 'summary') do
            @builder.p('',:id => 'totals')
            @builder.p('',:id => 'duration')
            @builder.div(:id => 'expand-collapse') do
              @builder.p('すべて開く', :id => 'expander')
              @builder.p('すべて閉じる', :id => 'collapser')
            end
          end
        end
        
        before_menu
      end

      def after_features(features)
        after_menu
        print_stats(features)
        @builder << '</div>'
        @builder << '</body>'
        @builder << '</html>'
      end

      def before_feature(feature)
        dir = feature_dir(feature)
        unless dir.empty?
          if @feature_dir != dir
            @builder << '<div class="feature_dir"><span class="val" onclick="toggle_feature_dir(this);">'
            @builder << dir
            @builder << '</span></div>'
          end

          @feature_dir = dir
        end

        @feature = feature
        @exceptions = []
        @builder << "<div id=\"#{feature_id}\" class=\"feature\">"
      end

      def after_feature(feature)
        @builder << '</div>'
      end

      def before_comment(comment)
        return if comment == '# language: ja'
        @builder << '<pre class="comment">'
      end

      def after_comment(comment)
        return if comment == '# language: ja'
        @builder << '</pre>'
      end

      def comment_line(comment_line)
        return if comment_line == '# language: ja'
        @builder.text!(comment_line)
        @builder.br
      end

      def after_tags(tags)
        @tag_spacer = nil
      end

      def tag_name(tag_name)
        @builder.text!(@tag_spacer) if @tag_spacer
        @tag_spacer = ' '
        @builder.span(tag_name, :class => 'tag')
      end

      def feature_name(keyword, name)
        title = feature_dir(@feature, true) + @feature.file.split('/').last.gsub(/\.feature/, '')

        @builder.h2 do |h2|
          @builder.span(title, :class => 'val')
        end

        lines = name.split(/\r?\n/)
        if lines.size > 1
          @builder.p(:class => 'narrative') do
            lines[1..-1].each do |line|
              @builder.text!(line.strip)
              @builder.br
            end
          end
        end
      end

      def before_background(background)
        @in_background = true
        @builder << '<div class="background">'
      end

      def after_background(background)
        @in_background = nil
        @builder << '</div>'
      end

      def background_name(keyword, name, file_colon_line, source_indent)
        @listing_background = true
        @builder.h3(:id => scenario_id) do |h3|
          @builder.span(keyword, :class => 'keyword')
          @builder.text!(' ')
          @builder.span(name, :class => 'val')
        end
      end

      def before_feature_element(feature_element)
        @scenario_number+=1
        @scenario_red = false
        css_class = {
          ::Cucumber::Ast::Scenario        => 'scenario',
          ::Cucumber::Ast::ScenarioOutline => 'scenario outline'
        }[feature_element.class]
        @builder << "<div class='#{css_class}'>"
      end

      def after_feature_element(feature_element)
        @builder << '</div>'
        @open_step_list = true
      end

      def scenario_name(keyword, name, file_colon_line, source_indent)
        @step_number_in_scenario = 0

        @builder.span(:class => 'scenario_file', :style => 'display: none;') do
          @builder << file_colon_line
        end
        @listing_background = false

        lines = name.split("\n")
        @builder.h3(:id => scenario_id) do
          @builder.span(lines[0], :class => 'val')
        end
        
        if lines.size > 1
          @builder.div(:class => 'narrative', :style => 'display: none;') do
            @builder.pre do
              text = ''
              lines[1..-1].each_with_index do |line, i|
                next if i == 0 and line.strip.empty?
                text << '<br/>' unless text.empty?
                text << line
              end
              @builder << text
            end
          end
        end
      end

      def before_outline_table(outline_table)
        @inside_outline = true
        @outline_row = 0
        @builder << '<table>'
      end

      def after_outline_table(outline_table)
        @builder << '</table>'
        @outline_row = nil
        @inside_outline = false
      end

      def before_examples(examples)
         @builder << '<div class="examples">'
      end

      def after_examples(examples)
        @builder << '</div>'
      end

      def examples_name(keyword, name)
        @builder.h4 do
          @builder.span(keyword, :class => 'keyword')
          @builder.text!(' ')
          @builder.span(name, :class => 'val')
        end
      end

      def before_steps(steps)
        @builder << '<ol style="display: none;">'
      end

      def after_steps(steps)
        @builder << '</ol>'
      end

      def before_step(step)
        @step_id = step.dom_id + '_' + Daddy::Utils::StringUtils.current_time
        @step_number += 1
        @step = step
      end

      def after_step(step)
        move_progress
      end

      def before_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)
        @step_match = step_match
        @hide_this_step = false
        if exception
          if @exceptions.include?(exception)
            @hide_this_step = true
            return
          end
          @exceptions << exception
        end
        if status != :failed && @in_background ^ background
          @hide_this_step = true
          return
        end
        @status = status
        return if @hide_this_step
        set_scenario_color(status)

        if ! @delayed_messages.empty? and status == :passed
          @builder << "<li id='#{@step_id}' class='step #{status} expand'>"
        else
          @builder << "<li id='#{@step_id}' class='step #{status}'>"
        end
      end

      def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)
        return if @hide_this_step
        # print snippet for undefined steps
        if status == :undefined
          keyword = @step.actual_keyword if @step.respond_to?(:actual_keyword)
          step_multiline_class = @step.multiline_arg ? @step.multiline_arg.class : nil
          @builder.pre do |pre|
            pre << @runtime.snippet_text(keyword,step_match.instance_variable_get("@name") || '',step_multiline_class)
          end
        end
        @builder << '</li>'

        unless status == :undefined
          step_file = step_match.file_colon_line
          step_contents = "<div class=\"step_contents\"><pre>"
          step_file.gsub(/^([^:]*\.rb):(\d*)/) do
            line_index = $2.to_i - 1

            file = $1.force_encoding('UTF-8')
            if file.start_with?('daddy-') or file.start_with?('/daddy-')
              file = '/usr/local/lib/ruby/gems/1.9.1/gems/' + file
            end

            File.readlines(File.expand_path(file))[line_index..-1].each do |line|
              step_contents << line
              break if line.chop == 'end' or line.chop.start_with?('end ')
            end
          end
          step_contents << "</pre></div>"
          @builder << step_contents.force_encoding('UTF-8')
        end

        print_messages
      end

      def step_name(keyword, step_match, status, source_indent, background, file_colon_line)
        background_in_scenario = background && !@listing_background
        @skip_step = background_in_scenario

        unless @skip_step
          build_step(keyword, step_match, status)
        end
      end

      def exception(exception, status)
        return if @hide_this_step
        build_exception_detail(exception)
      end

      def extra_failure_content(file_colon_line)
        @snippet_extractor ||= SnippetExtractor.new
        "<pre class=\"ruby\"><code>#{@snippet_extractor.snippet(file_colon_line)}</code></pre>"
      end

      def before_multiline_arg(multiline_arg)
        return if @hide_this_step || @skip_step
        if ::Cucumber::Ast::Table === multiline_arg
          @builder << '<table>'
        end
      end

      def after_multiline_arg(multiline_arg)
        return if @hide_this_step || @skip_step
        if ::Cucumber::Ast::Table === multiline_arg
          @builder << '</table>'
        end
      end

      def doc_string(string)
        return if @hide_this_step
        @builder.pre(:class => 'val') do |pre|
          @builder << string
        end
      end


      def before_table_row(table_row)
        @row_id = table_row.dom_id
        @col_index = 0
        return if @hide_this_step
        @builder << "<tr class='step' id='#{@row_id}'>"
      end

      def after_table_row(table_row)
        return if @hide_this_step
        print_table_row_messages
        @builder << '</tr>'
        if table_row.exception
          @builder.tr do
            @builder.td(:colspan => @col_index.to_s, :class => 'failed') do
              @builder.pre do |pre|
                pre << h(format_exception(table_row.exception))
              end
            end
          end
          if table_row.exception.is_a? ::Cucumber::Pending
            set_scenario_color_pending
          else
            set_scenario_color_failed
          end
        end
        if @outline_row
          @outline_row += 1
        end
        @step_number += 1
        move_progress
      end

      def table_cell_value(value, status)
        return if @hide_this_step

        @cell_type = @outline_row == 0 ? :th : :td
        attributes = {:id => "#{@row_id}_#{@col_index}", :class => 'step'}
        attributes[:class] += " #{status}" if status
        build_cell(@cell_type, value, attributes)
        set_scenario_color(status) if @inside_outline
        @col_index += 1
      end

      def puts(message)
        @delayed_messages << message
        #@builder.pre(message, :class => 'message')
      end

      def print_messages
        return if @delayed_messages.empty?

        #@builder.ol do
          @delayed_messages.each_with_index do |ann, i|
            @builder.li(:class => 'message', :style => 'display: none;') do
              @builder << ann
            end
          end
        #end
        empty_messages
      end

      def print_table_row_messages
      end

      def empty_messages
        @delayed_messages = []
      end

      protected

      def build_exception_detail(exception)
        backtrace = Array.new
        @builder.div(:class => 'message') do
          message = exception.message
          if defined?(RAILS_ROOT) && message.include?('Exception caught')
            matches = message.match(/Showing <i>(.+)<\/i>(?:.+) #(\d+)/)
            backtrace += ["#{RAILS_ROOT}/#{matches[1]}:#{matches[2]}"] if matches
            matches = message.match(/<code>([^(\/)]+)<\//m)
            message = matches ? matches[1] : ""
          end

          unless exception.instance_of?(RuntimeError)
            message = "#{message} (#{exception.class})"
          end

          @builder.pre do
            @builder.text!(message)
          end
        end
        @builder.div(:class => 'backtrace') do
          @builder.pre do
            backtrace = exception.backtrace
            backtrace.delete_if { |x| x =~ /\/gems\/(cucumber|rspec)/ }
            @builder << backtrace_line(backtrace.join("\n"))
          end
        end
        extra = extra_failure_content(backtrace)
        @builder << extra unless extra == ""
      end

      def set_scenario_color(status)
        if status == :undefined or status == :pending
          set_scenario_color_pending
        end
        if status == :failed
          set_scenario_color_failed
        end
      end

      def set_scenario_color_failed
        @builder.script do
          @builder.text!("makeRed('cucumber-header');") unless @header_red
          @header_red = true
          @builder.text!("makeRed('#{scenario_id}');") unless @scenario_red
          @scenario_red = true
        end
      end

      def set_scenario_color_pending
        @builder.script do
          @builder.text!("makeYellow('cucumber-header');") unless @header_red
          @builder.text!("makeYellow('#{scenario_id}');") unless @scenario_red
        end
      end

      def build_step(keyword, step_match, status)
        if @in_background
          display_keyword = keyword.strip + ' '
        else
          if keyword.strip == '*'
            @step_number_in_scenario += 1
            display_keyword = ''
            display_keyword << '0' if @step_number_in_scenario.to_s.size == 1
            display_keyword << @step_number_in_scenario.to_s
            display_keyword << '. '
          else
            display_keyword = keyword.strip + ' '
          end
        end

        step_name = step_match.format_args(lambda{|param| %{<span class="param">#{param}</span>}})
        @builder.div(:class => 'step_name') do |div|
          @builder.span(display_keyword, :class => 'keyword')
          @builder.span(:class => 'step val') do |name|
            name << h(step_name).gsub(/&lt;span class=&quot;(.*?)&quot;&gt;/, '<span class="\1">').gsub(/&lt;\/span&gt;/, '</span>')
          end
        end

        step_file = step_match.file_colon_line.force_encoding('UTF-8')
        step_file.gsub(/^([^:]*\.rb):(\d*)/) do
          if index = $1.index('lib/daddy/cucumber/step_definitions/')
            step_file = "daddy: " + $1[index..-1]
          end

          step_file = "<span style=\"cursor: pointer;\" onclick=\"toggle_step_file(this);\">#{step_file}:#{$2}</span>"
        end

        @builder.div(:class => 'step_file') do |div|
          @builder << step_file
        end
      end

      def build_cell(cell_type, value, attributes)
        @builder.__send__(cell_type, attributes) do
          @builder.div do
            @builder.span(value,:class => 'step param')
          end
        end
      end

      def inline_css
        @builder.style do
          @builder << File.read(File.dirname(__FILE__) + '/cucumber.css')
          @builder << File.read(File.dirname(__FILE__) + '/daddy.css')
          if File.exist?('features/support/daddy.css')
            @builder << File.read('features/support/daddy.css')
          end
        end
      end

      def inline_js
        @builder.script(:type => 'text/javascript') do
          @builder << inline_jquery
          @builder << inline_js_content
          @builder << inline_daddy
        end
      end

      def inline_jquery
        File.read(File.dirname(__FILE__) + '/jquery-min.js')
      end

      def inline_daddy
        ret = File.read(File.dirname(__FILE__) + '/daddy.js')

        ret << %w{
          $(document).ready(function() {
            $(SCENARIOS).find('li.step').each(function() {
              if ($(this).nextUntil('li.step').length > 0) {
                $(this).css('cursor', 'pointer').click(function() {
                  $(this).nextUntil('li.step').toggle(250);
                });
              }
            });
          });
        }.join

        if should_expand
          ret << %w{
            $(document).ready(function() {
              $('#expander').click();
            });
          }.join
        end
        
        ret
      end

      def inline_js_content
        <<-EOF

  SCENARIOS = "div.scenario h3";

  $(document).ready(function() {
    $(SCENARIOS).css('cursor', 'pointer');
    $(SCENARIOS).click(function() {
      $(this).siblings().toggle(250);
    });

    $("#collapser").css('cursor', 'pointer');
    $("#collapser").click(function() {
      $(SCENARIOS).siblings().hide();
      $('li.message').hide();
    });

    $("#expander").css('cursor', 'pointer');
    $("#expander").click(function() {
      $(SCENARIOS).siblings().show();
    });
  });

  function moveProgressBar(percentDone) {
    $("cucumber-header").css('width', percentDone +"%");
  }
  function makeRed(element_id) {
    $('#'+element_id).css('background', '#C40D0D');
    $('#'+element_id).css('color', '#FFFFFF');
  }
  function makeYellow(element_id) {
    $('#'+element_id).css('background', '#FAF834');
    $('#'+element_id).css('color', '#000000');
  }

        EOF
      end

      def move_progress
        @builder << " <script type=\"text/javascript\">moveProgressBar('#{percent_done}');</script>"
      end

      def percent_done
        result = 100.0
        if @step_count != 0
          result = ((@step_number).to_f / @step_count.to_f * 1000).to_i / 10.0
        end
        result
      end

      def format_exception(exception)
        (["#{exception.message}"] + exception.backtrace).join("\n")
      end

      def backtrace_line(line)
        line.gsub(/\A([^:]*\.(?:rb|feature|haml)):(\d*).*\z/) do
          if ENV['TM_PROJECT_DIRECTORY']
            "<a href=\"txmt://open?url=file://#{File.expand_path($1)}&line=#{$2}\">#{$1}:#{$2}</a> "
          else
            line
          end
        end
      end

      def print_stats(features)
        @builder <<  "<script>document.getElementById('duration').innerHTML = \"Finished in <strong>#{format_duration(features.duration)} seconds</strong>\";</script>"
        @builder <<  "<script>document.getElementById('totals').innerHTML = \"#{print_stat_string(features)}\";</script>"
      end

      def print_stat_string(features)
        string = String.new
        string << dump_count(@runtime.scenarios.length, "scenario")
        scenario_count = print_status_counts{|status| @runtime.scenarios(status)}
        string << scenario_count if scenario_count
        string << "<br />"
        string << dump_count(@runtime.steps.length, "step")
        step_count = print_status_counts{|status| @runtime.steps(status)}
        string << step_count if step_count
      end

      def print_status_counts
        counts = [:failed, :skipped, :undefined, :pending, :passed].map do |status|
          elements = yield status
          elements.any? ? "#{elements.length} #{status.to_s}" : nil
        end.compact
        return " (#{counts.join(', ')})" if counts.any?
      end

      def dump_count(count, what, state=nil)
        [count, state, "#{what}#{count == 1 ? '' : 's'}"].compact.join(" ")
      end

      def create_builder(io)
        ::Cucumber::Formatter::OrderedXmlMarkup.new(:target => io, :indent => 0)
      end

      class SnippetExtractor #:nodoc:
        class NullConverter; def convert(code, pre); code; end; end #:nodoc:
        begin; require 'syntax/convertors/html'; @@converter = Syntax::Convertors::HTML.for_syntax "ruby"; rescue LoadError => e; @@converter = NullConverter.new; end

        def snippet(error)
          raw_code, line = snippet_for(error[0])
          highlighted = @@converter.convert(raw_code, false)
          highlighted << "\n<span class=\"comment\"># gem install syntax to get syntax highlighting</span>" if @@converter.is_a?(NullConverter)
          post_process(highlighted, line)
        end

        def snippet_for(error_line)
          if error_line =~ /(.*):(\d+)/
            file = $1
            line = $2.to_i
            [lines_around(file, line), line]
          else
            ["# Couldn't get snippet for #{error_line}", 1]
          end
        end

        def lines_around(file, line)
          if File.file?(file)
            lines = File.open(file).read.split("\n")
            min = [0, line-3].max
            max = [line+1, lines.length-1].min
            selected_lines = []
            selected_lines.join("\n")
            lines[min..max].join("\n")
          else
            "# Couldn't get snippet for #{file}"
          end
        end

        def post_process(highlighted, offending_line)
          new_lines = []
          highlighted.split("\n").each_with_index do |line, i|
            new_line = "<span class=\"linenum\">#{offending_line+i-2}</span>#{line}"
            new_line = "<span class=\"offending\">#{new_line}</span>" if i == 2
            new_lines << new_line
          end
          new_lines.join("\n")
        end

      end
    end
  end
end