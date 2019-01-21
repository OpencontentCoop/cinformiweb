{if or($openpa.control_menu.show_extra_menu, $show_left, is_set($extra_template))}
  <div class="extra">

    {if or(is_set($extra_template), $openpa.control_menu.show_extra_menu)}
      {if and(is_set($extra_template), $extra_template|ne(false()))}
        {include uri=$extra_template}
      {else}
        {include uri='design:openpa/full/parts/section_left_extra.tpl'}
      {/if}
    {/if}

    {if $show_left}
      <div class="nav-section" id="subnav">
        {if count($tree_menu.children)|gt(0)}
          {if $openpa.control_menu.side_menu.root_node}
            <h2 class="openpa-widget-title"><span>{$openpa.control_menu.side_menu.root_node.name|wash()}</span></h2>
          {/if}
          <ul class="Linklist Linklist--padded Treeview Treeview--default js-Treeview u-text-r-xs">
            {foreach $tree_menu.children as $menu_item}
              {include name=side_menu uri='design:menu/side_menu_item.tpl' menu_item=$menu_item current_node=$node recursion=1}
            {/foreach}
          </ul>
        {/if}
      </div>
    {/if}

    {include uri='design:openpa/full/parts/back_to_main_content.tpl'}
  </div>
  {ezpagedata_set('has_sidemenu', true())}
{/if}

