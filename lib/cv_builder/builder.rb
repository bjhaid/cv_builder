require 'ostruct'
require 'yaml'
require 'erb'
require 'pdfkit'
module CvBuilder
  class ErbBinding < OpenStruct
    def get_binding
      return binding
    end
  end
  class Builder
    attr_reader :config_file, :template

    def initialize(options = {})
      @config_file = options.fetch(:config_file)
      @template = options.fetch(:template)
    end

    def generate_template(template_name = template)
      ERB.new(File.read("templates/#{template_name}.erb"), 0, "<>" ).result load_config.get_binding
    end

    def write
      if template == "pdf"
        kit = PDFKit.new(generate_template("html"), :page_size => 'Letter')
        kit.to_file(("resume.#{template}"))
      else
        File.open("resume.#{template}","w") { |f| f << generate_template }
      end
    end

    def load_config
      ErbBinding.new(YAML.load_file config_file)
    end


    def name
      "Foo Bar"
    end

    def phone_number
      "7737732733"
    end

    def email
      "foo@bar.com"
    end
  end
end
