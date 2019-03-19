<h2 style="color: #404040 !important;font-family: arial,helvetica,sans-serif;font-size:1.3em;font-weight:bold;line-height:1;padding:0;margin:0;">
    {$item.name|wash()}
</h2>

{if $item.data_map.publish_date}
    <p style="font-size: 0.9em;margin: 4px 0 0;">{attribute_view_gui attribute=$item.data_map.publish_date}</p>
{/if}

{if $item|has_abstract()}
    {$item|abstract()|openpa_shorten(200)}
{/if}

<p>
    <a href="http://{concat($site_url, $item.object.main_node.url_alias|ezurl('no'))}" title="Per saperne di più" style="color: #006699">Per saperne di più</a>
</p>


