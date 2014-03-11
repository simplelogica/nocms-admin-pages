NoCms::Admin.menu_items << {
  name: 'pages',
  url: proc { NoCms::Admin::Pages::Engine.routes.url_helpers.pages_path }
}
