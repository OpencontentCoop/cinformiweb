
{if $attribute.has_content}
<ul class="list-unstyled">
{foreach $attribute.content as $file}
  <li>
    <a href={concat( 'ocmultibinary/download/', $attribute.contentobject_id, '/', $attribute.id,'/', $attribute.version , '/', $file.filename ,'/file/', $file.original_filename|urlencode )|ezurl}>
      <span title="{$file.original_filename|wash( xhtml )}"><i class="fa fa-download"></i> Scarica il file</span>
      <small>{$file.original_filename|wash( xhtml )} ({$file.filesize|si( byte )})</small>
    </a>
  </li>
{/foreach}
</ul>
{/if}