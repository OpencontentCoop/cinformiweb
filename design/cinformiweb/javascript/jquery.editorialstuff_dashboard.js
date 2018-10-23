$(document).ready(function () {
    var tools = $.opendataTools;

    var datatableLanguage = "//cdn.datatables.net/plug-ins/1.10.12/i18n/Italian.json";
    var calendarLocale = 'it';
    if (tools.settings('language') == 'ger-DE') {
        datatableLanguage = "//cdn.datatables.net/plug-ins/1.10.12/i18n/German.json";
        calendarLocale = 'de';
    } else if (tools.settings('language') == 'eng-GB') {
        datatableLanguage = "//cdn.datatables.net/plug-ins/1.10.12/i18n/English.json";
        calendarLocale = 'en';
    }

    var mainQuery = 'classes ['+tools.settings('dasboardClassIdentifier')+']';
    if (tools.settings('subTree').length > 0){
        mainQuery += ' subtree ' + tools.settings('subTree');
    }
    var stateSelect = $('select#state');
    var calendar = $('#calendar');
    var datatable = $('.content-data').opendataDataTable({
        "builder": {
            "query": mainQuery
        },
        "datatable": {
            "language": {"url": datatableLanguage},
            "ajax": {url: tools.settings('accessPath') + "/opendata/api/datatable/search/"},
            "order": [[3, "desc"]],
            "columns": [
                {"data": "metadata.remoteId", "name": 'remote_id', "title": '', "sortable": false},
                {"data": "metadata.name."+tools.settings('language'), "name": 'name', "title": Translations['Titolo']},
                {
                    "data": "metadata",
                    "name": 'raw[meta_owner_name_t]',
                    "title": Translations['Autore']
                },
                {"data": "metadata.published", "name": 'published', "title": Translations['Pubblicato']},
                {"data": "metadata.stateIdentifiers", "name": 'state', "title": Translations['Stato'], "sortable": false},
                {"data": "metadata.id", "name": 'id', "title": '', "sortable": false}
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        //return '<a class="btn btn-info btn-lg js-fr-dialogmodal-open" aria-controls="preview" data-toggle="modal" data-load-remote="/layout/set/modal/content/view/full/'+row.metadata.mainNodeId+'" data-remote-target="#preview .modal-content" href="#" data-target="#preview">Anteprima</a> 
                        return '<a class="btn btn-info" href="' + tools.settings('accessPath') + PostBaseUrl + row.metadata.id + '">'+Translations['Dettaglio']+'</a>';
                    },
                    "targets": [0]
                },                
                {
                    "render": function (data, type, row) {
                        var contentData = row.metadata.ownerName;
                        if (contentData)
                            return typeof contentData[tools.settings('language')] != 'undefined' ? contentData[tools.settings('language')] : contentData[Object.keys(contentData)[0]];
                        return '?';
                    },
                    "targets": [2]
                },
                {
                    "render": function (data, type, row) {
                        return moment(new Date(data)).format('DD/MM/YYYY');
                    },
                    "targets": [3]
                },
                {
                    "render": function (data, type, row) {                        
                        return $.map(data, function (value, key) {
                            var parts = value.split('.');                            
                            if (parts[0] == StateGroup) {
                                return $.map(stateSelect.find('option'), function (option) {
                                    var $option = $(option);
                                    if ($option.data('state_identifier') == parts[1]) {
                                        return '<span class="label label-info label-'+$option.data('state_identifier')+'">'+$option.text()+'</span>';
                                    }
                                });
                            }
                        });
                    },
                    "targets": [4]
                },
                {
                    "render": function (data, type, row) {
                        return ' <form method="post" action="' + tools.settings('accessPath') + '/content/action" style="display: inline;"><button class="btn btn-link btn-xs" type="submit" name="ActionRemove"><i class="fa fa-trash" style="font-size: 12px;"></i></button><input name="ContentObjectID" value="' + row.metadata.id + '" type="hidden"><input name="NodeID" value="' + row.metadata.mainNodeId + '" type="hidden"><input name="ContentNodeID" value="' + row.metadata.mainNodeId + '" type="hidden"><input name="RedirectIfCancel" value="'+DashboardUrl+'" type="hidden"><input name="RedirectURIAfterRemove" value="'+DashboardUrl+'" type="hidden"></form> ';
                    },
                    "targets": [5]
                }
            ]
        },
    // }).on( 'draw.dt', function () {        
    //     $('[data-load-remote]').on('click', function (e) {
    //         e.preventDefault();
    //         var $this = $(this);
    //         $($this.data('remote-target')).html('<em>Loading...</em>');
    //         var remote = $this.data('load-remote');
    //         if (remote) {
    //             $($this.data('remote-target')).load(remote, null, function(responseTxt, statusTxt, xhr) {
    //                 if (statusTxt == "success") {
    //                     var remoteTarget = $($this.data('remote-target'));
    //                     var links = remoteTarget.find('.modal-content').find('a');
    //                     links.each(function (i, v) {
    //                         $(v).attr('href', '#').attr('style', 'color:#ccc;');
    //                     });
    //                     remoteTarget.find('#editor_tools').hide();
    //                     remoteTarget.find('.content-container .withExtra').removeClass('withExtra');
    //                     remoteTarget.find('.content-container .extra').hide();
    //                 }
    //             });
    //         }
    //     });
    }).data('opendataDataTable')
        .attachFilterInput(stateSelect)
        .loadDataTable();   
});
