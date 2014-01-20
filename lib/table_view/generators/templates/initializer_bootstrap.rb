TableView.setup do |config|
  #HTML classes that will be set to TABLE tag
  config.default_table_classes = %w(table table-bordered)

  #HTML class that will be set to TD tags containing anchors created by #link_to builder method
  config.link_cell_class = nil

  #HTML class that will be set to TR tag rendered when there is no records to show
  config.no_records_class = "warning"

  #I18n tag which contets will be set displayed when there is no records to show
  config.i18n_no_records = nil

  #I18n scope for boolean translations. Should include "true" and "false" keys
  config.i18n_boolean = nil
end