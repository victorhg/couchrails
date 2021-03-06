require 'rails/generators/named_base'
require 'rails/generators/active_model'

module Couchrails
  module Generators

    class Base < ::Rails::Generators::NamedBase #:nodoc:
      # include Rails::Generators::Migration
      
      def self.source_root
        @_couchrails_source_root ||=
        File.expand_path(File.join(File.dirname(__FILE__), base_name, generator_name, 'templates'))
      end

      protected

      # # Couchrails does not care if migrations have the same name as long as
      # # they have different ids.
      # #
      # def migration_exists?(dirname, file_name) #:nodoc:
      #   false
      # end
      #
      # # Implement the required interface for Rails::Generators::Migration.
      #
      # def self.next_migration_number(dirname) #:nodoc:
      #   "%.3d" % (current_migration_number(dirname) + 1)
      # end

    end

    class ActiveModel < ::Rails::Generators::ActiveModel #:nodoc:
      def self.all(klass)
        "#{klass}.all"
      end

      def self.find(klass, params=nil)
        "#{klass}.get(#{params})"
      end

      def self.build(klass, params=nil)
        if params
          "#{klass}.new(#{params})"
        else
          "#{klass}.new"
        end
      end

      def save
        "#{name}.save"
      end

      def update_attributes(params=nil)
        "#{name}.update(#{params})"
      end

      def errors
        "#{name}.errors"
      end

      def destroy
        "#{name}.destroy"
      end
    end

  end
end

module Rails

  module Generators
    class GeneratedAttribute #:nodoc:
      def declaration
        declaration = @name
        declaration << ", :cast_as => '#{@type}'" unless !self.default.to_s.empty?
        declaration
      end
    end
  end

end
