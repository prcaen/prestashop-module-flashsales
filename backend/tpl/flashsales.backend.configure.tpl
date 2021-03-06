<link rel="stylesheet" href="{$module_dir}/backend/css/{$module_name}.backend.configure.style.css">
<script src="{$module_dir}/backend/js/{$module_name}.backend.configure.script.js"></script>
<h2>{$display_name}</h2>
<form action="{$action}" method="post" enctype="multipart/form-data">
	<fieldset>
		<legend><img src="{$module_dir}/logo.gif" alt="" title="">{l s='Settings' mod=$module_name}</legend>
		<fieldset style="font-size: 1em; margin-bottom: 1em">
			<p><b>{l s='Define settings and place this URL in crontab or call it manually daily:' mod=$module_name}</b></p>
			<ul>
				<li>{l s='Update next period' mod=$module_name} <b>{$cron_url}&action=1</b></li>
				<li>{l s='Update current period' mod=$module_name} <b>{$cron_url}&action=2</b></li>
				<li>{l s='Clear all cache' mod=$module_name} <b>{$cron_url}&action=3</b></li>
			</ul>
		</fieldset>
		{foreach from=$configs item=config name=configLoop}
			<label for="{$config.name}">{$config.title}</label>
			<div class="margin-form">
				{if $config.type == 'boolean'}
					<input type="radio" name="{$config.name}" id="{$config.name}_yes" value="1" {if $config.value == 1}checked="checked"{/if} />
					<label for="{$config.name}_yes" class="t"><img src="../img/admin/enabled.gif" alt="{l s='Enabled' mod=$module_name}" title="{l s='Enabled' mod=$module_name}"></label>
					<input type="radio" name="{$config.name}" id="{$config.name}_no" value="0" {if $config.value == 0}checked="checked"{/if} />
					<label for="{$config.name}_no" class="t"><img src="../img/admin/disabled.gif" alt="{l s='Disabled' mod=$module_name}" title="{l s='Disabled' mod=$module_name}"></label>
				{elseif $config.type == 'text'}
					<input type="text" name="{$config.name}" id="{$config.name}" value="{$config.value}" />
				{elseif $config.type == 'image'}
					<input type="file" name="{$config.name}" id="{$config.name}" />
				{elseif $config.type == 'select'}
					<select name="{$config.name}" id="{$config.name}">
					{foreach $config.options item=option name=configOptionsLoop}
						<option value="{$option.value}" {if $config.value eq $option.value}selected="selected"{/if}>{$option.name}</option>
					{/foreach}
					</select>
				{elseif $config.type == 'time'}
					<select name="{$config.name}_hours" id="{$config.name}">
					{section name=hours start=0 loop=24 step=1}
						{$smarty.section.hours.index}
						{assign var='value' value=$config.value / 3600}
					  <option value="{$smarty.section.hours.index}" {if $value|string_format:"%d" eq $smarty.section.hours.index}selected="selected"{/if}>{twoDigits number=$smarty.section.hours.index}</option>
					{/section}
					</select> h 
					<select name="{$config.name}_mins">
					{section name=mins start=0 loop=60 step=1}
						{assign var='value' value={secondsToMinutes time=$config.value % 3600}}
					  <option value="{$smarty.section.mins.index}" {if $value|string_format:"%d" eq $smarty.section.mins.index}selected="selected"{/if}>{twoDigits number=$smarty.section.mins.index}</option>
					{/section}
					</select>
				{/if}
				{if isset($config.help)}
					<em class="help">{$config.help}</em>
				{/if}
				<div class="clear">&nbsp;</div>
			</div>
		{/foreach}
		<center><input type="submit" name="submit_{$module_name}" value="{l s='Save' mod=$module_name}" class="button"></center>
	</fieldset>
</form>