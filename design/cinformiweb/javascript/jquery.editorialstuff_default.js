$(document).ready(function () {
    var touch = false;
    if (window.Modernizr) {
        touch = Modernizr.touch;
    }
    if (!touch) {
        $("body").on("mouseenter", ".has-tooltip", function () {
            var el;
            el = $(this);
            if (el.data("tooltip") === undefined) {
                el.tooltip({
                    placement: el.data("placement") || "top",
                    container: el.data("container") || "body"
                });
            }
            return el.tooltip("show");
        });
        $("body").on("mouseleave", ".has-tooltip", function () {
            return $(this).tooltip("hide");
        });
    }
    /*if (jQuery.fn.tabdrop !== undefined) {
        $('.nav-pills, .nav-tabs').tabdrop();
    }*/

    $('#dashboard-filters-container').find('select').change( function() {
        $('#dashboard-search-button').click();
    });

    $('[data-load-remote]').on('click', function (e) {
        e.preventDefault();
        var $this = $(this);
        $($this.data('remote-target')).html('<em>Loading...</em>');
        var remote = $this.data('load-remote');
        if (remote) {
            $($this.data('remote-target')).load(remote, null, function(responseTxt, statusTxt, xhr) {
                if (statusTxt == "success") {
                    var remoteTarget = $($this.data('remote-target'));
                    var links = remoteTarget.find('.modal-content').find('a');
                    links.each(function (i, v) {
                        $(v).attr('href', '#').attr('style', 'color:#ccc;');
                    });
                    remoteTarget.find('#editor_tools').hide();
                    remoteTarget.find('.content-container .withExtra').removeClass('withExtra');
                    remoteTarget.find('.content-container .extra').hide();
                }
            });
        }
    });


    $(document).on('change', 'select.inline_edit_state', function () {
        var that = $(this);
        var selected = $(this).find('option:selected');
        that.hide();
        that.parent().append( '<i id="inline-loading-'+selected.val()+'" class="fa fa-gear fa-spin"></i>' );
        $.ajax({
            url: selected.data('href'),
            data: {'Ajax': true},
            method: 'GET',
            success: function(data){
                $('#inline-loading-' + selected.val()).remove();
                if ( data.result == 'error' ) {
                    that.parent().append( '<p>'+data.error_message+'</p>' );
                }
                that.show();
            }
        });
    });
});
