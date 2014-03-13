// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

NoCMS.ContentBlockHandler = function() {


  var default_layout_block = $('#new_content_block_default'),
    block_placeholder = $('#content_blocks_placeholder'),
    new_content_link = $('#new_content_block'),
    block_templates = $('.new.block'),
    that = this;

  new_content_link.on('click', function(e){
    e.preventDefault();
    that.createBlock();
  });

  block_placeholder.on('change', '.block_layout_selector', function(e){
    that.updateBlock($(this).parents('.block'), $(this).val());
  });

  block_placeholder.on('click', '.ico-mini-move-down', function(e){
    e.preventDefault();
    var block = $(this).parents('.block'),
      next_blocks = block.nextAll('.block');

    if(next_blocks.length > 0) {
      that.switchBlockPositions(block, next_blocks.first());
    }
  });

  block_placeholder.on('click', '.ico-mini-move-up', function(e){
    e.preventDefault();
    var block = $(this).parents('.block'),
      previous_blocks = block.prevAll('.block');

    if(previous_blocks.length > 0) {
      that.switchBlockPositions(previous_blocks.first(), block);
    }
  });

  this.updateBlock = function(block, new_layout){
    new_template = block_templates.filter('#new_content_block_' + new_layout)
    block.find('.layout_fields').html(new_template.find('.layout_fields').html());
    this.modifyInputNames(block, block.find('.block_layout_selector').attr('id').match(/_([0-9]*)_/)[1]);
  }

  this.switchBlockPositions = function(block, next_block){
    var next_block_position = next_block.find('.position').val();

    next_block.find('.position').val(block.find('.position').val());
    block.find('.position').val(next_block_position);

    next_block.after(block);
  }

  this.createBlock = function(){
    var position = $('.block').not('.new').length;
    new_block = default_layout_block.clone();
    new_block.removeClass('new');
    new_block.removeAttr('id');
    this.modifyInputNames(new_block, position);
    new_block.find('.position').val(position);

    block_placeholder.append(new_block);
  }

  this.modifyInputNames = function(block, position){

    block.find('[for]').each(function(){
      $(this).attr('for', $(this).attr('for').replace(/_[0-9]*_/, '_'+position+'_'))
    });
    block.find('[id]').each(function(){
      $(this).attr('id', $(this).attr('id').replace(/_[0-9]*_/, '_'+position+'_'))
    });
    block.find('[name]').each(function(){
      $(this).attr('name', $(this).attr('name').replace(/\[[0-9]*\]/, '['+position+']'))
    });

  }


  block_templates.each(function() {
    $(this).detach();
  });

}
