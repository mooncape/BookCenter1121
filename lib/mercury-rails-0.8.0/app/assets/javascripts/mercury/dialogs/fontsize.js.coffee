@Mercury.dialogHandlers.fontsize = ->
  @element.find('[data-tag]').on 'click', (event) =>
    tag = jQuery(event.target).data('tag')
    Mercury.trigger('action', {action: 'fontsize', value: tag})
	