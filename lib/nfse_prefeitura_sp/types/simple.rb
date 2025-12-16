module NfsePrefeituraSp::Types
  class Simple
    attr_accessor :key, :value

    def initialize(key, value)
      @key   = key
      @value = value
    end

    def has_any_child_value?; !@value.nil?; end

    def add_tag_to_xml(xml)
      xml.send(@key, @value) if !@value.nil?
    end
  end
end
