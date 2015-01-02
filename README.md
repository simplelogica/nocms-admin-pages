# nocms-pages-admin

Custom admin for NoCMS pages gem

## Installation

### 1. Link it to your Gemfile

To use this admin interface for NoCMS you must include this repository in your Gemfile.

```ruby
gem "nocms-pages-admin", git: 'git@github.com:simplelogica/nocms-pages-admin.git'
```

### 2. Create block templates

Each block defined in [NoCMS blocks catalog](doc/nocms-block-catalog.rb) can be placed in a page using the admin interface.
Usually blocks have parameters, but now there is not any process for auto-generating forms to enter parameter data. Therefore, you must create each one manually.
For each block type, it must exists a template located in:
 
  $PROJECT_DIR/app/views/no_cms/admin/pages/blocks

i.e. for a block *article* whose template is named "normal_article", you must create a template named:

  $PROJECT_DIR/app/views/no_cms/admin/pages/blocks/_normal_article.html.erb

This template must print an input for each one of the fields declared for block *article* in [NoCMS blocks catalog](doc/nocms-block-catalog.rb). 
As these fields are modelled as nested (common rails nested attributes), it's necessary to know de names and indexes of blocks where they are contained. To ease this task, templates always the *f variable*, a form builder, so you only have to provide the name of the field and forget about nesting.

In this example we show the case for a block with two fields: title and body, and the use of *f variable* to build the form with correct nesting:

```ruby
<div class="row">
	<%= f.label :title %>
	<%= f.text_field :title %>
</div>
<div class="row">
	<%= f.label :body %>
	<%= f.text_field :body %>
</div>
```  



