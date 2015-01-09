#Steps to configure Adminio

##Gemfile

```ruby
git 'adminio', '0.0.1', git: 'https://github.com/victorbueno/adminio.git'
```

##Admin Controller

```ruby
AdminController < Adminio::AdminController

private
def load_menu
  @menu_items = {categories: "admin_categories"}
  @logout = false;
end
```

##Other Controllers

```ruby
OtherController < AdminController
private
def load_defaults
	@klass = Category                         #A própria classe
	@klass_name = Category.name.underscore    #String com nome da classe
	@index_fields = [:name]                   #Campos mostrados na index
	@show_fields = [:name]                    #Campos mostrados no show
	@form_fields = [:name]                    #Campos mostrados no formulário
	@actions = [:show, :edit, :delete]        #Ações liberadas
	@associations = [:option_group]           #Has many
	@assoc_extra = [:option_group_id]         #Campo específico do has_many
	@parent = Product                         #Belongs to
end
```
