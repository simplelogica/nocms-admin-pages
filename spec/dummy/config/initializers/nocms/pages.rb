NoCms::Pages.configure do |config|

  # In this section we configure block layouts. It's just an array of layouts, each consisting on a hash.
  # Each layout has a template and a list of fields with a type.
  # E.g: config.block_layouts = {
  #   'title-long_text' => {
  #     template: 'title-long_text',
  #     fields: {
  #       title: :string,
  #       long_text: :text
  #     }
  #   },
  #   'title-3_columns_text' => {
  #     template: 'title-3_columns_text',
  #     fields: {
  #       title: :string,
  #       column_1: :text,
  #       column_2: :text,
  #       column_3: :text
  #     }
  #   }
  # }
  # config.block_layouts = {}


  # By default we use blocks to create the content of the page. If we just want a big textarea to insert the content we must set use_body to true
  # config.use_body = false


end
