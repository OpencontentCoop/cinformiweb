{set_defaults( hash(
'page_limit', 10,
'view', 'line',
'delimiter', '',
'include_classes', array('cjw_newsletter_edition', 'e53_newsletter_issue'),
'parents', array($node.node_id,  '10251')
))}

{def $openpa = object_handler($node)}


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

      {include uri=$openpa.content_detail.template}

      {include uri=$openpa.content_infocollection.template}


      {def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}

      {def $children_count = fetch( openpa, 'list_count', hash( 'parent_node_id', $parents)|merge( $params ) )}

      {if $children_count}
        <div class="content-view-children">
          {foreach fetch( openpa, 'list', hash(
          'parent_node_id', $parents,
          'offset', $view_parameters.offset,
          'sort_by', array( 'published', false() ),
          'limit', $page_limit )|merge( $params ) ) as $child }

            {if $child.class_identifier|eq('cjw_newsletter_edition')}
              {if $child.data_map.newsletter_edition.content.status|eq('archive')}
                <div class="openpa-line class-cjw_newsletter_edition media">
                  <div class="media-body">
                    <h3 class="media-heading">
                      <a href="{concat('/newsletter/archive/',$child.data_map.newsletter_edition.content.edition_send_current.hash)}" target="_blank">{concat('CINFORMI NEWSLETTER', $child.name, '/', $child.object.published|datetime( 'custom', '%Y' ), ' immigrazione')}</a>
                    </h3>
                  </div>
                </div>
              {/if}
            {else}
              {node_view_gui view=$view content_node=$child}
            {/if}

            {delimiter}{$delimiter}{/delimiter}
          {/foreach}
        </div>

        {include name=navigator
        uri='design:navigator/google.tpl'
        page_uri=$node.url_alias
        item_count=$children_count
        view_parameters=$view_parameters
        item_limit=$page_limit}

      {/if}



    </div>

    {include uri='design:openpa/full/parts/section_left.tpl'}
  </div>
  {if $openpa.content_date.show_date}
    {include uri=$openpa.content_date.template}
  {/if}
</div>



