require "recursive_open_struct"

class SuperRecursiveOpenStruct
  def initialize(hash, args = {})
    @raise_on_missing_methods = args.fetch(:raise_on_missing_methods, true)

    @target = if hash.is_a?(Array)
      hash.map { |item| self.class.new(item) }
    else
      RecursiveOpenStruct.new(hash, recurse_over_arrays: true)
    end

    if @raise_on_missing_methods
      @target.instance_eval do
        def method_missing(method, *_args)
          raise NoMethodError, "undefined method \`#{method}' for #{self.inspect}"
        end
      end
    end
  end

  def method_missing(method, *args, &block)
    if !@raise_on_missing_methods || @target.respond_to?(method)
      @target.__send__(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    @target.respond_to?(method, include_private)
  end

  alias_method :to_s, def inspect
    contents = @target.inspect.gsub(/\A#<RecursiveOpenStruct (.+)>\Z/, "\\1")
    "#<SuperRecursiveOpenStruct:0x#{__id__.to_s(16)} #{contents}>".freeze
  end
end
