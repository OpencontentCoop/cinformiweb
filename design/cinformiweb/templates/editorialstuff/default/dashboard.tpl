{ezcss_require( array(
    'plugins/chosen.css',
    'jquery.dataTables.min.css'
))}
{ezscript_require(array(
    'ezjsc::jquery',
    'plugins/chosen.jquery.js',
    'moment.min.js',
    'jquery.dataTables.min.js',
    'jquery.opendataDataTable.js',
    'jquery.opendataTools.js',
    'jquery.editorialstuff_dashboard.js',
    'leaflet.js'
))}

<script type="text/javascript" language="javascript" class="init">
    $.opendataTools.settings('accessPath', "{'/'|ezurl(no,full)}");
    $.opendataTools.settings('subTree', "[{implode($factory_configuration.RepositoryNodes)}]");
    $.opendataTools.settings('language', "{ezini('RegionalSettings','Locale')}");
    $.opendataTools.settings('dasboardClassIdentifier', "{$factory_configuration.ClassIdentifier}");
    $.opendataTools.settings('languages', ['{ezini('RegionalSettings','SiteLanguageList')|implode("','")}']); //@todo
    $.opendataTools.settings('endpoint',{ldelim}
        'geo': '{'/opendata/api/geo/search/'|ezurl(no,full)}',
        'search': '{'/opendata/api/content/search/'|ezurl(no,full)}',
        'class': '{'/opendata/api/classes/'|ezurl(no,full)}',
        'fullcalendar': '{'/opendata/api/fullcalendar/search/'|ezurl(no,full)}',
    {rdelim});

    var Translations = {ldelim}
        'Titolo':'{'Titolo'|i18n('agenda/dashboard')}',
        'Pubblicato':'{'Pubblicato'|i18n('agenda/dashboard')}',
        'Autore': '{'Autore'|i18n('agenda/dashboard')}',
        'Inizio': '{'Inizio'|i18n('agenda/dashboard')}',
        'Fine': '{'Fine'|i18n('agenda/dashboard')}',
        'Stato': '{'Stato'|i18n('agenda/dashboard')}',
        'Traduzioni': '{'Traduzioni'|i18n('agenda/dashboard')}',
        'Dettaglio': '{'Dettaglio'|i18n('agenda/dashboard')}',
        'Loading...': '{'Loading...'|i18n('agenda/dashboard')}'
    {rdelim};

    var PostBaseUrl = "{concat('/editorialstuff/edit/', $factory_identifier, '/')}";
    var DashboardUrl = "{concat('/editorialstuff/dashboard/', $factory_identifier)}";
    var StateGroup = "{$factory_configuration.StateGroup}";

</script>    
<style>
    .chosen-search input, .chosen-container-multi input{ldelim}height: auto !important{rdelim}
    {def $colors = array(
        '#cccccc',
        '#999999',
        '#f0ad4e',
        '#5cb85c',
        '#d9534f'
    )}
    {def $index = 0}
    {foreach $states as $state}
    .label-{$state.identifier}{ldelim}padding:3px; background-color: {$colors[$index]};{rdelim}
    {set $index = $index|inc()}
    {/foreach}        
    .fr-dialogmodal--is-ready{ldelim}z-index:1000{rdelim}
</style> 

<div class="Grid Grid--withGutter u-margin-bottom-m">
    <div class="Grid-cell u-sizeFull">
        <h1 class="u-text-h2">{if is_set($factory_configuration.Name)}{$factory_configuration.Name|wash()}{else}Dashboard {$factory_identifier}{/if}</h1>
    </div>

    <div class="Grid-cell u-size2of3 u-margin-top-m">
        {if $factory_configuration.CreationRepositoryNode}
            <a href="{concat('editorialstuff/add/',$factory_identifier)|ezurl(no)}"  class="Button Button--default u-text-r-xs">{$factory_configuration.CreationButtonText|wash()}</a>
        {/if}
    </div>

    <div class="Grid-cell u-size1of3 u-margin-top-m" id="dashboard-filters-container">
        <div class="clearfix">
            <div class="nav-section space pull-right">
                <form class="form-inline">
                    <div class="form-group" style="margin-bottom: 10px">
                        <label for="state">{'Filtra per stato'|i18n('agenda/dashboard')}</label>
                        <select id="state" data-field="state" data-placeholder="{'Seleziona'|i18n('agenda/dashboard')}" name="state">
                            <option value=""></option>
                            {foreach $states as $state}
                                <option value="{$state.id|wash()}" data-state_identifier="{$state.identifier|wash()}" class="label-{$state.identifier|wash()}">{$state.current_translation.name|wash()}</option>
                            {/foreach}
                        </select>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <hr />

    <div class="Grid-cell u-sizeFull editorialstuff">
      <div class="content-data"></div>
    </div>

</div>


<div class="Dialog js-fr-dialogmodal" id="preview">
    <div class="
      Dialog-content
      Dialog-content--centered
      u-background-white
      u-layout-medium
      u-margin-all-xl
      u-padding-all-xl
      js-fr-dialogmodal-modal" aria-labelledby="modal-title">
    <div class="modal-content" role="document"></div>
</div>