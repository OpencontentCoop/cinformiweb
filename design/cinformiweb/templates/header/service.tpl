{def $header_service = openpaini('GeneralSettings','header_service', 1)
	 $header_service_list = array()
	 $is_area_tematica = is_area_tematica()}
{if $header_service|eq(1)}
	{set $header_service_list = $header_service_list|append(hash(
    'img', 'logo-pat.png',
		'url', openpaini('InstanceSettings','UrlAmministrazioneAfferente', '#'),
		'name', openpaini('InstanceSettings','NomeAmministrazioneAfferente', 'Provincia autonoma di Trento')
	))}
{/if}
{if and($is_area_tematica, $is_area_tematica|has_attribute('logo'))}
	{set $header_service_list = $header_service_list|append(hash(
		'url', "/"|ezurl(no),
		'name', cond( $pagedata.homepage|has_attribute('site_name'), $pagedata.homepage|attribute('site_name').content|wash(), ezini('SiteSettings','SiteName'))
	))}
{/if}

{if $header_service_list|count()|gt(0)}
<div class="Header-banner">
        <div class="Header-owner Headroom-hideme">
            {foreach $header_service_list as $item}
	            <div class="{if count($header_service_list)|gt(1)}Breadcrumb-item{else}u-inline{/if}">
		            <a class="Breadcrumb-link u-color-white" href="{$item.url}">
                  {if is_set($item.img)}
                    <img style="margin-bottom: -5px" src="{$item.img|ezimage(no)}" title="{$item.name}" />
                  {/if}
                  <span>{$item.name|wash()}</span>
		            </a>
	            </div>
            {/foreach}

            {*include uri='design:header/languages.tpl'*}
          <img class="u-floatRight" style="margin-bottom: -5px" src="{'logo-trentino.png'|ezimage(no)}" title="Trentino" />

        </div>
    </div>
{/if}

{undef $header_service $header_service_list $is_area_tematica}
