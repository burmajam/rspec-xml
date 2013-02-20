module RSpecXML
  module XMLMatchers
    class HaveXPath
        
      private

      class TextMatcher

        def initialize(options={})
          self.xpath = options[:xpath]
          self.text = options[:text]
        end

        def matches?(xml)
          @xml = xml
          doc = ::Nokogiri::XML(xml)
          doc.remove_namespaces!
          doc.xpath(xpath).text == text
        end

        def failure_message_for_should
          "expected #{xpath} to contain #{text} in\n#{@xml}"
        end

        def failure_message_for_should_not
          "expected #{xpath} to not exist with text: #{text} in\n#{@xml}"
        end

        private

        attr_accessor :text, :xpath
      end
    end
  end
end
