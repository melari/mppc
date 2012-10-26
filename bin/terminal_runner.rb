class TerminalOption
  attr_accessor :name, :arg_num, :help, :aliases, :usage

  def initialize(name, arg_num, help, usage)
    @name = name
    @arg_num = arg_num
    @help = help
    @usage = usage
    @aliases = []
  end

  def add_alias(alias_name)
    @aliases << alias_name
  end

  def has_alias?(alias_name)
    @name == alias_name || @aliases.include?(alias_name)
  end

  def to_s
    result = name
    aliases.each { |a| result << " " + a }
    result << " " + usage
    result << "\n\t" + help
  end
end

class TerminalParam
  attr_accessor :name, :help, :value

  def initialize(name, help)
    @name = name
    @help = help
  end
end

class TerminalRunner
  @@avail_options = []
  @@avail_params = []
  @@name = ""

  def self.start(args)
    @@params = {}
    @@options = {}

    @@avail_params.each do |param|
      param.value = args.shift
      @@params[param.name] = param.value
      if param.value.nil?
        puts "** Missing value for #{param.name} **"
        show_usage
        exit
      end
    end

    until args.empty?
      option = []
      option_name = get_next_arg(args)
      unless option_details = find_option(option_name)
        puts "Unknown option: '#{option_name}'."
        exit
      end
      (0..option_details.arg_num).each do |i|
        option[i] = args.shift
        if option[i].nil?
          puts "Missing argument for option '#{option_name}'"
          exit
        end
      end
      @@options[option_name] = option
    end

    self.run
  end

  def self.run
    puts "Override self.run to start."
  end

  protected

  def self.name(name)
    @@name = name
  end

  def self.option(name, arg_num, usage, help)
    @@avail_options << TerminalOption.new(name, arg_num-1, help, usage)
  end

  def self.option_alias(name, alias_name)
    return nil unless option = self.find_option(name)
    option.add_alias alias_name
  end

  def self.help(message)
    @@help = message
  end

  def self.show_usage
    usage = "Usage: #{@@name}"
    param_help = ""
    @@avail_params.each do |param|
      usage += " <#{param.name}>"
      param_help += "\t#{param.name}\n\t\t#{param.help}\n"
    end
    puts usage + " [options]"
    puts param_help
    puts "Options:"
    @@avail_options.each { |o| puts "\t" + o.to_s.gsub(/\t/, "\t\t") }
    puts "\n#{@@help}"
  end

  def self.param(name, help)
    @@avail_params << TerminalParam.new(name, help)
  end

  private

  def self.get_next_arg(args)
    arg = args.shift
    avail_option = self.find_option arg
    return avail_option.name if avail_option
    arg
  end

  def self.find_option(name)
    (@@avail_options.select { |o| o.has_alias? name })[0]
  end
end
