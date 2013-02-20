module RSpecXML
  module XMLMatchers
    class HaveXPath
      private

      class Matcher
        def initialize(options={})
          self.xpath = options[:xpath]
          self.example_group = options[:example_group]
        end

        def matches?(xml)
          @xml = xml
          doc = ::Nokogiri::XML(xml)
          doc.remove_namespaces!
          doc.xpath(full_xpath).count > 0
        end

        def failure_message_for_should
          "expected #{full_xpath} to exist in\n#{@xml}"
        end

        def failure_message_for_should_not
          "expected #{full_xpath} to not exist in\n#{@xml}"
        end

        def full_xpath
          xpath_stack = example_group.instance_variable_get(:@xpath_stack) || []
          xpath_stack.join.concat(xpath)
        end

        attr_accessor :xpath, :example_group
      end
    end
  end
end
