
{if and( is_set($node.data_map.file), $node.data_map.file.has_content)}
  <div class="content-related">
    <div class="openpa-widget nav-section">
      <h5 class="u-text-h5"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> {$node.data_map.file.contentclass_attribute_name}</h5>
      <div class="openpa-widget-content">
        {attribute_view_gui attribute=$node|attribute('file')}
      </div>
    </div>
  </div>
{/if}

{if and( is_set($node.data_map.servizi), $node.data_map.servizi.has_content)}
  <div class="content-related">
    <div class="openpa-widget nav-section">
      <h5 class="u-text-h5"><i class="fa fa-wrench" aria-hidden="true"></i> {$node.data_map.servizi.contentclass_attribute_name}</h5>
      <div class="openpa-widget-content">
        {attribute_view_gui attribute=$node|attribute('servizi') show_newline=true()}
      </div>
    </div>
  </div>
{/if}