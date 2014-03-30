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

  config.block_layouts = {
    'default' => {
      template: 'default',
      fields: {
        title: :string,
        body: :text
      }
    },
    'title-3_columns' => {
      template: 'title_3_columns',
      fields: {
        title: :string,
        column_1: :text,
        column_2: :text,
        column_3: :text
      },
      nest_levels: [0, 1]
    },
    'logo-caption' => {
      template: 'logo_caption',
      fields: {
        caption: :string,
        logo: TestImage
      },
      nest_levels: [1]
    },
    'container_with_background' => {
      template: 'container_with_background',
      fields: {
        corners_css_class: :string,
        background_color: :string
      },
      allow_nested_blocks: true,
      nest_levels: [0]
    }

  }

end
