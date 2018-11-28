{if $openpa.control_cache.no_cache}
  {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
  {include uri=$openpa.content_tools.template}
{/if}

{if $openpa.control_menu.side_menu.root_node}
  {def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
  $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}
{else}
  {def $show_left = false()}
{/if}

<div class="openpa-full class-{$node.class_identifier}">
  <div class="title">
    {include uri='design:openpa/full/parts/node_languages.tpl'}
    <h2>{$node.name|wash()}</h2>
  </div>
  <div class="content-container">
    <div class="content{if or( $show_left, $openpa.control_menu.show_extra_menu )} withExtra{/if}">

      {include uri=$openpa.content_main.template}

      {include uri=$openpa.content_contacts.template}

      {if $openpa.content_detail.has_content}
        <div class="content-detail">
          {foreach $openpa.content_detail.attributes as $openpa_attribute}
            <div
              class="content-detail-item{if and( $openpa_attribute.full.show_label, $openpa_attribute.full.collapse_label|not() )} withLabel{/if}">
              {if and( $openpa_attribute.full.show_label, $openpa_attribute.full.collapse_label|not() )}
                <div class="label u-text-h5">
                  <strong>{$openpa_attribute.label}</strong>
                </div>
              {/if}
              <div class="value">
                {if and( $openpa_attribute.full.show_label, $openpa_attribute.full.collapse_label )}
                  <div class="u-text-h5"><strong>{$openpa_attribute.label}</strong></div>
                {/if}
                <div
                  class="{if and( $openpa_attribute.full.show_label, $openpa_attribute.full.collapse_label )} u-padding-left-s{/if}">
                  {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.full.show_link|not, 'no-link', '') show_newline=true()}
                </div>
              </div>
            </div>
          {/foreach}
        </div>
      {/if}

      {if is_set($hide_attachment)|not()}
        {include uri=$openpa.content_attachment.template}
      {/if}

      {if is_set($hide_gallery)|not()}
        {include uri=$openpa.content_gallery.template}
      {/if}

      {include uri=$openpa.content_infocollection.template}

      {node_view_gui content_node=$node view=children view_parameters=$view_parameters}

    </div>

    {include uri='design:openpa/full/parts/section_left.tpl'}
  </div>
  {if $openpa.content_date.show_date}
    {include uri=$openpa.content_date.template}
  {/if}
</div>



