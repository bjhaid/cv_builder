require 'spec_helper'
require 'tempfile'
module CvBuilder
  describe Builder do
    it "should generate resume in txt file matching template" do
      yaml = { name: "Foo Bar",
        phone_number: "7737732733",
        email: "foo@bar.com"
      }.to_yaml
      config_file = Tempfile.new('foo') 
      config_file.write yaml
      config_file.close
      options = {config_file: config_file.path, template: "txt"}
      sub =  Builder.new(options)
      template = sub.generate_template
      sub.write
      Approvals.verify template, :name => "resumetxt", :format => "txt"
    end

    it "loads YAML file from the directory it runs from" do
      config_file = "resume.yaml"
      options = {config_file: config_file, template: "txt"}
      subject = Builder.new(options)
      expect(subject.load_config).to be_true #playing on truthsiness
    end

    it "loads YAML file as an object" do
      config_file = "resume.yaml"
      options = {config_file: config_file, template: "html"}
      subject = Builder.new(options)
      expect(subject.load_config.methods.include? :contact).to be_true
    end
  end
end
