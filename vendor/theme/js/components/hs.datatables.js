/**
 * Datatables wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;
(function ($) {
  'use strict';

  $.HSCore.components.HSDatatables = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      paging: true
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Datatables wrapper.
     *
     * @param String selector (optional)
     * @param Object config (optional)
     *
     * @return jQuery pageCollection - collection of initialized items.
     */

    init: function (selector, config) {
      this.collection = selector && $(selector).length ? $(selector) : $();
      if (!$(selector).length) return;

      this.config = config && $.isPlainObject(config) ?
        $.extend({}, this._baseConfig, config) : this._baseConfig;

      this.config.itemSelector = selector;

      this.initDatatables();

      return this.pageCollection;
    },

    initDatatables: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          $info = $this.data('dt-info'),
          $search = $this.data('dt-search'),
          $entries = $this.data('dt-entries'),
          $pagination = $this.data('dt-pagination'),
          $detailsInvoker = $this.data('dt-details-invoker'),

          pageLength = $this.data('dt-page-length'),
          isResponsive = Boolean($this.data('dt-is-responsive')),
          isSelectable = Boolean($this.data('dt-is-selectable')),
          isColumnsSearch = Boolean($this.data('dt-is-columns-search')),
          isColumnsSearchTheadAfter = Boolean($this.data('dt-is-columns-search-thead-after')),
          isShowPaging = Boolean($this.data('dt-is-show-paging')),
          scrollHeight = $this.data('dt-scroll-height'),

          paginationClasses = $this.data('dt-pagination-classes'),
          paginationItemsClasses = $this.data('dt-pagination-items-classes'),
          paginationLinksClasses = $this.data('dt-pagination-links-classes'),
          paginationNextClasses = $this.data('dt-pagination-next-classes'),
          paginationNextLinkClasses = $this.data('dt-pagination-next-link-classes'),
          paginationNextLinkMarkup = $this.data('dt-pagination-next-link-markup'),
          paginationPrevClasses = $this.data('dt-pagination-prev-classes'),
          paginationPrevLinkClasses = $this.data('dt-pagination-prev-link-classes'),
          paginationPrevLinkMarkup = $this.data('dt-pagination-prev-link-markup'),

          selectAllControl = $this.data('dt-select-all-control'),

          table = $this.DataTable({
            pageLength: pageLength,
            responsive: isResponsive,
            scrollY: scrollHeight ? scrollHeight : '',
            scrollCollapse: scrollHeight ? true : false,
            paging: isShowPaging ? isShowPaging : config.paging,
            drawCallback: function (settings) {
              var api = this.api(),
                info = api.page.info();

              $($info).html(
                'Showing ' + (info.start + 1) + ' to ' + info.end + ' of ' + info.recordsTotal + ' Entries'
              );
            }
          }),

          info = table.page.info(),
          paginationMarkup = '';

        if (scrollHeight) {
          $(table.context[0].nScrollBody).mCustomScrollbar({
            scrollbarPosition: 'outside'
          });
        }

        $($search).on('keyup', function () {
          table.search(this.value).draw();
        });

        if (isColumnsSearch == true) {
          table.columns().every(function () {
            var that = this;

            if (isColumnsSearchTheadAfter == true) {
              $('.dataTables_scrollFoot').insertAfter('.dataTables_scrollHead');
            }

            $('input', this.footer()).on('keyup change', function () {
              if (that.search() !== this.value) {
                that
                  .search(this.value)
                  .draw();
              }
            });

            $('select', this.footer()).on('change', function () {
              if (that.search() !== this.value) {
                that
                  .search(this.value)
                  .draw();
              }
            });
          });
        }

        $($entries).on('change', function () {
          var val = $(this).val();

          table.page.len(val).draw();

          // Pagination
          if (isShowPaging == true) {
            $self.pagination($pagination, table, paginationClasses, paginationItemsClasses, paginationLinksClasses, paginationNextClasses, paginationNextLinkClasses, paginationNextLinkMarkup, paginationPrevClasses, paginationPrevLinkClasses, paginationPrevLinkMarkup, val);
          }
        });

        if (isSelectable == true) {
          $($this).on('change', 'input', function () {
            $(this).parents('tr').toggleClass('checked');
          })
        }

        // Pagination
        if (isShowPaging == true) {
          $self.pagination($pagination, table, paginationClasses, paginationItemsClasses, paginationLinksClasses, paginationNextClasses, paginationNextLinkClasses, paginationNextLinkMarkup, paginationPrevClasses, paginationPrevLinkClasses, paginationPrevLinkMarkup, info.pages);
        }

        // Details
        $self.details($this, $detailsInvoker, table);

        // Select All
        if (selectAllControl) {
          $self.selectAll(selectAllControl, table, $this);
        }

        //Actions
        collection = collection.add($this);
      });
    },

    pagination: function (target, table, pagiclasses, pagiitemclasses, pagilinksclasses, paginextclasses, paginextlinkclasses, paginextlinkmarkup, pagiprevclasses, pagiprevlinkclasses, pagiprevlinkmarkup, pages) {
      var info = table.page.info(),
        paginationMarkup = '';

      for (var i = 0; i < info.recordsTotal; i++) {
        if (i % info.length == 0) {
          paginationMarkup += i / info.length == 0 ? '<li class="' + pagiitemclasses + ' active"><a id="datatablePaginationPage' + (i / info.length) + '" class="' + pagilinksclasses + '" href="javascript:;" data-dt-page-to="' + (i / info.length) + '">' + ((i / info.length) + 1) + '</a></li>' : '<li class="' + pagiitemclasses + '"><a id="' + target + (i / info.length) + '" class="' + pagilinksclasses + '" href="javascript:;" data-dt-page-to="' + (i / info.length) + '">' + ((i / info.length) + 1) + '</a></li>';
        }
      }

      $('#' + target).html(
        '<ul class="' + pagiclasses + '">\
				<li class="' + pagiprevclasses + '">\
				  <a id="' + target + 'Prev" class="' + pagiprevlinkclasses + '" href="javascript:;" aria-label="Previous">' + pagiprevlinkmarkup + '</a>\
				</li>' +
        paginationMarkup +
        '<li class="' + paginextclasses + '">\
				  <a id="' + target + 'Next" class="' + paginextlinkclasses + '" href="javascript:;" aria-label="Next">' + paginextlinkmarkup + '</a>\
				</li>\
				</ul>'
      );

      $('#' + target + ' [data-dt-page-to]').on('click', function () {
        var $page = $(this).data('dt-page-to'),
          info = table.page.info();

        $('#' + target + ' [data-dt-page-to]').parent().removeClass('active');
        $(this).parent().addClass('active');
        table.page($page).draw('page');
      });

      $('#' + target + 'Next').on('click', function () {
        var $currentPage = $('#' + target + ' [data-dt-page-to]').parent();

        table.page('next').draw('page');

        if ($currentPage.next().find('[data-dt-page-to]').length) {
          $('#' + target + ' [data-dt-page-to]').parent().removeClass('active');
          $currentPage.next().find('[data-dt-page-to]').parent().addClass('active');
        } else {
          return false;
        }
      });

      $('#' + target + 'Prev').on('click', function () {
        var $currentPage = $('#' + target + ' [data-dt-page-to]').parent();

        table.page('previous').draw('page');

        if ($currentPage.prev().find('[data-dt-page-to]').length) {
          $('#' + target + ' [data-dt-page-to]').parent().removeClass('active');
          $currentPage.prev().find('[data-dt-page-to]').parent().addClass('active');
        } else {
          return false;
        }
      });
    },

    format: function (value) {
      return value;
    },

    details: function (el, invoker, table) {
      if (!invoker) return;

      //Variables
      var $self = this;

      $(el).on('click', invoker, function () {
        var tr = $(this).closest('tr'),
          row = table.row(tr);

        if (row.child.isShown()) {
          row.child.hide();
          tr.removeClass('opened');
        } else {
          row.child($self.format(tr.data('details'))).show();
          tr.addClass('opened');
        }
      });
    },

    selectAll: function (selectallcontrol, table, target) {
      $(selectallcontrol).on('click', function () {
        var rows = table.rows({'search': 'applied'}).nodes();

        $('input[type="checkbox"]', rows).prop('checked', this.checked);
      });

      $(target).find('tbody').on('change', 'input[type="checkbox"]', function () {
        if (!this.checked) {
          var el = $(selectallcontrol).get(0);

          if (el && el.checked && ('indeterminate' in el)) {
            el.indeterminate = true;
          }
        }
      });
    }
  };
})(jQuery);
