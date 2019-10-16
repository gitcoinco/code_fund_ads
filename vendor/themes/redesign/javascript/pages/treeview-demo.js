"use strict";

// Treeview Demo
// =============================================================
var treeviewDemo = {
  init: function init() {
    this.bindUIActions();
  },
  bindUIActions: function bindUIActions() {
    // event handlers
    this.handleTreeview();
  },
  handleTreeview: function handleTreeview() {
    // sample data
    var sampleData = [{
      text: 'Parent 1',
      href: '#parent1',
      nodes: [{
        text: 'Child 1',
        href: '#child1',
        tags: ['2'],
        nodes: [{
          text: 'Grandchild 1',
          href: '#grandchild1'
        }, {
          text: 'Grandchild 2',
          href: '#grandchild2'
        }]
      }, {
        text: 'Child 2',
        href: '#child2'
      }]
    }, {
      text: 'Parent 2',
      href: '#parent2'
    }, {
      text: 'Parent 3',
      href: '#parent3',
      tags: ['6']
    }, {
      text: 'Parent 4',
      href: '#parent4'
    }, {
      text: 'Parent 5',
      href: '#parent5',
      tags: ['New']
    }]; // init treeview

    $('#treeview01').treeview({
      data: sampleData,
      showBorder: false,
      showTags: true,
      showIcon: false,
      emptyIcon: 'fa',
      collapseIcon: 'fa fa-caret-down text-muted',
      expandIcon: 'fa fa-caret-right text-muted',
      selectedColor: 'inherit',
      selectedBackColor: '#f5f5f5',
      onhoverColor: '#f5f5f5'
    });
    $('#treeview02').treeview({
      data: sampleData,
      showBorder: false,
      showTags: true,
      showIcon: false,
      showCheckbox: true,
      emptyIcon: 'fa',
      collapseIcon: 'fa fa-caret-down text-muted mr-1',
      expandIcon: 'fa fa-caret-right text-muted mr-1',
      uncheckedIcon: 'far fa-square fa-lg text-muted mr-3',
      checkedIcon: 'fa fa-check-square fa-lg text-primary mr-3',
      selectable: false,
      selectedColor: 'inherit',
      selectedBackColor: '#f5f5f5',
      onhoverColor: '#f5f5f5'
    });
  }
};
treeviewDemo.init();