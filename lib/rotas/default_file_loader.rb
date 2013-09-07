class RotasDefaultFileLoader
  attr_reader :config_yaml_source

  def initialize(app=OpenStruct.new({ options: Hash.new(nil), source_file: nil}))
    @options = app.options
    @selected_source_file = app.source_file
    @config_yaml_source = identify_yaml_definition_file
  end

  def config_yaml
    YAML.load_file(@config_yaml_source)
  end

  private

  def identify_yaml_definition_file
    yaml_source = if @selected_source_file
       @selected_source_file
    else
      load_personal_rotas_file || load_factory_default_rotas_file
    end
    raise unless yaml_source
    yaml_source
  rescue => e
    puts "Rotas could not load a data file: #{e.message}"
  end

  def load_personal_rotas_file
    return false if @options[:disallow_user_config]
    personal_rotas_file = File.join(ENV['HOME'], ".rotas.yml")
    return personal_rotas_file if File.exists?(personal_rotas_file)
    false
  end

  def load_factory_default_rotas_file
    default_config_file_path = File.join(File.dirname(__FILE__), '..', '..',  *%w/data rotas.yml/)
    return default_config_file_path if File.exists?(default_config_file_path)
  end
end
