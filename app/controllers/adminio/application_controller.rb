module Adminio
	class ApplicationController < ActionController::Base
		layout 'adminio/application'

		before_action :load_defaults, :load_menu

		def index
			if defined?(@parent)
				@parent_obj = finder(@parent, params["#{@parent.name.underscore}_id"])
				@collection = @parent_obj.send("#{@klass_name.pluralize.underscore}")
			else
				@collection = @klass.all
			end
			render 'shared/_index'
		end

		def new
			if defined?(@parent)
				@parent_obj = finder(@parent, params["#{@parent.name.underscore}_id"])
			end
			@instance = @klass.new
			render 'shared/_form'
		end

		def create
			@instance = @klass.new(object_params)

			if defined?(@parent)
				@parent_obj = finder(@parent, params["#{@parent.name.underscore}_id"])
				@instance["#{@parent.name.underscore}_id"] = @parent_obj.id
			end

			if(@instance.save)
				redirect("criado")
			else
				render 'shared/_form'
			end
		end

		def edit
			@instance = finder(@klass, params[:id])
			if defined?(@parent)
				@parent_obj = @instance.send(@parent.name.underscore)
			end
			render 'shared/_form'
		end

		def update
			@instance = finder(@klass, params[:id])
			if defined?(@parent)
				@parent_obj = @instance.send(@parent.name.underscore)
			end

			if(@instance.update_attributes(object_params))
				redirect("editado")
			else
				render 'shared/_form'
			end
		end

		def destroy
			@instance = finder(@klass, params[:id])
			@parent_obj = @instance.send(@parent.name.underscore)
			@instance.destroy
			redirect("excluido")
		end

		def show
			@instance = finder(@klass, params[:id])
			render 'shared/_show'
		end

		private 
		def object_params
			params.require(:"#{@klass_name}").permit(@form_fields, @assoc_extra)
		end

		def finder(klass, id)
			if(klass.respond_to? :friendly)
				klass.friendly.find(id)
			else
				klass.find(id)
			end
		end

		def redirect(msg)
			if defined?(@parent)
				redirect_to send("admin_#{@parent.name.downcase}_#{@klass_name.pluralize.underscore}_path", @parent_obj), notice: "#{@klass_name.humanize} #{msg}(a) com sucesso!"
			else
				redirect_to send("admin_#{@klass_name.pluralize}_path"), notice: "#{@klass_name.humanize} #{msg}(a) com sucesso!"
			end
		end

		def load_defaults
			@klass = AdminController
			@assoc_extra = []
			@actions = [:show, :edit, :delete]
			@klass_name = @klass.name.underscore
		end

		def load_menu
			@menu_items = {
				products: "admin_products",
				categories: "admin_categories",
				option_groups: "admin_option_groups"
			}
			@logout = true;
		end

	end
end
