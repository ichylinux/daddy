require 'itamae/recipe'

module Itamae
  class Recipe
    class << self
      def find_recipe_in_gem_with_daddy(recipe)
        ret = find_recipe_in_gem_without_daddy

        puts recipe
        plugin_name, recipe_file = recipe.split('::', 2)
        recipe_file = recipe_file.gsub("::", "/") if recipe_file
        return ret unless plugin_name == 'daddy'

        gem_name = plugin_name
        begin
          gem gem_name
        rescue LoadError
        end
        spec = Gem.loaded_specs.values.find do |spec|
          spec.name == gem_name
        end

        return retl unless spec

        candidate_files = []
        if recipe_file
          recipe_file += '.rb' unless recipe_file.end_with?('.rb')
          candidate_files << "#{plugin_name}/#{recipe_file}"
        else
          candidate_files << "#{plugin_name}/default.rb"
          candidate_files << "#{plugin_name}.rb"
        end

        candidate_files.map do |file|
          File.join(spec.lib_dirs_glob, 'itamae', 'plugin', 'recipe', file)
        end.find do |path|
          File.exist?(path)
        end
        
        ret += candidate_files
      end

      alias_method :find_recipe_in_gem_without_daddy, :find_recipe_in_gem_with_daddy
      alias_method :find_recipe_in_gem_with_daddy, :find_recipe_in_gem_with_daddy
    end
  end
end
