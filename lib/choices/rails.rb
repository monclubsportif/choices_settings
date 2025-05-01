require 'hashie/mash'
require 'choices'

module Choices::Rails
  def self.included(base)
    base.class_eval do
      def initialize_with_choices(*args, &block)
        initialize_without_choices(*args, &block)
        @choices = Hashie::Mash.new
      end

      alias_method :initialize_without_choices, :initialize
      alias_method :initialize, :initialize_with_choices
    end
  end

  def from_file(name)
    root = respond_to?(:root) ? self.root : Rails.root
    file = root + 'config' + name

    settings = Choices.load_settings(file, Rails.respond_to?(:env) ? Rails.env : RAILS_ENV)
    @choices.update settings

    settings.each do |key, value|
      old_value = respond_to?(key) ? send(key) : nil

      if 'Rails::OrderedOptions' == old_value.class.name
        # convert from Array to a real Hash
        old_value = old_value.each_with_object({}) do |(k, v), h|
          h[k] = v
        end
      end

      if value.is_a?(Hash) and old_value.is_a?(Hash)
        # don't overwrite existing Hash values; deep update them
        value = Hashie::Mash.new(old_value).update value
      end

      send("#{key}=", value)
    end
  end
end

if defined? Rails::Engine::Configuration
  Rails::Engine::Configuration.include Choices::Rails
elsif defined? Rails::Configuration
  Rails::Configuration.class_eval do
    include Choices::Rails
    include(Module.new do
      def respond_to?(method)
        super or method.to_s =~ /=$/ or (method.to_s =~ /\?$/ and @choices.key?(Regexp.last_match.pre_match))
      end

      private

      def method_missing(method, *args, &block)
        if method.to_s =~ /=$/ or (method.to_s =~ /\?$/ and @choices.key?(Regexp.last_match.pre_match))
          @choices.send(method, *args)
        elsif @choices.key?(method)
          @choices[method]
        else
          super
        end
      end
    end)
  end
end
