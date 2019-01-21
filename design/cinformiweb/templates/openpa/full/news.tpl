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

{def $extra_template = 'design:openpa/full/parts/section_left/guida_pratica.tpl'}

<div class="openpa-full class-{$node.class_identifier}">
  <div class="title">
    {include uri='design:openpa/full/parts/node_languages.tpl'}
    <h2>{$node.name|wash()}</h2>
    {if $node|has_attribute( 'sottotitolo' )}
      <h3 class="u-margin-bottom-l">{attribute_view_gui attribute=$node|attribute('sottotitolo')}</h3>
    {/if}

  </div>
  <div class="content-container">
    <div class="content{if or( $show_left, $openpa.control_menu.show_extra_menu )} withExtra{/if}">

      {if $openpa.content_main.has_content}
        <article class="content-main-abstract">
          {if $node|has_attribute( 'data' )}
            <p class="Prose">{attribute_view_gui attribute=$node|attribute('data')}</p>
          {/if}

          {if $node|has_attribute( 'abstract' )}
            {attribute_view_gui attribute=$node|attribute('abstract')}
          {/if}

          {if is_set( $openpa.content_main.parts.image )}
            {include uri='design:atoms/image.tpl' item=$node image_class=imagefull css_classes="main_image" image_css_class="img-responsive"}
          {/if}
        </article>
        {if is_set( $openpa.content_main.parts.full_text )}
          <article class="content-main-body">
            {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
          </article>
        {/if}
      {/if}

      {include uri=$openpa.content_contacts.template}

      {include uri=$openpa.content_detail.template}

      {include uri=$openpa.content_infocollection.template}

      <div class="Grid Grid--withGutter u-layout-prose">
        <div class="Grid-cell u-size1of2">
          <button class="Button Button--info print" style="padding: 12px 15px;" onclick="window.print();return false;">
            <i class="fa fa-print" aria-hidden="true"></i> Stampa
          </button>
        </div>
        <div class="Grid-cell u-size1of2">
          {if ezini('GeneralSettings','SocialButtons', 'openpa.ini')|eq('enabled')}
            {include uri='design:openpa/full/parts/social_buttons.tpl'}
          {/if}
        </div>
      </div>


      {node_view_gui content_node=$node view=children view_parameters=$view_parameters}

    </div>

    {include uri='design:openpa/full/parts/section_left.tpl' extra_template=$extra_template}
  </div>
  {if $openpa.content_date.show_date}
    {include uri=$openpa.content_date.template}
  {/if}
</div>



