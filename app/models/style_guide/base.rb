# Base to contain common style guide logic
module StyleGuide
  class Base
    pattr_initialize :repo_config, :repository_owner_name

    def enabled?
      repo_config.enabled_for?(name)
    end

    def violations_in_file(_file)
      raise NotImplementedError.new("must implement ##{__method__}")
    end

    def file_included?(_file)
      true
    end

    private

    def directory_excluded?(file)
      repo_config.ignored_directories.any? do |directory|
        file.filename.start_with? directory
      end
    end

    def name
      self.class.name.demodulize.underscore
    end
  end
end
