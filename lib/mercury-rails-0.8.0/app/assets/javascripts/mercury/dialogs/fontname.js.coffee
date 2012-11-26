@Mercury.dialogHandlers.fontname = ->
  @element.find('[data-tag]').on 'click', (event) =>
    tag = jQuery(event.target).data('tag')
    Mercury.trigger('action', {action: 'fontname', value: tag})
	