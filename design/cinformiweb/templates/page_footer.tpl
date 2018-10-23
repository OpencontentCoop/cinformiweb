{def $is_area_tematica = is_area_tematica()}
{def $footerBlocks = 4
     $has_notes = false()
     $has_contacts = false()
     $has_links  = false()
     $has_social  = false()
     $footerBlocksClass = 'u-sizeFull'}

{if and($is_area_tematica, $is_area_tematica|has_attribute('link'))}
    {def $footer_links = array()}
    {foreach $is_area_tematica|attribute('link').content.relation_list as $item}
        {set $footer_links = $footer_links|append(fetch(content, node, hash(node_id, $item.node_id)))}
    {/foreach}
{else}
    {def $footer_links = fetch( 'openpa', 'footer_links' )}
{/if}

{if and($is_area_tematica, $is_area_tematica|has_attribute('note_footer'))}
    {def $footer_notes = $is_area_tematica|attribute('note_footer')}
{else}
    {def $footer_notes = fetch( 'openpa', 'footer_notes' )}
{/if}

{if count( $footer_notes )|gt(0)}
    {set $has_notes = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if and($is_area_tematica, $is_area_tematica|has_attribute('contacts'))}
    {def $contacts = parse_contacts_matrix($is_area_tematica)}
{else}
    {def $contacts = $pagedata.contacts}
{/if}

{if or(is_set($contacts.indirizzo), is_set($contacts.telefono), is_set($contacts.fax),
       is_set($contacts.email), is_set($contacts.pec), is_set($contacts.web))}
    {set $has_contacts = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if or(is_set($contacts.facebook), is_set($contacts.twitter), is_set($contacts.linkedin), is_set($contacts.instagram))}
    {set $has_social = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if count( $footer_links )|gt(0)}
    {set $has_links = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if $footerBlocks|gt(1)}
    {set $footerBlocksClass = concat('u-md-size1of', $footerBlocks, ' u-lg-size1of', $footerBlocks) }
{/if}

{if openpaini('GeneralSettings','valutation', 1)}
    {if and( $ui_context|ne( 'edit' ), $ui_context|ne( 'browse' ) )}
        {if $pagedata.class_identifier|ne('')}
           {literal}<script>$(document).on('click', '#toggle-validation', function(e){$('#openpa-valuation').toggle();e.preventDefault();});</script>{/literal}
            <div class="u-background-95 u-padding-all-xl u-layoutCenter u-hiddenPrint">
                <p class="u-textCenter u-margin-top-m u-margin-bottom-m">
                    <a href="#" id="toggle-validation" class="u-color-white u-textClean u-text-h3">
                        <span class="u-padding-r-right Icon Icon-comment"></span> {'Valuta questo sito'|i18n('openpa/valuation')}
                    </a>
                </p>
                <div style="display: none" id="openpa-valuation">
                    {include name=valuation node_id=$current_node_id uri='design:openpa/valuation.tpl'}
                </div>
            </div>
        {/if}
    {/if}
{/if}


{if and( $pagedata.homepage|has_attribute('partners'), $pagedata.homepage|attribute('partners').has_content) }
    {include uri='design:footer/partners.tpl'}
{/if}
<div class="footer-container u-hiddenPrint">
  <div class="u-layout-wide u-layoutCenter u-layout-r-withGutter">
    <footer class="Footer u-hiddenPrint">
        <div class="u-cf">
            <p class="Footer-siteName">{ezini('SiteSettings','SiteName')}</p>
        </div>

        <div class="Grid Grid--withGutter">

            {if $has_notes}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Informazioni'|i18n('openpa/footer')}</h2>
                    <div class="Footer-subBlock">
                        <div class="u-lineHeight-xl u-color-white">
                            {attribute_view_gui attribute=$footer_notes}
                        </div>
                    </div>
                </div>
            {/if}

            {if $has_contacts}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Contatti'|i18n('openpa/footer')}</h2>
                    {include uri='design:footer/contacts_list.tpl' contacts=$contacts}
                </div>
            {/if}

            {if $has_links}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Links'|i18n('openpa/footer')}</h2>
                    <ul>
                        {foreach $footer_links as $item}
                            {def $href = $item.url_alias|ezurl(no)}
                            {if eq( $ui_context, 'browse' )}
                                {set $href = concat("content/browse/", $item.node_id)|ezurl(no)}
                            {elseif $pagedata.is_edit}
                                {set $href = '#'}
                            {elseif and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                                {set $href = $item.data_map.location.content}
                            {/if}
                            <li><a href="{$href}"
                                   title="Leggi {$item.name|wash()}">{$item.name|wash()}</a>
                            </li>
                            {undef $href}
                        {/foreach}
                    </ul>
                </div>
            {/if}

            {if $has_social}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Seguici su'|i18n('openpa/footer')}</h2>
                    {include uri='design:footer/social.tpl'}
                </div>
            {/if}

        </div>

        <div class="Footer-links u-cf"></div>

        <div class="Grid Grid--withGutter">
            <div class="Footer-block Grid-cell u-md-size3of5 u-lg-size3of5">
                {include uri='design:footer/copyright.tpl'}
            </div>
            <div class="Footer-block Grid-cell u-md-size2of5 u-lg-size2of5 text-right">
                {if $pagedata.is_login_page|not()}
                    {include uri='design:footer/user_access.tpl'}
                {/if}
            </div>
        </div>
    </footer>
  </div>
</div>

<a href="#" title="torna all'inizio del contenuto" class="ScrollTop js-scrollTop js-scrollTo">
    <i class="ScrollTop-icon Icon-collapse" aria-hidden="true"></i>
    <span class="u-hiddenVisually">{"torna all'inizio del contenuto"|i18n('openpa/footer')}</span>
</a>

{undef}
