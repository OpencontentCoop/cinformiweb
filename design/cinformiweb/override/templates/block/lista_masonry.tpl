{def $openpa = object_handler($block)}
{set_defaults(hash('show_title', true(), 'link_top_title', true()))}

<div class="openpa-widget {$block.view} {if and(is_set($block.custom_attributes.color_style), $block.custom_attributes.color_style|ne(''))}color color-{$block.custom_attributes.color_style}{/if}u-layout-centerContent u-cf">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title">{if and($openpa.root_node, $link_top_title)}<a href={$openpa.root_node.url_alias|ezurl()}>{else}<span>{/if}{$block.name|wash()}{if and($openpa.root_node, $link_top_title)}</a>{else}</span>{/if}</h3>
    {/if}
    <div class="openpa-widget-content u-layout-centerContent u-cf">
        <section class="js-Masonry-container u-layout-wide" data-columns>
            {foreach $openpa.content as $item}
                <div class="Masonry-item js-Masonry-item">
                    {node_view_gui content_node=$item view='panel' image_class='agid_panel'}
                </div>
            {/foreach}
        </section>
    </div>
    {if and($openpa.root_node, $link_top_title|not(), $openpa.page_block.type|ne('Lista3')}
      <p class="goto">
        <a href="{$openpa.root_node.url_alias|ezurl(no)}">Vedi tutto <span></span></a>
      </p>
    {/if}
</div>

